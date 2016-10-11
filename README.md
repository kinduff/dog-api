![dogdog](https://cloud.githubusercontent.com/assets/1270156/19244552/67e751ba-8ee2-11e6-9b6e-3a6e1b307db4.png)

# Dog API
This is the Dog API and it provides dog facts as a service dogdog :dog:

**Live endpoint:** `NOT AVAILABLE`

| Path         | Description  | Parameters
| ------------ | ------------ | ----------
| `/api/facts` | Returns an object with dog facts | `?number=5`

## Host it yourself
First make sure you have the following dependencies installed.

- Ruby greater than 2.3.0
- SQLite3

Go ahead and clone this repository.

```
git clone git@github.com:kinduff/dog-api.git
```

Then install the dependencies.

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

## Why you made this?
There's a [Cat API](http://catfacts-api.appspot.com) that returns cat facts. I like cats but I like dogs more. Equilibrium must exists.

## Sources
Lot's of places, I'll list them tomorrow, mom.
