Gem::Specification.new do |s|
  s.name        = 'ld25_a_game_of_pirates'
  s.version     = '0.1.0'
  s.executables << 'a-game-of-pirates'
  s.summary     = "2D Top Down Pirate Game"
  s.description = "A 2D Pirate game made for Ludum Dare 25"
  s.authors     = ["Calum Gilchrist"]
  s.email       = 'me@calumgilchrist.co.uk'
  s.files       = ["a-game-of-pirates"]
  s.files       += Dir['lib/*.rb'] + Dir['media/*.png']
  s.homepage    =
    'https://github.com/homelinen/ld25-a-game-of-pirate'
end
