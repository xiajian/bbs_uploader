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

## Usage

**命令行使用:**

使用指南： 

```
Usage: bbs_uploader [options]
    -i, --input-file [file]          Input file can be URL, image file or other file
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
```

![](http://ognvcf5x6.bkt.clouddn.com/bbs_image/test.jpg)

**编程使用:** 

```
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

```

然后，就祝你安好！！！

> PS: 思考 网盘以及 CDN 在部署的上区别。 CDN 内容分发，网盘就是云存储。 这就不明白，SB！！

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake false` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/xiajian/bbs_uploader. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).