#!/usr/bin/env ruby

require 'open3'
require 'net/http'
require 'json'
require 'net/smtp'

i = 1
email = 'enteremail.here'

while 1 do
	i += 1

	address = ''
	privkey = ''
	stdin, stdout, stderr = Open3.popen3('vanitygen -1 1')
	vanity = stdout.read
	
	vanity.each_line do |line|
		if line.include? 'Address:'
			address = line.split(' ').last
		elsif line.include? 'Privkey:'
			privkey = line.split(' ').last
		end
	end

	response = JSON.parse(Net::HTTP.get(URI.parse('http://btc.blockr.io/api/v1/address/info/'+address)))
	puts response
	result = response['data']['balance']

	if response['status'] != 'success'
	
		message = <<MESSAGE_END
From: Bitcoin Searcher <#{email}>
To: Vivien Leroy <#{email}>
Subject: OMG banni de blockr :'(

Banni de blockr.io :'( au bout de #{i.to_s} iterations
MESSAGE_END
		Net::SMTP.start('localhost') do |smtp|
			smtp.send_message message, email, email
		end
	else
		if result > 0
			message = <<MESSAGE_END
From: Bitcoin Searcher <#{email}>
To: Vivien Leroy <#{email}>
Subject: OMG une adresse valide

Sisi tavu y'a une adresse valide : 

Iteration : #{i.to_s}
Adresse : #{address}
Privkey : #{privkey}
Balance : #{result}
MESSAGE_END
			Net::SMTP.start('localhost') do |smtp|
				smtp.send_message message, email, email
			end
		end
	end
end
