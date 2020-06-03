# PushAuthDemo

This is a sample Rails application for demoing basic PushAuth multi-factor authentication.
See [here](https://unifyid.atlassian.net/wiki/spaces/~592566634/pages/400654353/PushAuth+Reference+Project#Website-with-Basic-Login-Plus-Mobile-App) for a description of the project.

### Functionality

- Log in to website with username, password, and PushAuth-provided multi-factor authentication
- Access control based on login status
- Log out


### Getting Started

First, install Ruby and the project dependencies:

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

Now, create a user:

```
$ bundle exec rails console
> User.create(:username => "{username}", :password => "{password}").save
> exit
```

Note that the username should match the client ID that will be used for the PushAuth API.

Finally, fire up the dev server and connect!

```
$ bundle exec rails server &
$ open http://localhost:3000/
```
