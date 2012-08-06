require 'set'

class WrongNumberOfPlayersError < StandardError ; end
class NoSuchStrategyError < StandardError ; end

ALLOWED_STRATEGIES = ["r","p","s"]

def rps_game_winner(game)
    raise WrongNumberOfPlayersError unless game.length == 2
    
    s1 = game[0][1].downcase
    s2 = game[1][1].downcase

    raise NoSuchStrategyError unless ALLOWED_STRATEGIES.include?(s1) and ALLOWED_STRATEGIES.include?(s2)

    strats = { s1 => 0, s2 => 1 }
    if s1 == s2
      return game[0]
    elsif Set.new([s1,s2]) == Set.new(["s","r"])
      return game[strats["r"]]
    elsif Set.new([s1,s2]) == Set.new(["p","r"])
      return game[strats["p"]]
    else 
      return game[strats["s"]]
    end
end

def rps_tournament_winner(tournament)
  return rps_tournament_winner_helper(tournament)
end

def rps_tournament_winner_helper(tournament)
  if tournament[0][0].class == String
    return rps_game_winner(tournament)
  else 
    return rps_game_winner([rps_tournament_winner(tournament[0]), rps_tournament_winner(tournament[1])])
  end
end