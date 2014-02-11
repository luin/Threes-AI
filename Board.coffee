class Board

  constructor: (anotherBoard) ->
    @board = {}
    for y in [0..3]
      for x in [0..3]
        @board[y] = {} unless @board[y]
        @board[y][x] =
          if anotherBoard then anotherBoard.board[y][x]
          else 0

  isOver: ->
    (JSON.stringify @move 'up') is (JSON.stringify @move 'down') and
    (JSON.stringify @move 'up') is (JSON.stringify @move 'left') and
    (JSON.stringify @move 'up') is (JSON.stringify @move 'right')

  move: (direction, nextBlock) ->
    newboard = new Board @
    b = newboard.board
    if direction is 'up'
      for y in [1..3]
        for x in [0..3]
          result = Board.merge b[y][x], b[y - 1][x]
          if result
            b[y][x] = 0
            b[y - 1][x] = result

    else if direction is 'down'
      for y in [2..0]
        for x in [0..3]
          result = Board.merge b[y][x], b[y + 1][x]
          if result
            b[y][x] = 0
            b[y + 1][x] = result

    else if direction is 'left'
      for x in [1..3]
        for y in [0..3]
          result = Board.merge b[y][x], b[y][x - 1]
          if result
            b[y][x] = 0
            b[y][x - 1] = result

    else if direction is 'right'
      for x in [0..2]
        for y in [0..3]
          result = Board.merge b[y][x], b[y][x + 1]
          if result
            b[y][x] = 0
            b[y][x + 1] = result

    if nextBlock
      result = []
      if direction is 'up'
        for x in [0..3]
          do ->
            testBoard = new Board newboard
            unless testBoard.board[3][x]
              testBoard.board[3][x] = nextBlock
              result.push testBoard
      else if direction is 'down'
        for x in [0..3]
          do ->
            testBoard = new Board newboard
            unless testBoard.board[0][x]
              testBoard.board[0][x] = nextBlock
              result.push testBoard
      else if direction is 'left'
        for y in [0..3]
          do ->
            testBoard = new Board newboard
            unless testBoard.board[y][3]
              testBoard.board[y][3] = nextBlock
              result.push testBoard
      else if direction is 'right'
        for y in [0..3]
          do ->
            testBoard = new Board newboard
            unless testBoard.board[y][0]
              testBoard.board[y][0] = nextBlock
              result.push testBoard
      result
    else
      newboard

  point: ->
    point = 0
    for x in [0..3]
      for y in [0..3]
        point += Board.blockPoint @board[y][x]
    point

  free: ->
    count = 0
    for x in [0..3]
      for y in [0..3]
        if @board[y][x] is 0
          count += 1
    count

  @blockPoint: (a) ->
    if a < 3
      0
    else
      a /= 3
      k = (Math.log a) / (Math.log 2)
      Math.pow 3, k + 1

  @merge: (a, b) ->
    if a is 1 and b is 2
      3
    else if a is 2 and b is 1
      3
    else if a > 2 and a is b
      a + b
    else if not a or not b
      a + b
    else
      false


module.exports = Board
