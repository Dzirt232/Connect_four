class Game
  $first_player = false

  class Player
    attr_accessor :name, :symbol
    def initialize(name)
      @name = name
      @symbol = $first_player ? "⚙" : "☢"
      $first_player = true if !$first_player
    end

    def xod(position, symbol)
      for i in 0..5 do
        if $pole.array[i][position] == "*"
          $pole.array[i][position] = symbol
          $pole.show
          return true
        end
      end
      $pole.show
      return false
    end

    def draw?
      if $pole.array.all? {|x| x.all? { |e| e != "*" }}
        $pole.full = true
        return true
      end
      return false
    end

    def victory(name)
      puts "\n=================================="
      print "\n           Player #{name} won!\n\n"
      puts "=================================="
    end

    def won?
      d_horizontal = 0
      d_vertical = 0
      p = 0
      for i in 0..5 do
        l = 0
        for j in 0..6 do
          l = $pole.array[i][j] == @symbol ? (l + 1) : 0
          if l == 4
            victory(@name)
            return true
          end
          if $pole.array[i][j] == @symbol
            if p == 0
              d_horizontal = j
              d_vertical = i
              p += 1
            elsif p != 0
              if j == d_horizontal + 1 && i == d_vertical + 1
                d_horizontal = j
                d_vertical = i
                p += 1
              end
            end
          elsif $pole.array[i][j] != @symbol && p != 0
            if j == d_horizontal + 1 && i == d_vertical + 1
              p = 0
            end
          end
          if p == 4
            victory(@name)
            return true
          end
        end
      end
      for j in 0..6 do
        k = 0
        for i in 0..5 do
          k = $pole.array[i][j] == @symbol ? (k + 1) : 0
          if k == 4
            victory(@name)
            return true
          end
        end
      end
      return false
    end
  end

  class Pole
  attr_accessor :array, :full
    def initialize
      @full = false
      @array = []
      6.times{
        @array << ["*","*","*","*","*","*","*"]
      }
    end

    def show
      print "\u2501"*33
      @array.reverse.each {|string| print "\n\u2503\t#{string.join("  ")}\t\u2503\n"}
      print "\u2501"*33
      print "\n        0  1  2  3  4  5  6\n"
    end
  end

  def self.game_over?(player_1,player_2)
    return true if player_1.won? || player_2.won? || player_1.draw?
    return false
  end

  def self.start
    $first_player = false
    $pole = Pole.new
    $pole.show
    puts
    puts "Enter name a first player: "
    player_1 = Player.new(gets.chomp.strip)
    puts "Enter name a second player: "
    player_2 = Player.new(gets.chomp.strip)

    while true
      while true
        puts
        puts "Turn player #{player_1.name}."
        puts "Enter your position: "
        break if player_1.xod(gets.chomp.strip.to_i,player_1.symbol)
      end
      break if self.game_over?(player_1,player_2)
      while true
        puts
        puts "Turn player #{player_2.name}."
        puts "Enter your position: "
        break if player_2.xod(gets.chomp.strip.to_i,player_2.symbol)
      end
      break if self.game_over?(player_1,player_2)
    end
  end
end

Game.start
