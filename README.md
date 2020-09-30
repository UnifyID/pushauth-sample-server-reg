# PushAuthDemo

This is a sample Rails application for demonstrating basic PushAuth multi-factor authentication.
See [here](https://blog.unify.id/2020/07/17/the-power-of-pushauth/) for some background.

### Functionality

- Log in to website with username, password, and PushAuth-provided multi-factor authentication
- Access control based on login status
- Log out


### Getting Started

First, install Ruby and the project dependencies.
Here are Mac/Linux instructions:

```
# Install RVM
\curl -sSL https://get.rvm.io | bash -s stable
# note: after this, either restart your terminal or run the source command that the above will print

# Install Ruby
rvm install 2.7.1
rvm use --default 2.7.1

# Install project dependencies
bundle install

# Install yarn and update yarn packages
brew install yarn
yarn install --check-files
```

Then, initialize the database:

```
$ bundle exec rails db:migrate
```


Next, run `rails credentials:edit` and enter your UnifyID PushAuth API key in the following format:

```
unifyid:
  basic_username: <basic auth username for /users/trust webhook endpoint>
  basic_password: <basic auth password for /users/trust webhook endpoint>
  server_api_key: <your_key_goes_here>
```

Finally, fire up the dev server!

```
$ bundle exec rails server
```

You're good to go! Swing over to [localhost:3000](http://localhost:3000/) to see the demo!
