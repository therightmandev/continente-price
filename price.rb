require "faraday"

same_price_products = []
different_price_products = []

File.readlines('products', chomp: true).each do |line|
  product_url, saved_price = line.split(',')
  saved_price = saved_price.to_f

  # get current price
  response = Faraday.get(product_url)
  exit if not response.success?

  html = response.body

  re = /"price":"([0-9]+\.[0-9][0-9])"/
  found = re.match(html)
  current_price = $1.to_f

  if current_price == saved_price
    same_price_products << [product_url, saved_price]
  else
    different_price_products << [product_url, saved_price, current_price]
  end
end

puts
puts '-----------'
puts '|Different|'
puts '-----------'
different_price_products.each do |url, saved_price, current_price|
  print "#{url} #{saved_price}€ -> #{current_price}€"
  puts
end

puts
puts
puts

puts '------'
puts '|Same|'
puts '------'
same_price_products.each do |url, price|
  print "#{url} #{price}€"
  puts
end


