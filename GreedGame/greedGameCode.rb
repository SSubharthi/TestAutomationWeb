class DiceSet
    attr_reader :values
  
    def initialize
      @values = []
    end
  
    def roll(number_of_dice)
      @values = Array.new(number_of_dice) { rand(1..6) }
    end
  end
  
  def score(dice)
    counts = Hash.new(0)
    dice.each { |die| counts[die] += 1 }
  
    total_score = 0
    scoring_dice = []
    non_scoring_dice = dice.dup
  
    counts.each do |value, count|
      if count >= 3
        if value == 1
          total_score += 1000
          scoring_dice += [value] * 3
        else
          total_score += value * 100
          scoring_dice += [value] * 3
        end
        non_scoring_dice -= [value] * 3
        counts[value] -= 3
      end
    end
  
    total_score += counts[1] * 100
    scoring_dice += [1] * counts[1]
    non_scoring_dice -= [1] * counts[1]
  
    total_score += counts[5] * 50
    scoring_dice += [5] * counts[5]
    non_scoring_dice -= [5] * counts[5]
  
    [total_score, scoring_dice, non_scoring_dice]
  end
  
  class GreedGame
    def initialize(player_names)
      @players = Hash[player_names.map { |name| [name.strip, 0] }]
    end
  
    def play
      dice_set = DiceSet.new
  
      while @players.any? { |_, total_score| total_score < 3000 }
        @players.each do |player, total_score|
          puts "#{player}'s turn:"
          turn_points = 0
          available_dice = 5
  
          loop do
            dice_set.roll(available_dice)
            rolled_dice = dice_set.values
            puts "Rolled: #{rolled_dice.join(', ')}"
  
            points, scoring_dice, non_scoring_dice = score(rolled_dice)
  
            if points == 0
              puts "#{player} rolled zero points! No points for this turn."
              turn_points = 0
              break
            end
  
            turn_points += points
            puts "#{player} has #{turn_points} points this turn."
            puts "Scoring dice: #{scoring_dice.join(', ')}"
            puts "Non-scoring dice: #{non_scoring_dice.join(', ')}"
  
            scoring_dice_count = scoring_dice.size
            available_dice = 5 - scoring_dice_count
  
            print "#{player}, do you want to keep rolling? (yes/no) "
            answer = gets.chomp.downcase
  
            if answer != "yes"
              break
            end
          end
  
          if turn_points >= 300
            @players[player] += turn_points
            puts "#{player} ends their turn with #{turn_points} total points."
          else
            puts "#{player} ends their turn with 0 total points (less than 300)."
          end
        end
      end
  
      winner = @players.max_by { |_, score| score }
      puts "#{winner[0]} wins with a score of #{winner[1]}!"
    end
  end
  

  %{The below code is for an example use}
  puts "Enter player names separated by commas:"
  player_names = gets.chomp.split(",").map(&:strip)
  game = GreedGame.new(player_names)
  game.play  