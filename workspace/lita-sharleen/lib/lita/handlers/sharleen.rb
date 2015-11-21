require_relative 'greetings'
require_relative 'game'

module Lita
  module Handlers
    class Sharleen < Handler
      @@game = Game.new
      def initialize(robot)
        super(robot)
      end

      # routes

      route(/^echo\s+(.+)/, :echo, help: { "echo TEXT" => "Echoes back TEXT." })
      route(/start game/, :start_game)
      route(/sharleen/, :comeback)
      route(/^define\s+(.+)/, :define, help: { "define TEXT" => "Uses UrbanDictionary to define a word or phrase" })

      def echo(response)
        response.reply(response.matches)
      end

      def start_game(response)
        if @@game.status == Game::STARTED
          response.reply('game has already started')
        end
        response.reply('starting...')
        @@game.start
      end

      def comeback(response)
        http_response = http.post do |req|
          req.url 'https://andruxnet-random-famous-quotes.p.mashape.com/cat=movies'
          req.headers['X-Mashape-Key'] = ENV['MASHAPE_TOKEN']
          req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
          req.headers['Accept'] = 'application/json'
        end

        data = MultiJson.load(http_response.body)
        response.reply(data["quote"])
      end

      def define(response)
        http_response = http.get do |req|
          req.url 'https://mashape-community-urban-dictionary.p.mashape.com/define'
          req.headers['X-Mashape-Key'] = ENV['MASHAPE_TOKEN']
          req.headers['Accept'] = 'application/json'
          req.params['term'] = response.args.join(' ')
        end

        data = MultiJson.load(http_response.body)
        if data["list"].count > 0
          definition = data["list"][0]
          response.reply(definition["word"] + ": " + definition["definition"])
        else
          response.reply("No definition found, sorry guy")
        end
      end


      # events

      on :connected, :greet

      def greet(payload)
        robot.send_message('general', "That's right Billy I'm baaaaaaaaack")
      end

      Lita.register_handler(self)
    end
  end
end
