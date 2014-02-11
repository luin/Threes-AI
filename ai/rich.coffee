module.exports = (board, block) ->
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
        if point > max.point
          max.free = free
          max.point = point
          max.direction = direction
        else if point is max.point and free > max.free
          max.free = free
          max.direction = direction

  max.direction
