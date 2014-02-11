ai = require './ai/average'
Board = require './Board'

random = (from, to) ->
  (parseInt Math.random() * (to - from + 1), 10) + from

init = ->
  board = new Board
  total = 9
  c1 = random 2, 4

  c2 =
    if c1 is 4 then random 2, 3
    else if c1 is 2 then random 3, 4
    else random 2, 4

  c3 = total - c1 - c2
  [c1, c2, c3].forEach (count, index) ->
    block = index + 1
    while count
      x = random 0, 3
      y = random 0, 3
      unless board.board[y][x]
        board.board[y][x] = block
        count -=1

  board

test = ->
  board = init()

  gameloop = ->
    nextBlock = random 1, 3
    direction = ai board, nextBlock
    options = board.move direction, nextBlock
    point = board.point()
    board = options[random 0, options.length - 1]
    if board
      return gameloop()
    else
      return point

  gameloop()

sum = 0
for i in [0...600]
  sum += test()

console.log "point: #{sum / 600}"
