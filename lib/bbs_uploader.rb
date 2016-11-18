require "qiniu"
require "bbs_uploader/version"

module BbsUploader
  # Your code goes here...
  IMAGE_URL_REGEXP = /http:\/\/.*[jpg|png|jpeg]$/

  IMAGE_FILE_REGEXP = /.*[jpg|png|jpeg|gif|bmp]$/

  module FileType
    IMAGE = 'image'.freeze

    FILE = 'file'.freeze
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
      {
          access_key: "79WvzAxvV-nOEX7m0PERzwR0Lhm-FDHriz2-QdAN",
          secret_key: "4wwnWNU16n9uVK8DHRW6qO61b2gls3aSduHswkvc",
          bucket: "bss-image",
          bucket_domain: "ognvcf5x6.bkt.clouddn.com"
      }.merge(options)
    end

    def upload_file(file_path, file_type = FileType::FILE)
      Qiniu.establish_connection! access_key: self.qiniu[:access_key],
                                  secret_key: self.qiniu[:secret_key]

      key = if file_type == FileType::FILE
              "bbs_file/#{File.basename(file_path)}"
            elsif file_type == FileType::IMAGE
              "bbs_image/#{File.basename(file_path)}"
            end

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

      if code == 200
        file_url = "http://#{self.qiniu[:bucket_domain]}/#{result['key']}"

        puts "上传成功! \n链接为: #{file_url}"

        file_url
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

        puts "\nmarkdown 链接: #{markdown_image_link(image_url)}"

        image_url
      else
        puts '不是图片文件，请选择重新选择！！'
      end
    end

    def markdown_image_link(image_url)
      if image_url && image_url.is_a?(String) && IMAGE_URL_REGEXP.match(image_url)
        "![](#{image_url})"
      else
        ''
      end
    end

    # 根据目录下指定目录下的文件，将文件上传到七牛上
    #
    # @note 注意文件需要按照文件目录的自然顺序
    def generate_markdown_format(dir)
      content = ''
      files = []

      `ls #{dir}`.split('\n').map { |filename| files << "#{dir}/#{filename}" }

      files.each do |file|
        content <<  markdown_image_link(upload_image(file)) + "\n"
      end

      puts content

      content
    end
  end
end
