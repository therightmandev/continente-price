require "faraday"
require "nokogiri"


JORDAN = "https://www.continente.pt/produto/pasta-de-dentes-anti-caries-jordan-6939789.html"

puts "Jordan: #{JORDAN}"

response = Faraday.get(JORDAN)

exit if not response.success?

puts 'Successfully fetched page'

html = response.body

# TODO: extract price

doc = Nokogiri::HTML(html)

re = /"price":"([0-9]+\.[0-9][0-9])"/

if re.match?(html)
  puts "FOUND!!!"
end

found = re.match(html)

puts 'Found:', $1

i = $1.to_i
puts 'to_i:', i, i.class
