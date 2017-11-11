require "./lib/connect_four"

describe Game do
  let(:player_1){Game::Player.new("Andrey")}
  let(:player_2){Game::Player.new("Maxim")}
  before(:each){pole = Game::Pole.new}

   context "starting" do
     it "create a pole" do
        expect(pole.array).to eql([["*","*","*","*","*","*","*"],["*","*","*","*","*","*","*"],["*","*","*","*","*","*","*"],
        ["*","*","*","*","*","*","*"],["*","*","*","*","*","*","*"],["*","*","*","*","*","*","*"]])
        expect(pole.full).to be false
     end

     it "show a pole" do
       output = capture(:stdout) do
         pole.show
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
         expect(pole[2][0]).to eql("☢")
       end

       it "add symbol ⚙" do
         player_2.xod(3,player_2.symbol)
         expect(pole.array[3][0]).to eql("⚙")
         player_2.xod(3,player_2.symbol)
         expect(pole.array[3][1]).to eql("⚙")
       end
     end

     context "it player can't turn" do
       it "don't add symbol ☢" do
         expect(player_1.xod(2,player_1.symbol)).to be false
       end
     end

     context "it Game Over" do
       it "draw" do
         pole.full = true
         expect(player_1.draw?).to be true
         expect(player_2.draw?).to be true
       end

       it "player_1 won" do
         pole.array = [["*","☢","*","*","*","*","*"],["*","☢","*","*","*","*","*"],["*","☢","*","*","*","*","*"],
         ["*","☢","*","*","*","*","*"],["*","*","*","*","*","*","*"],["*","*","*","*","*","*","*"]]
         expect(player_1.won?).to be true
         expect(player_2.won?).to be false
       end

       it "player_2 won" do
         pole.array = [["*","⚙","*","*","*","*","*"],["*","⚙","*","*","*","*","*"],["*","⚙","*","*","*","*","*"],
         ["*","⚙","*","*","*","*","*"],["*","*","*","*","*","*","*"],["*","*","*","*","*","*","*"]]
         expect(player_2.won?).to be true
         expect(player_1.won?).to be false
       end
     end
   end

end
