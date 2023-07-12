# README

# Install

run 
```
bundle install
```

# Database setup

run `db:seed` to generate default doorkeeper application

and run `rails console` to get application's uid and secret
```
app = Doorkeeper::Application.first
app.uid    # show below us CLIENT_ID
app.secret # show below us CLIENT_SECRET
```
# Data migration

this project also provide rake to fetch data from hacker-new

### extract and export

```
rails hacker_news:extract_and_export\[:start_id, :fetch_count, :file_name\]
```

- `start_id`: default is 1, the hacker-new item id
- `fetch_count`: default is 100, the fetch count of items
- `file_name`: default is `start_id-(start_id+fetch_count)`

this command will output the data to json file in `/data`

```
rails hacker_news:transform_and_load\[:file_name\]
```

- `file_name`: the file you want to load

this command will load the data to database

# Update CronJob

run
```
bundle exec whenever --update-crontab
```
to update the cronjob