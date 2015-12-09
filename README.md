# lita-sharleen

A multi-talented adaptation of the [Lita chat-bot](https://www.lita.io/)

## Quick start

The following steps will load a virtual machine with the necessary installation files

1. Install [Vagrant](https://www.vagrantup.com/)
1. Install [VirtualBox](https://www.virtualbox.org/)
1. `git clone https://github.com/severest/lita-sharleen`
1. `cd lita-sharleen`
1. `vagrant up` - Grab some coffee, this will take a some time.
1. `vagrant ssh`
1. `lita-dev`
1. For testing purposes, you should probably activate the `:shell` adapter in `workspace/lita_config.rb` and comment out the `:slack` one
1. `lita start`

You will require the following environment variables:

* `SLACK_LITA_TOKEN`: token provided by Slack to connect to the Lita integration
* `MASHAPE_TOKEN`: API key for mashape.com


## APIs Used

* https://market.mashape.com/andruxnet/random-famous-quotes
* https://market.mashape.com/community/urban-dictionary
* http://www.omdbapi.com/
