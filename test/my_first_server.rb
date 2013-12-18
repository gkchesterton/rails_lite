require 'webrick'

root = File.expand_path '~/johnfellman/rails_lite/'

server = WEBrick::HTTPServer.new Port: 8080, DocumentRoot: root



server.mount_proc '/' do |req, res|
	res.content_type = 'text/text'
	res.body = 'holy shit it works'
end

trap('INT') { server.shutdown }

server.start