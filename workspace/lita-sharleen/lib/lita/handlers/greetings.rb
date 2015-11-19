class Greetings
  @@list = [
    "well HELLLOOOOOO there",
    "howdy hoooo",
    "huh?",
    "come with me if you want to live"
  ]

  def self.getone
    index = rand(@@list.count)
    str = @@list[index]
  end
end
