class Game
  NOT_STARTED=0
  PREP=1
  STARTED=2

  @@verbs = [
    "walk",
    "stumble",
    "careen",
    "topple",
    "trot",
    "limp",
    "scamper",
    "hike",
    "step",
    "promenade",
    "stroll",
    "sprint",
    "dart",
    "dash",
    "scoot",
    "tear",
    "rush",
    "trek",
    "march",
    "prance",
    "dive",
    "meander",
    "lumber",
    "roam"
  ]

  @@places = [
    "a non-descript room",
    "the great plains of Rackthor",
    "your mom's bedroom",
    "the bathroom",
    "a nuclear testing facility",
    "the backroom at Staples",
    "the set of Two and a Half Men"
  ]

  @@weapons = [
    "rolled up newspapers",
    "laser pistols",
    "javalins",
    "cricket paddles",
    "fly swatters",
    "missle launchers",
    "spoons"
  ]

  @@enemies = [
    "killer robots",
    "crocodiles",
    "cute kittens",
    "bar stools",
    "jukeboxes",
    "ninjas"
  ]

  attr_reader :status

  def initialize
    @status = NOT_STARTED
  end

  def start
    @status = STARTED
  end

  def quest_opening
    "You #{rand_verb} into #{rand_place}. You are confronted by #{rand(2..1000)} #{rand_enemy} holding #{rand_weapons}."
  end

  private

  def rand_verb
    @@verbs[rand(@@verbs.count)]
  end

  def rand_place
    @@places[rand(@@places.count)]
  end

  def rand_enemy
    @@enemies[rand(@@enemies.count)]
  end

  def rand_weapons
    @@weapons[rand(@@weapons.count)]
  end
end
