Class = require 'lib/class'
Event = require 'lib/knife.event'
push  = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/util'

require 'src/ui/scoreboard'
require 'src/ui/textbox'

require 'src/statemachine'
require 'src/states/basestate'
require 'src/states/statestack'
require 'src/states/game/start'
require 'src/states/game/blind'

require 'src/entity/card'
require 'src/entity/hand'
require 'src/entity/deck'


CARDW   = 71
CARDH   = 95
SCOREBOARD_W = 156
SCOREBOARD_H = 32

gCardCoverSheet = love.graphics.newImage('assets/images/balatro-back.png')
gCardSheet      = love.graphics.newImage('assets/images/balatro-deck.png')
gLogo           = love.graphics.newImage('assets/images/balatro-logo.png')
gScoreBoard     = love.graphics.newImage('assets/images/balatro-score-board.png')
gCardCover  = GenerateQuads(gCardCoverSheet,CARDW,CARDH)
gCard       = GenerateQuads(gCardSheet,CARDW,CARDH)

COVER_BACK  = 1
COVER_FRONT = 2
-- rank enum
RANK2 = 1
RANK3 = 2
RANK4 = 3
RANK5 = 4
RANK6 = 5
RANK7 = 6
RANK8 = 7
RANK9 = 8
RANKX = 9
RANKJ = 10
RANKQ = 11
RANKK = 12
RANKA = 13
-- suit enum
SPADE   = 4
CLUB    = 2
DIAMOND = 3
HEART   = 1

VW      = 1280 -- vertual width
VH      = 720  -- virtual height
WIDTH   = 1280 -- real width
HEIGHT  = 720  -- real height

gFonts = {
    ['small'] = love.graphics.newFont('assets/fonts/font.ttf', 8)
  , ['medium'] = love.graphics.newFont('assets/fonts/font.ttf', 16)
  , ['large'] = love.graphics.newFont('assets/fonts/font.ttf', 32)
}
gBackground = love.graphics.newImage('assets/images/background.png')

-- hand type string
HAND_TYPE = {
    "T.B.D"
  , "High card"
  , "Pair"
  , "Two pair"
  , "Three of a kind"
  , "Straight"
  , "Flush"
  , "Full house"
  , "Four of a kind"
  , "Straight flush"
}

-- type-based score
SCORES = {
    {base=5  , multiplier=1}  -- high card
  , {base=10 , multiplier=2}  -- pair
  , {base=20 , multiplier=2}  -- two pair
  , {base=30 , multiplier=3}  -- three of a kind
  , {base=30 , multiplier=4}  -- straight
  , {base=35 , multiplier=4}  -- flush
  , {base=40 , multiplier=4}  -- full house
  , {base=60 , multiplier=7}  -- four of a kind
  , {base=100, multiplier=8}  -- straight flush
}

ANTE_BASE = {
    300   -- 1
  , 800   -- 2
  , 2000  -- 3
  , 5000  -- 4
  , 11000 -- 5
  , 20000 -- 6
  , 35000 -- 7
  , 50000 -- 8
}

BLIND_MULT = {
    1.0  -- small blind
  , 1.5  -- big blind
  , 2.0  -- boss blind
}

BLIND_SMALL = 1
BLIND_BIG   = 2
BLING_BOSS  = 3



-- card state
CARD_UNUSED = 0
CARD_PLAYED = 1
CARD_ONHAND = 2
CARD_POINTR = 3
CARD_SELECT = 4