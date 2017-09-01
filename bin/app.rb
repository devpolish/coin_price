require 'mechanize'
require 'colorize'
coins = %w{ bitcoin dash ethereum }
url = 'https://www.worldcoinindex.com/coin'
mechanize = Mechanize.new
btc_prices = []
eth_prices = []
dash_prices = []
total = [btc_prices, eth_prices, dash_prices] 
Signal.trap("INT") do
  puts "Bye"
  unless total.all?(&:empty?)
    puts "Creating reports at reports folder ...".red
    file = File.new('reports/report.txt')
    sleep 3
    puts "Bye"
    exit
  end
end

loop do
  coins.each do |coin|
    page = mechanize.get("#{url}/#{coin}")
    price = page.search('.span-coinprice').first.children.to_s.split[1]
    puts "#{coin.capitalize}: $#{price}".green
    case coin
      when coin == 'bitcoin'
        btc_prices << coin
      when coin == 'ethereum'
        eth_prices << coin
      when coin == 'dash'
        dash_prices << coin
    end
  end
  puts "Checking new prices...".red
  sleep 10
end
