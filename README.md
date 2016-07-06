# Invoice Scrapper

Project that aims to authomatize invoice extraction from different providers, so that it helps in accountability, and tax burocracy.

## Pepephone Invoice Scrapper
It downloads the invoices to your local drive and prints the ammounts of each of them

### How to install
You will need to have installed
 - docker
 - ruby
 - selenium ruby gem
 	- gem install selenium-webdriver -v 2.53.0

Copy the secrets.yml.sample to secrets.yml and replace its values.

Create a downloads folder.

### How to run
First run the docker-compose that will start a chrome selenium browser

```bash
docker-compose up
```

After that run the pepephone_invoice_scrapper.rb script

```bash
ruby pepephone_invoice_scrapper.rb
```
