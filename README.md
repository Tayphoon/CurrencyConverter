[![CI Status](http://img.shields.io/travis/Tayphoon/CurrencyConverter.svg?style=flat)](https://travis-ci.org/Tayphoon/CurrencyConverter)
[![codecov.io](https://codecov.io/gh/Tayphoon/CurrencyConverter/branch/development/graphs/badge.svg)](https://codecov.io/gh/Tayphoon/CurrencyConverter/branch/development)

# Currency converter

Currency converter sample which download and update rates every 1 second using API
https://revolut.duckdns.org/latest?base=EUR.

List all currencies from the endpoint (one per row). Each row has an input where you
can enter any amount of money. When you tap on currency row it should slide to top and its
input becomes first responder. When you’re changing the amount the app must simultaneously
update the corresponding value for other currencies.
