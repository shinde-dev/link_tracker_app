# Link Tracker App

## Dependencies
* Ruby version : 3.3.0
* Rails Version : 7.1.3.4

## Setup and start the applicaton

### Set Environment Variables
```
$ source .env
```
### Install Dependencies
```
$ gem install bundler && bundle install
```

### Setup database
```
$ rails db:create db:migrate
```

### Run the server
```
$ rails s
```

### Run the Test Suit
```
$ rspec
```

### Run the rubocop
```
$ rubocop
```

## Manually Testing APIs
* Import postman collection added at root directory with file name LinkTrackerApp.postman_collection.json
* Change postman collection parameters  as per your local DB values

## API - CREATE STORE URL

### Request
```
/api/v1/store_urls

{
    "client_id": 1,
    "url": "https://google.com"
}
```

## API - GET STORE URL

### Request
```
/api/v1/store_url/:tracking_code
{
    "tracking_code": "tracking_code"
}
```


## Future Enhancements
- Support for metadata like geo-location, source etc.
- Link expiration functionality
- Background Jobs with Sidekiq for tasks like UrlValidator
- Ratelimiting on redirect url hits or different deployment probably Serverless
