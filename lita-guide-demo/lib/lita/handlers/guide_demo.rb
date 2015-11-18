module Lita
  module Handlers
    class GuideDemo < Handler
      # insert handler code here
      route(/^echo\s+(.+)/, :echo, help: { "echo TEXT" => "Echoes back TEXT." })

      def echo(response)
        response.reply(response.matches)
      end

      Lita.register_handler(self)
    end
  end
end
