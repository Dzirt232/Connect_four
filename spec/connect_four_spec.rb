require 'active_support/core_ext/kernel/reporting'
require "./lib/connect_four"

describe Game do
  let(:player_1){Game::Player.new("Andrey")}
  let(:player_2){Game::Player.new("Maxim")}
  before(:each){$pole = Game::Pole.new}

  before(:each) do
    $first_player = false
    player_1
    player_2
  end
   context "starting" do
     it "create a pole" do
        expect($pole.array).to eql([["*","*","*","*","*","*","*"],["*","*","*","*","*","*","*"],["*","*","*","*","*","*","*"],
        ["*","*","*","*","*","*","*"],["*","*","*","*","*","*","*"],["*","*","*","*","*","*","*"]])
        expect($pole.full).to be false
     end

     it "show a pole" do
      output = capture(:stdout) do
        $pole.show
      end
      expect(output).to be_instance_of String
     end

     it "creating a players with right names" do
       expect(player_1.name).to eql("Andrey")
       expect(player_2.name).to eql("Maxim")
     end

     it "creating a players with right symbols" do
       expect(player_1.symbol).to eql("☢")
       expect(player_2.symbol).to eql("⚙")
     end
   end

   describe Game::Player do
     context "it player can turn" do
       it "add symbol ☢" do
         player_1.xod(2,player_1.symbol)
         expect($pole.array[0][2]).to eql("☢")
       end

       it "add symbol ⚙" do
         player_2.xod(3,player_2.symbol)
         expect($pole.array[0][3]).to eql("⚙")
         player_2.xod(3,player_2.symbol)
         expect($pole.array[1][3]).to eql("⚙")
       end
     end

     context "it player can't turn" do
       it "don't add symbol ☢" do
         player_2.xod(3,player_2.symbol)
         player_2.xod(3,player_2.symbol)
         player_2.xod(3,player_2.symbol)
         player_2.xod(3,player_2.symbol)
         player_2.xod(3,player_2.symbol)
         player_2.xod(3,player_2.symbol)
         expect(player_1.xod(3,player_1.symbol)).to be false
       end
     end

     context "it Game Over" do
       it "draw" do
         $pole.array.map! { |e| e.map! { |e| e = "☢" } }
         expect(player_1.draw?).to be true
         expect(player_2.draw?).to be true
       end

       it "player_1 won" do
         $pole.array = [["*","☢","*","*","*","*","*"],["*","☢","*","*","*","*","*"],["*","☢","*","*","*","*","*"],
         ["*","☢","*","*","*","*","*"],["*","*","*","*","*","*","*"],["*","*","*","*","*","*","*"]]
         expect(player_1.won?).to be true
         expect(player_2.won?).to be false
       end

       it "player_2 won" do
         $pole.array = [["*","⚙","*","*","*","*","*"],["*","⚙","*","*","*","*","*"],["*","⚙","*","*","*","*","*"],
         ["*","⚙","*","*","*","*","*"],["*","*","*","*","*","*","*"],["*","*","*","*","*","*","*"]]
         expect(player_2.won?).to be true
         expect(player_1.won?).to be false
       end

       it "player_2 won via diagonal" do
         $pole.array = [["*","⚙","*","*","*","*","*"],["*","*","⚙","*","*","*","*"],["*","*","*","⚙","*","*","*"],
         ["*","*","*","*","⚙","*","*"],["*","*","*","*","*","*","*"],["*","*","*","*","*","*","*"]]
         expect(player_2.won?).to be true
         expect(player_1.won?).to be false
       end
     end
   end

end
