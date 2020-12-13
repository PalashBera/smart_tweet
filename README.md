# Welcome to Smart Tweet

This is a simple tweet application using Ruby on Rails.

## Application Description
- User can signup into this application by providing first name, last name, email, password and password confirmation.
- After successful signup user will receive one confirmation mail. Without confirmation of mail use couldn't login into application. If user didn't receive any confirmation mail then user can send this instruction to email by using *Send confirmation* link.
- User can login into this application by providing email and password. In case user forgot the password, then user can recover password by using *Reset password* link. Here use will receive one instruction mail and reset the password.
- User can create tweet by clicking *New tweet* button.
- User can edit tweet by clicking *Edit* link of respective tweet.
- User can delete tweet by clicking *Delete* link of respective tweet.
- User can search tweet by using search form.
- User can logout from application by clicking *Log Out* link at the navbar.
- User can update account information by clicking *Account* at the navbar.
- If user wants to change email address then use has to confirm this email address again. For this confirmation user will receive one email after changing email address.
- Home page user can see all the tweets.
- After login user can see his/her own timeline by clicking on *Timeline* link in the navbar.
- By clicking on *Comment icon*, user can see all the comments of a tweet. If user is logged in then user can comment to this tweet also.
- By clicking on *Retweet icon*, user can retweet the tweet.

## Technical Stack
- Ruby v2.7.2
- Rails v6.1.0
- MySQL v8.0

## Development Setup

- Set up Ruby on Rails on linux based OS. For installation please follow this link [Ruby and Rails Installation Guide](https://gorails.com/setup/ubuntu/18.04). Here please use **RVM** for the development.
- Clone this repository into your system. [Clone GitHub Repository Guide](https://help.github.com/en/github/creating-cloning-and-archiving-repositories/cloning-a-repository)
- Open terminal and go to the project path.
- It will create one gemset for this project. Please install bundler first. For the installation of bundler please run this bellow command.
  > gem install bundler
- Install all gem by following bellow command.
  > bundle install
- Copy and paste database.yml.sample file inside config folder then rename this file to **database.yml**.
- Install Mysql for database into this OS. Please follow this link [Mysql Installation Guide](https://www.digitalocean.com/community/tutorials/how-to-install-mysql-on-ubuntu-18-04).
- Start rails server with bellow command.
    > rails server
- Visit [http://localhost:3000](http://localhost:3000). You are on home page.

## Testing

Rspec is there for unit testing. After running test suite one test coverage will be generated inside the project folder. For this test coverage *SimpleCov* has been used.

![test coverage](https://github.com/PalashBera/smart_tweet/blob/master/vendor/coverage.png?raw=true)
