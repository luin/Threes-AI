module.exports = (board, block) ->
  max =
    point: 0
    free: 0
    direction: null

  ['up', 'down', 'left', 'right'].forEach (direction) ->
    test = board.move direction
    free = test.free()
    point = test.point()
    if free > max.free
      max.free = free
      max.point = point
      max.direction = direction
    else if free is max.free and point > max.point
      max.point = point
      max.direction = direction

  max.direction

