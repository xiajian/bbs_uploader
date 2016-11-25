# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bbs_uploader/version'

Gem::Specification.new do |spec|
  spec.name          = "bbs_uploader"
  spec.version       = BbsUploader::VERSION
  spec.authors       = ["xiajian"]
  spec.email         = ["jhqy2011@gmail.com"]

  spec.summary       = %q{简单分装七牛上传的图片类}
  spec.description   = %q{简单封装七牛的图片上传，并演示如何创建 gem 的功能}
  spec.homepage      = "https://github.com/xiajian/bbs_uploader"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = ['bbs_uploader']
  spec.require_paths = ["lib"]
  spec.required_ruby_version = '>= 1.9.3'

  spec.add_dependency "qiniu", "~> 6.8.1"
  spec.add_dependency "hashie", "~> 3.4.4"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
end
