Board = require './Board'
{ exec } = require 'child_process'

ai = require './ai/average'


readline = require 'readline'

rl = readline.createInterface
  input: process.stdin
  output: process.stdout

gameLoop = ->
  rl.question 'Board: ', (input) ->
    input = input.split ' '
    return gameLoop() unless input.length is 16
    board = new Board
    for y in [0..3]
      for x in [0..3]
        board.board[y][x] = parseInt input[y * 4 + x], 10

    rl.question 'Next block: ', (block) ->
      block = parseInt block, 10
      return gameLoop() unless block in [1..3]

      console.log "Current Point: #{board.point()}"
      direction = ai board, block
      console.log "Direction: #{direction}"
      exec "say #{direction}"
      gameLoop()

gameLoop()
