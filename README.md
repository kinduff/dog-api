![dogdog](https://cloud.githubusercontent.com/assets/1270156/19244552/67e751ba-8ee2-11e6-9b6e-3a6e1b307db4.png)

# Dog API
This is a Sinatra based application that provides dog facts through an API endpoint.

## Usage
The following list represents the endpoints currently available in the Dog API.

| Endpoint     | Description  | Parameters
| ------------ | ------------ | ----------
| `/api/facts` | Returns an object with dog facts | `?number=5`

## Install
First make sure you have the following dependencies installed.

- Ruby greater than 2.3.0
- SQLite3

Go ahead and clone this repository and install the dependencies.

```
bundle install
```

After that you'll need to setup your database, run the following command to run migrations.

```
rake db:migrate
```

And finally, fill out your database with the latest dog facts included in the `db/seeds.rb` file.

```
rake db:seed
```

Run the application by running the following command.

```
rake server
```

Or just `rake` by it self. The application should now be running in `http://localhost:4567`.

## Testing
There are basic tests included in this application using RSpec. To run the existing tests simply run.

```
rake test
```

It will use your development database, make sure you ran before executing the migration and seed commands.

## Why you made this?
There's a [Cat API](http://catfacts-api.appspot.com) that returns cat facts. I like cats but I like dogs more. Equilibrium must exists.

![dogcatlove](https://cloud.githubusercontent.com/assets/1270156/19246933/63523a6e-8eee-11e6-99c0-da53774db639.png)
