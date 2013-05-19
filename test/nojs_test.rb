# -*- coding: utf-8 -*-
require 'test/unit'
require 'rack/test'
require 'rack-nojs'

class Test::Unit::TestCase
  include Rack::Test::Methods
end

class TestApp
  def call(env)
    [
      200,
      { 'Content-Type' => 'text/html' },
      ['<html><head></head><body><script type="text/javascript" src="//castanet.kiban.paperboy.co.jp/castanet.js"></script></body></html>']
    ]
  end
end

class NojsTest < Test::Unit::TestCase
  def app
    Rack::Builder.new {
      map "/" do
        use ::Rack::Nojs
        run TestApp.new
      end
    }.to_app
  end

  def test_castanet
    get '/'
    assert last_response.body.include? "castanet"
  end

  def test_castanet_with_mobile
    get '/', {}, {'HTTP_USER_AGENT' => 'DoCoMo/2.0 P903i'}
    assert !last_response.body.include?("castanet")
  end
end
