Basil.respond_to('nyan') {

  exec 'nyancat'

}.description = 'nyans'

Basil.respond_to(/(.+)/) {
	if (@match_data[1] != 'nyan')
		require 'rubygems'
		require 'typhoeus'
		require 'json'
		
		request = Typhoeus::Request.new("http://refuntdhack.phpfogapp.com/index.php", :method => :post, :params => {:message => @match_data[1], :userid => 2})
		hydra = Typhoeus::Hydra.new
		hydra.queue(request)
		hydra.run
		
		says request.response.body
	else
		exec 'nyancat'
	end
}.description = 'finds people'

Basil.respond_to(/login (.+)/) {
	#ping conv api
}.description = 'logs in a user'



