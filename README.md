# BbsUploader

源自每周的分享: http://bbs.yundianjia.net/d/111-2-ruby-gem。 

BbsUploader 是上传图片到七牛云的简单 demo，用来演示，如何编写一个 gem。 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bbs_uploader'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bbs_uploader
    
或者单独安装: 

```
\curl -sSL https://get.rvm.io | bash -s stable # 安装 rvm，ubuntu/centos 上的 ruby 版本太老
source /etc/profile.d/rvm.sh   # 运行 rvm.sh 的脚本 
rvm install 2.3.1
rvm 2.3.1  --default
gem install bundler
gem install bbs_uploader # gem 的创建时通过 bundler 创建的
```

## Usage

**命令行使用:**

使用指南： 

```
Usage: bbs_uploader [options]
    -i, --input-file [file]          Input file can be URL, image file or other file
    -d [directory],                  Input directory must be a directory
        --input-directory
    -h, --help                       Show this message
    -v, --version                    Print version
```

调用实例： 

```
$ bbs_uploader ~/Downloads/test.jpg
D, [2016-11-15T16:31:52.906672 #30130] DEBUG -- : Query bss-image hosts Success: {"ttl"=>86400, "http"=>{"io"=>["http://iovip.qbox.me"], "up"=>["http://up.qiniu.com", "http://upload.qiniu.com", "-H up.qiniu.com http://183.136.139.16"]}, "https"=>{"io"=>["https://iovip.qbox.me"], "up"=>["https://up.qbox.me"]}}
图片上传成功!
链接为: http://ognvcf5x6.bkt.clouddn.com/bbs_image/test.jpg
markdown 链接: ![](http://ognvcf5x6.bkt.clouddn.com/bbs_image/test.jpg)

$ bin/bbs_uploader http://xiajian.github.io/assets/images/dongxiang.png
下载文件的地址: http://xiajian.github.io/assets/images/dongxiang.png
/tmp/dongxiang.png
D, [2016-11-21T09:57:43.758140 #49294] DEBUG -- : Query bss-image hosts Success: {"ttl"=>86400, "http"=>{"io"=>["http://iovip.qbox.me"], "up"=>["http://up.qiniu.com", "http://upload.qiniu.com", "-H up.qiniu.com http://183.136.139.16"]}, "https"=>{"io"=>["https://iovip.qbox.me"], "up"=>["https://up.qbox.me"]}}
上传成功!
链接为: http://ognvcf5x6.bkt.clouddn.com/bbs_image/dongxiang.png

markdown 链接: ![](http://ognvcf5x6.bkt.clouddn.com/bbs_image/dongxiang.png)

$ bin/bbs_uploader ~/Downloads/pi
bbs_uploader ~/Downloads/pi
上传目录: /Users/xiajian/Downloads/pi
D, [2016-11-25T11:10:33.153753 #23592] DEBUG -- : Query bss-image hosts Success: {"ttl"=>86400, "http"=>{"io"=>["http://iovip.qbox.me"], "up"=>["http://up.qiniu.com", "http://upload.qiniu.com", "-H up.qiniu.com http://183.136.139.16"]}, "https"=>{"io"=>["https://iovip.qbox.me"], "up"=>["https://up.qbox.me"]}}
上传成功!
链接为: http://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.001.jpeg
markdown 链接: ![](http://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.001.jpeg)
D, [2016-11-25T11:10:33.718394 #23592] DEBUG -- : Query bss-image hosts Success: {"ttl"=>86400, "http"=>{"io"=>["http://iovip.qbox.me"], "up"=>["http://up.qiniu.com", "http://upload.qiniu.com", "-H up.qiniu.com http://183.136.139.16"]}, "https"=>{"io"=>["https://iovip.qbox.me"], "up"=>["https://up.qbox.me"]}}
上传成功!
链接为: http://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.002.jpeg
markdown 链接: ![](http://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.002.jpeg)
D, [2016-11-25T11:10:33.866917 #23592] DEBUG -- : Query bss-image hosts Success: {"ttl"=>86400, "http"=>{"io"=>["http://iovip.qbox.me"], "up"=>["http://up.qiniu.com", "http://upload.qiniu.com", "-H up.qiniu.com http://183.136.139.16"]}, "https"=>{"io"=>["https://iovip.qbox.me"], "up"=>["https://up.qbox.me"]}}
上传成功!
链接为: http://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.003.jpeg
markdown 链接: ![](http://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.003.jpeg)
D, [2016-11-25T11:10:34.111550 #23592] DEBUG -- : Query bss-image hosts Success: {"ttl"=>86400, "http"=>{"io"=>["http://iovip.qbox.me"], "up"=>["http://up.qiniu.com", "http://upload.qiniu.com", "-H up.qiniu.com http://183.136.139.16"]}, "https"=>{"io"=>["https://iovip.qbox.me"], "up"=>["https://up.qbox.me"]}}
上传成功!
链接为: http://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.004.jpeg
markdown 链接: ![](http://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.004.jpeg)
D, [2016-11-25T11:10:34.344260 #23592] DEBUG -- : Query bss-image hosts Success: {"ttl"=>86400, "http"=>{"io"=>["http://iovip.qbox.me"], "up"=>["http://up.qiniu.com", "http://upload.qiniu.com", "-H up.qiniu.com http://183.136.139.16"]}, "https"=>{"io"=>["https://iovip.qbox.me"], "up"=>["https://up.qbox.me"]}}
上传成功!
链接为: http://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.005.jpeg
markdown 链接: ![](http://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.005.jpeg)
D, [2016-11-25T11:10:34.590605 #23592] DEBUG -- : Query bss-image hosts Success: {"ttl"=>86400, "http"=>{"io"=>["http://iovip.qbox.me"], "up"=>["http://up.qiniu.com", "http://upload.qiniu.com", "-H up.qiniu.com http://183.136.139.16"]}, "https"=>{"io"=>["https://iovip.qbox.me"], "up"=>["https://up.qbox.me"]}}
上传成功!
链接为: http://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.006.jpeg
markdown 链接: ![](http://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.006.jpeg)
D, [2016-11-25T11:10:34.804324 #23592] DEBUG -- : Query bss-image hosts Success: {"ttl"=>86400, "http"=>{"io"=>["http://iovip.qbox.me"], "up"=>["http://up.qiniu.com", "http://upload.qiniu.com", "-H up.qiniu.com http://183.136.139.16"]}, "https"=>{"io"=>["https://iovip.qbox.me"], "up"=>["https://up.qbox.me"]}}
上传成功!
链接为: http://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.007.jpeg
markdown 链接: ![](http://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.007.jpeg)
D, [2016-11-25T11:10:35.049650 #23592] DEBUG -- : Query bss-image hosts Success: {"ttl"=>86400, "http"=>{"io"=>["http://iovip.qbox.me"], "up"=>["http://up.qiniu.com", "http://upload.qiniu.com", "-H up.qiniu.com http://183.136.139.16"]}, "https"=>{"io"=>["https://iovip.qbox.me"], "up"=>["https://up.qbox.me"]}}
上传成功!
链接为: http://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.008.jpeg
markdown 链接: ![](http://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.008.jpeg)
D, [2016-11-25T11:10:35.285335 #23592] DEBUG -- : Query bss-image hosts Success: {"ttl"=>86400, "http"=>{"io"=>["http://iovip.qbox.me"], "up"=>["http://up.qiniu.com", "http://upload.qiniu.com", "-H up.qiniu.com http://183.136.139.16"]}, "https"=>{"io"=>["https://iovip.qbox.me"], "up"=>["https://up.qbox.me"]}}
上传成功!
链接为: http://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.009.jpeg
markdown 链接: ![](http://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.009.jpeg)
D, [2016-11-25T11:10:35.523276 #23592] DEBUG -- : Query bss-image hosts Success: {"ttl"=>86400, "http"=>{"io"=>["http://iovip.qbox.me"], "up"=>["http://up.qiniu.com", "http://upload.qiniu.com", "-H up.qiniu.com http://183.136.139.16"]}, "https"=>{"io"=>["https://iovip.qbox.me"], "up"=>["https://up.qbox.me"]}}
上传成功!
链接为: http://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.010.jpeg
markdown 链接: ![](http://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.010.jpeg)
D, [2016-11-25T11:10:35.807353 #23592] DEBUG -- : Query bss-image hosts Success: {"ttl"=>86400, "http"=>{"io"=>["http://iovip.qbox.me"], "up"=>["http://up.qiniu.com", "http://upload.qiniu.com", "-H up.qiniu.com http://183.136.139.16"]}, "https"=>{"io"=>["https://iovip.qbox.me"], "up"=>["https://up.qbox.me"]}}
上传成功!
链接为: http://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.011.jpeg
markdown 链接: ![](http://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.011.jpeg)
D, [2016-11-25T11:10:36.077758 #23592] DEBUG -- : Query bss-image hosts Success: {"ttl"=>86400, "http"=>{"io"=>["http://iovip.qbox.me"], "up"=>["http://up.qiniu.com", "http://upload.qiniu.com", "-H up.qiniu.com http://183.136.139.16"]}, "https"=>{"io"=>["https://iovip.qbox.me"], "up"=>["https://up.qbox.me"]}}
上传成功!
链接为: http://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.012.jpeg
markdown 链接: ![](http://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.012.jpeg)
生成的图片的链接: http://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.001.jpeg\nhttp://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.002.jpeg\nhttp://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.003.jpeg\nhttp://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.004.jpeg\nhttp://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.005.jpeg\nhttp://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.006.jpeg\nhttp://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.007.jpeg\nhttp://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.008.jpeg\nhttp://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.009.jpeg\nhttp://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.010.jpeg\nhttp://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.011.jpeg\nhttp://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.012.jpeg
上传链接地址:
![](http://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.001.jpeg)
![](http://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.002.jpeg)
![](http://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.003.jpeg)
![](http://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.004.jpeg)
![](http://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.005.jpeg)
![](http://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.006.jpeg)
![](http://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.007.jpeg)
![](http://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.008.jpeg)
![](http://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.009.jpeg)
![](http://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.010.jpeg)
![](http://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.011.jpeg)
![](http://ognvcf5x6.bkt.clouddn.com/bbs_image/pi.012.jpeg)
```

![](http://ognvcf5x6.bkt.clouddn.com/bbs_image/test.jpg)


![](http://ognvcf5x6.bkt.clouddn.com/bbs_image/dongxiang.png)

**编程使用:** 

```
# 选项传递的 Hash 值可以是任意形态的，实现中利用 hashie 抹平了差异
BbsUploader.qiniu = {
  access_key: 'your access key',
  secret_key: 'your secret key',
  bucket: "your bucket",
  bucket_domain: "your application domain"
}

# 超集方法：可以上传任意的文件
BbsUploader.upload '~/Downloads/test.jpg'
BbsUploader.upload 'http://xiajian.github.io/assets/images/dongxiang.png'

BbsUploader.upload_image '~/Downloads/test.jpg'
BbsUploader.upload_file '~/Downloads/install.php'

# 添加将整个目录按照自然的顺序上传上去
BbsUploader.upload_with_directory '~/Downloads/pi'
```

然后，就祝君安好！！！

> PS: 思考 网盘以及 CDN 在部署的上区别。 CDN 内容分发，网盘就是云存储。 这就不明白，SB！！ 上传的 js 以及 css 文件，直接下载获取，不如 专业的 cdn 资源的获取的速度快，所以，专业的 CDN 系统还是有特殊的优化处理的。

## 后续开发

1. 可以添加一个全局配置七牛的 key 以及相关的功能， 配置文件，可以放在 `~/.bbs_uploader` 中，文件的解析，可以参考 dotenv 中关于文件的解析方法(`Parser`)。
2. 可能需要添加新的 qiniu sdk 的接口的调用。
3. 控制日志输出的等级


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake false` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/xiajian/bbs_uploader. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).