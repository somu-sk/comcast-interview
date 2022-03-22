(1..50).each do |basket|
  Basket.create!(capacity: rand(2..27), fill_rate: 0.0)
end
