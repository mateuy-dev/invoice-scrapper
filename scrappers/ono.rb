require "selenium-webdriver"
require 'yaml'

#Waiting for selenium to start
sleep 5

secrets = YAML.load_file('secrets.yml')


url="https://www.ono.es/clientes/registro/login/"
invoices_url="https://www.ono.es/clientes/facturacion/facturas-emitidas/"
email = secrets["ono"]["email"]
password = secrets["ono"]["password"]

email_id = '#user_username'
pass_id = '#user_password'

# Downloads not working on firefox
# driver = Selenium::WebDriver.for :remote, :url => "http://localhost:4444/wd/hub", :desired_capabilities => :firefox
driver = Selenium::WebDriver.for :remote, :url => "http://selenium:4444/wd/hub", :desired_capabilities => :chrome
driver.navigate.to url

# Login
email_element = driver.find_element(:css, email_id)
email_element.send_keys email
password_element = driver.find_element(:css, pass_id)
password_element.send_keys password
email_element.submit

# Member
wait = Selenium::WebDriver::Wait.new(:timeout => 10)
wait.until { driver.find_element(:css => ".tituloPerfil").displayed? }

# Invoices
driver.navigate.to invoices_url
invoice_rows = driver.find_elements(:css, ".factura-emitida")
wait.until { driver.find_element(:css => ".descargar-factura").displayed? }
sleep 5

invoice_rows.each do |invoice_row|
	fecha = invoice_row.find_element(:css, ".texto-alineacion-izq .destacado").text
	importe = invoice_row.find_element(:css, ".texto-alineacion-der .letra-mayor").text
	invoice_id = invoice_row.find_element(:css, ".MT15").text
	
	pdf_element = invoice_row.find_element(:css, ".descargar-factura")
	pdf_element.click

	price = (importe.gsub(',', '.').to_f()/1.21).round(2)

	iva = (price*0.21).round 2
	puts fecha + " | " + importe + " | " +price.to_s() +" | " + iva.to_s() + " | " + invoice_id
	
	#wait for downloads
	sleep 5
end

driver.quit