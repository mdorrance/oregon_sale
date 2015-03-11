## StoreEngine

### Getting Started

To deal with the dependencies for this project, try these instructions at your terminal:

```
rvm use 1.9.3
brew update
brew install v8
gem install therubyracer
bundle
bundle exec rake db:migrate db:test:prepare
bundle exec rspec spec
```

### Notes

[![Code Climate](https://codeclimate.com/github/jmejia/store_engine.png)](https://codeclimate.com/github/jmejia/store_engine)

An online store that recreates the good ol' days of traveling the Oregon Trail. We sell Oregon Trail adventures at <a href="http://oregonsale.herokuapp.com">oregonsale.herokuapp.com</a>. It was originally built by John Maddux, Geoff Schorkopf, and Josh Mejia.

The original assignment is at http://tutorials.jumpstartlab.com/projects/store_engine.html

This project is used as the basis of the following tutorial materials:

* [Pushing Logic Down the Stack](http://tutorials.jumpstartlab.com/topics/architecture/pushing_logic_down_the_stack.html)
