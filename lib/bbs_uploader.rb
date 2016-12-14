require "qiniu"
require "open-uri"                # 下载文件
require 'hashie'
require "bbs_uploader/version"
require "bbs_uploader/ruby_regex"

module BbsUploader
  # Your code goes here...
  IMAGE_URL_REGEXP = /http:\/\/.*(jpg|png|jpeg)$/

  IMAGE_FILE_REGEXP = /.*(jpg|png|jpeg|gif|bmp)$/

  module FileType
    IMAGE = 'image'.freeze

    FILE = 'file'.freeze
  end
  
  module Code
    SUCCESS = 200
  end

  class << self
    @@qiniu = {}

    # 初始化全局变量 @@qiniu
    def qiniu=(options)
      @@qiniu = default_options(options)
    end

    def qiniu
      @@qiniu != {} ? @@qiniu : default_options
    end

    def default_options(options = {})
      options = Hashie::Mash.new(options)
      
      Hashie::Mash.new({
          access_key: "79WvzAxvV-nOEX7m0PERzwR0Lhm-FDHriz2-QdAN",
          secret_key: "4wwnWNU16n9uVK8DHRW6qO61b2gls3aSduHswkvc",
          bucket: "bss-image",
          bucket_domain: "ognvcf5x6.bkt.clouddn.com"
      }).merge(options)
    end

    # 下载文件 - 依赖本地的 tmp 目录, 需要 `open-uri`
    #
    # 参考: http://stackoverflow.com/questions/2263540/how-do-i-download-a-binary-file-over-http
    #
    # @param {String} url - 网络上的 URL 地址
    # @param {String} file_path - 下载指定的文件路径地址
    #
    # @return {String} file_path - 文件在当前系统的中的路径
    def download(url, file_path = '')
      puts "下载文件的地址: #{url}"

      if file_path == ''.freeze
        file_path = "/tmp/#{url.scan(/.*\/([^\/]*)/).flatten[0]}"
      end

      if File.exist? file_path
        `rm -rf #{file_path}`
      end

      File.open(file_path, 'wb') do |saved_file|
        open(url, 'rb') do |read_file|
          saved_file.write(read_file.read)
        end
      end

      file_path
    rescue => e
      puts "下载文件发生异常: #{e}"

      ''
    end

    # 返回文件的状态码
    def get_file_info(key)
      establish_connection
      
      # 获取文件信息
      code, result, response_headers = Qiniu::Storage.stat(
          self.qiniu[:bucket], # 存储空间
          key # 资源名
      )
      
      code
    end

    def upload_file(file_path, file_type = FileType::FILE)
      key = if file_type == FileType::FILE
              "bbs_file/#{File.basename(file_path)}"
            elsif file_type == FileType::IMAGE
              "bbs_image/#{File.basename(file_path)}"
            end
              
      unless (code = get_file_info(key)) == Code::SUCCESS
        establish_connection
        
        put_policy = Qiniu::Auth::PutPolicy.new(
            self.qiniu[:bucket], # 存储空间
            key, # 指定上传的资源名，如果传入 nil，就表示不指定资源名，将使用默认的资源名
            3600 # token 过期时间，默认为 3600 秒，即 1 小时
        )

        uptoken = Qiniu::Auth.generate_uptoken(put_policy)

        # 调用 upload_with_token_2 方法上传
        code, result = Qiniu::Storage.upload_with_token_2(
            uptoken,
            file_path,
            key,
            nil, # 可以接受一个 Hash 作为自定义变量，请参照 http://developer.qiniu.com/article/kodo/kodo-developer/up/vars.html#xvar
            bucket: self.qiniu[:bucket]
        )
      end
      
      if code == Code::SUCCESS
        file_url = "http://#{self.qiniu[:bucket_domain]}/#{key}"

        puts "上传成功! \n链接为: #{file_url}"

        encode_url = URI.encode file_url

        puts "编码后的链接: #{encode_url}"

        encode_url
      else
        puts '上传文件失败'

        nil
      end
    rescue => e
      puts "上传发生异常: #{e}"

      nil
    end

    def upload_image(file_path)
      if file_path =~ IMAGE_FILE_REGEXP
        image_url = upload_file file_path, FileType::IMAGE

        puts "markdown 链接: #{markdown_image_link(image_url)}"

        image_url
      else
        puts '不是图片文件，请选择重新选择！！'
      end
    end

    def upload(resource = '')
      if resource =~ RubyRegex::URL
        file_path = download resource

        if file_path =~ IMAGE_FILE_REGEXP
          upload_image file_path
        else
          upload_file file_path
        end
      elsif File.exist? resource
        file_path = File.absolute_path(resource)

        if resource =~ IMAGE_FILE_REGEXP
          upload_image file_path
        else
          upload_file file_path
        end
      else
        puts "输入的文件 #{resource} 不存在，请检查后重试"
      end
    end
    
    def upload_with_directory(dir = '')
      dir = `cd #{dir}; pwd`.chomp
      return unless File.exists?(dir) && File.directory?(dir)
      
      puts "上传目录: #{dir}"
      
      files = `ls #{dir}`.split("\n").map { |filename| "#{dir}/#{filename}" }
      
      file_links = files.map { |file| upload(file) }
      
      puts "生成的图片的链接: #{file_links.join('\n')}"
      
      file_links
    end

    def markdown_image_link(image_url)
      if image_url && image_url.is_a?(String) && IMAGE_URL_REGEXP.match(image_url)
        "![](#{image_url})"
      else
        image_url
      end
    end

    # 根据目录下指定目录下的文件，将文件上传到七牛上
    #
    # @note 注意文件需要按照文件目录的自然顺序
    def generate_markdown_format(dir)
      content = upload_with_directory(dir).map { |link| markdown_image_link(link) }.join("\n")
        
      puts "上传链接地址: \n"
      puts content

      content
    end
    
    def command(options = {})
      if options[:input_file]
        upload options[:input_file]
      elsif options[:input_directory]
        generate_markdown_format options[:input_directory]
      end
    end
    
    protected
    
    def establish_connection
      Qiniu.establish_connection! access_key: self.qiniu[:access_key],
                                  secret_key: self.qiniu[:secret_key]
    end
  end
end
