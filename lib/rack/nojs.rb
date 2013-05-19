require 'rack'
require 'jpmobile'

module Rack
  class Request
    include Jpmobile::RequestWithMobile
  end

  class Nojs
    def initialize(app)
      @app = app
    end

    def call(env); dup._call(env); end

    def _call(env)
      @env = env
      req = Rack::Request.new(env)
      @status, @headers, @body = @app.call(env)
      return [@status, @headers, @body] if !html? || !req.mobile?
      response = Rack::Response.new([], @status, @headers)
      @body.each { |fragment| response.write inject(fragment) }
      @body.close if @body.respond_to?(:close)

      response.finish
    end

    private

    def html?; @headers['Content-Type'] =~ /html/; end

    def inject(response)
      response.gsub(/<script type="text\/javascript"[\w\W]*?<\/script>/, '')
    end
  end
end
