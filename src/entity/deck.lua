Deck = Class{}

function Deck:init()
  self.cards = {}
  for i = 0,3 do
    for j =0,12 do
      table.insert(self.cards, Card(i,j))
    end
  end
end
