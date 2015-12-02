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
      route(/sharleen/, :comeback)
      route(/^define\s+(.+)/, :define, help: { "define TEXT" => "Uses UrbanDictionary to define a word or phrase" })

      def echo(response)
        response.reply(response.matches)
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
          response.reply(render_template('definition', word: definition["word"], definition: definition["definition"]))
        else
          response.reply("No definition found, sorry guy")
        end
      end

      # questing
      route(/^quest/, :quest)
      route(/^end quest/, :endquest)
      route(/^scores/, :scores)

      def quest(response)
        questor = response.user
        if redis.hget('quests:'+questor.id,'in_progress').nil? || redis.hget('quests:'+questor.id,'in_progress') == 'false'
          redis.hset("quests:"+questor.id,'in_progress',true)
          response.reply("Alright #{questor.name}, here's your quest: " + @@game.quest_opening)
        else
          response.reply("You're already questing bro")
        end
      end

      def endquest(response)
        redis.hset("quests:"+response.user.id,'in_progress',false)
        response.reply('Yup')
      end

      def scores(response)
        scores = {}
        r = Redis::Namespace.new('users:id', redis: Lita.redis)
        r.keys.each do |user_id|
          user = r.hgetall(user_id)
          user_quests = redis.hgetall("quests:"+user_id)
          if user_quests['score'].nil?
            redis.hset("quests:"+user_id,'score',0)
            scores[user["name"]] = 0
          else
            scores[user["name"]] = redis.hget('quests:'+user_id,'score')
          end
        end
        response.reply(render_template('scores', scores: scores))
      end

      Lita.register_handler(self)
    end
  end
end
