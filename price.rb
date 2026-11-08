require "faraday"
require "nokogiri"


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
