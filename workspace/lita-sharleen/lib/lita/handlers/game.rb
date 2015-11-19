class Game
  NOT_STARTED=0
  PREP=1
  STARTED=2

  attr_reader :status

  def initialize
    @status = NOT_STARTED
  end

  def start
    @status = STARTED
  end
end
