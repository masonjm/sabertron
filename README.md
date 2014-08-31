# Sabertron 3000

This is a demo app for calculating baseball statistics.

## Getting Started

This is a Rails app with no web-stuff. It requires Ruby > 2.0, and has been tested with Ruby 2.1.2.

The app is configured to use sqlite3 by default. If you want to use a fancier database, you'll need
to install the right gems and tweak `config/database.yml`.

1. Get the gems

    bundle install

2. Load your database

    rake db:create
    rake db:migrate
    rake db:seed

3. Use rake to run queries

    rake saber
    # or
    rake saber:batting_average:most_improved[2009,2010]
    rake saber:slugging_percentage:team[OAK,2007]
    rake saber:triple_crown[2012]