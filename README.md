# Invoice Scrapper

Project that aims to authomatize invoice extraction from different providers, so that it helps in accountability, and tax burocracy.

It can download invoices from Pepephone and Ono



## How to install

Everything is dockerized, so the only requirement is Docker.
Copy the secrets.yml.sample to secrets.yml and replace its values.
Create a downloads folder.

```bash
mkdir downloads
```

## How to run
Just execute the following commands (may take some seconds, be patient).

```bash
docker-compose run --rm scrapper ruby ono.rb
docker-compose run --rm scrapper ruby pepephone.rb
```


## Pepephone Invoice Scrapper
It downloads the invoices to your local drive and prints the ammounts of each of them

## Ono Invoice Scrapper
It downloads the invoices to your local drive and prints the ammounts of each of them

