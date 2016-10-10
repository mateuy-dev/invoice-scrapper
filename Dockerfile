FROM ruby:2.3.1
MAINTAINER mateuyabar@equinox.one

ENV INSTALL_PATH /app
RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH
COPY Gemfile Gemfile.lock pepephone_invoice_scrapper.rb ./
RUN gem install bundler && bundle install --jobs 20 --retry 5

COPY pepephone_invoice_scrapper.rb ./

CMD ["ruby", "pepephone_invoice_scrapper.rb"]