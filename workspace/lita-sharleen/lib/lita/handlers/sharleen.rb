module Lita
  module Handlers
    class Sharleen < Handler
      route(/^echo\s+(.+)/, :echo, help: { "echo TEXT" => "Echoes back TEXT." })
      route(/.*sharleen.*/, :comeback)

      def echo(response)
        response.reply(response.matches)
      end

      def comeback(response)
        response.reply('fuck you')
      end

      Lita.register_handler(self)
    end
  end
end
