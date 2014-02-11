average = (array) ->
  sum = 0
  for i in array
    sum += i
  sum / array.length

module.exports = (board, block) ->
  max =
    point: 0
    free: 0
    direction: null

  ['up', 'down', 'left', 'right'].forEach (direction) ->
    test = board.move direction
    if (JSON.stringify test.board) is (JSON.stringify board.board)
      return
    point = test.point()
    newBoards = board.move direction, block
    newBoards.forEach (b) ->
      f = []
      ['up', 'down', 'left', 'right'].forEach (innerD) ->
        free  = (b.move innerD).free()
        f.push free

      free  = average f
      if free > max.free
        max.free = free
        max.point = point
        max.direction = direction
      else if free is max.free and point > max.point
        max.point = point
        max.direction = direction

  max.direction

