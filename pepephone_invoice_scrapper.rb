require "selenium-webdriver"
require 'yaml'

secrets = YAML.load_file('secrets.yml')


url="https://www.pepephone.com/mipepephone"
invoices_url="https://www.pepephone.com/mipepephone/movil/facturas"
email = secrets["pepephone"]["email"]
password = secrets["pepephone"]["password"]

# Downloads not working on firefox
# driver = Selenium::WebDriver.for :remote, :url => "http://localhost:4444/wd/hub", :desired_capabilities => :firefox
driver = Selenium::WebDriver.for :remote, :url => "http://localhost:4444/wd/hub", :desired_capabilities => :chrome
driver.navigate.to url

# Login
email_element = driver.find_element(:css, '#formRequestLogin #email')
email_element.send_keys email
password_element = driver.find_element(:css, '#formRequestLogin #password')
password_element.send_keys password
email_element.submit

# Member
wait = Selenium::WebDriver::Wait.new(:timeout => 10)
wait.until { driver.find_element(:css => ".hall-movil").displayed? }

# Invoices
driver.navigate.to invoices_url
invoice_rows = driver.find_elements(:css, ".facturas tbody tr")

invoice_rows.each do |invoice_row|
	mes = invoice_row.find_element(:css, ".mes span").text
	importe = invoice_row.find_element(:css, ".importe span").text
	pdf_element = invoice_row.find_element(:css, "a")
	pdf_name = pdf_element.attribute("href").gsub(/.*\//, '')
	pdf_element.click
	price = (importe.to_f()/1.21).round(2)
	iva = (price*0.21).round 2
	puts mes + " " + importe + " " +price.to_s() +" " + iva.to_s() + " "+ pdf_name
end

#wait for downloads
sleep 10

driver.quit

