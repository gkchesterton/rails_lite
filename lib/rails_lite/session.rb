require 'json'
require 'webrick'
require 'debugger'

class Session
  def initialize(req)
  	# @cookie ||= {}
  	@req = req
  	@req.cookies.each {|cookie| @cookie = JSON.parse(cookie.value) if cookie.name == '_rails_lite_app' }
  end

  def [](key)
  	@cookie[key]
  end

  def []=(key, val)
  	@cookie[key] = val
  end

  def store_session(res)
  	res.cookies << WEBrick::Cookie.new('_rails_lite_app', @cookie.to_json)
  	debugger
  end
end
