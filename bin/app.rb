require 'mechanize'
require 'colorize'
coins = %w{ bitcoin dash ethereum }
url = 'https://www.worldcoinindex.com/coin'
mechanize = Mechanize.new

loop do
  coins.each do |coin|
    page = mechanize.get("#{url}/#{coin}")
    price = page.search('.span-coinprice').first.children.to_s.split[1]
    puts "#{coin.capitalize}: $#{price}".green
  end
  puts "Checking new prices...".red
  sleep 10
end
