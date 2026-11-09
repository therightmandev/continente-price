require "faraday"

JORDAN = "https://www.continente.pt/produto/pasta-de-dentes-anti-caries-jordan-6939789.html"

response = Faraday.get(JORDAN)
exit if not response.success?
puts 'Successfully fetched page'

html = response.body

re = /"price":"([0-9]+\.[0-9][0-9])"/
found = re.match(html)
price = $1.to_f
print 'Price: ', price
puts
puts

# read url from file
url = ''

File.readlines('products', chomp: true).each do |line|
  product_url, saved_price = line.split(',')
  saved_price = saved_price.to_f
  print 'URL: ', product_url
  puts
  print 'Saved price: ', saved_price
  puts

  # get current price
  response = Faraday.get(product_url)
  exit if not response.success?
  puts 'Successfully fetched page'

  html = response.body

  re = /"price":"([0-9]+\.[0-9][0-9])"/
  found = re.match(html)
  current_price = $1.to_f
  print 'Current price: ', current_price
  puts
  if current_price == saved_price
    print '===== Same'
  else
    print '≠≠≠≠≠ Different'
  end
  puts

  puts
end

