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
        response.reply(Greetings.getone)
      end

      # events

      on :connected, :greet

      def greet(response)
        response.reply("That's right Billy I'm baaaaaaaaack")
      end

      Lita.register_handler(self)
    end
  end
end
