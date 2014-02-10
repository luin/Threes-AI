Board = require './Board'
{ exec } = require 'child_process'


readline = require 'readline'

rl = readline.createInterface
  input: process.stdin
  output: process.stdout

gameLoop = ->
  rl.question 'Board: ', (input) ->
    input = input.split ' '
    board = new Board
    for y in [0..3]
      for x in [0..3]
        board.board[y][x] = parseInt input[y * 4 + x], 10

    guess = (board) ->
      rl.question 'Next block: ', (block) ->
        block = parseInt block, 10
        unless block in [1..3]
          console.log 'Wrong block. Continue...'
          guess board
          return
        console.log "Current Point: #{board.point()}"

        max =
          point: 0
          free: 0
          direction: null

        ['up', 'down', 'left', 'right'].forEach (direction) ->
          test = board.move direction
          if (JSON.stringify test.board) is (JSON.stringify board.board)
            return
          newBoards = board.move direction, block
          newBoards.forEach (b) ->
            ['up', 'down', 'left', 'right'].forEach (innerD) ->
              point = (b.move innerD).point()
              free  = (b.move innerD).free()
              if free > max.free
                max.free = free
                max.point = point
                max.direction = direction
              else if free is max.free and point > max.point
                max.point = point
                max.direction = direction

        console.log "Direction: #{max.direction}"
        exec "say #{max.direction}"
        gameLoop()

    guess board

gameLoop()
