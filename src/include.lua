Class = require 'lib/class'
Event = require 'lib/knife.event'
push  = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/util'

require 'src/ui/pointer'
require 'src/ui/textbox'
require 'src/ui/blindpanel'
require 'src/ui/jokerslot'
require 'src/ui/text'

require 'src/statemachine'
require 'src/states/basestate'
require 'src/states/statestack'
require 'src/states/game/start'
require 'src/states/game/select'
require 'src/states/game/play'
require 'src/states/game/run'
require 'src/states/game/run_info'
require 'src/states/game/deck_info'
require 'src/states/game/message'
require 'src/states/game/shop'
require 'src/states/game/control'

require 'src/entity/card'
require 'src/entity/hand'
require 'src/entity/deck'
require 'src/entity/joker'


CARDW   = 103
CARDH   = 138
SCOREBOARD_W = 156
SCOREBOARD_H = 32

gCardJokerSheet = love.graphics.newImage('assets/images/deck-large-joker.png')
gCardCoverSheet = love.graphics.newImage('assets/images/deck-large-back.png')
gCardSheet      = love.graphics.newImage('assets/images/deck-large.png')
gCardJoker  = GenerateQuads(gCardJokerSheet,CARDW,CARDH)
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
  , ['xmedium'] = love.graphics.newFont('assets/fonts/font.ttf', 24)
  , ['large'] = love.graphics.newFont('assets/fonts/font.ttf', 32)
  , ['xlarge'] = love.graphics.newFont('assets/fonts/font.ttf', 48)
  , ['title'] = love.graphics.newFont('assets/fonts/font.ttf', 80)
}

-- hand type string
HAND_TYPE = {
    "High card"
  , "Pair"
  , "Two pair"
  , "A three"
  , "Straight"
  , "Flush"
  , "Full house"
  , "A Four"
  , "Strate flush"
}

-- type-based score
gInitScores = {
    {base=5  , mult=1, upbase=10, upmult=1}  -- high card
  , {base=10 , mult=2, upbase=15, upmult=1}  -- pair
  , {base=20 , mult=2, upbase=20, upmult=1}  -- two pair
  , {base=30 , mult=3, upbase=20, upmult=2}  -- three of a kind
  , {base=30 , mult=4, upbase=30, upmult=3}  -- straight
  , {base=35 , mult=4, upbase=15, upmult=2}  -- flush
  , {base=40 , mult=4, upbase=25, upmult=2}  -- full house
  , {base=60 , mult=7, upbase=30, upmult=3}  -- four of a kind
  , {base=100, mult=8, upbase=40, upmult=4}  -- straight flush
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
BLIND_BOSS  = 3



-- card state
CARD_UNUSED = 0
CARD_PLAYED = 1
CARD_ONHAND = 2
CARD_POINTR = 3
CARD_SELECT = 4


-- music
gSounds = {
  ['background'] = love.audio.newSource('assets/sounds/background.mp3', 'static'),
  ['card'] = love.audio.newSource('assets/sounds/card.ogg', 'static'),
  ['discard'] = love.audio.newSource('assets/sounds/discard.ogg', 'static'),
  ['play'] = love.audio.newSource('assets/sounds/play.ogg', 'static'),
  ['win'] = love.audio.newSource('assets/sounds/win.ogg', 'static'),
  ['lose'] = love.audio.newSource('assets/sounds/lose.ogg', 'static'),
}

N_CARD_HAND = 8
MAX_N_JOKER = 5
UPGRADE_HAND_PERCENT = 0.7