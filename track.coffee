
# Thingy to generate the track.

class TrackGenerator

  constructor: (length) ->
    #
    # Private variables:
    #
    visibleRows = []

    rowCount = 0
    @rowCount = -> rowCount

    addRow = (empty) =>
      row = @newRow(empty).join("")
      visibleRows.push(row)
      rowCount++

    @advance = (empty) ->
      addRow(empty)
      visibleRows.shift()

    @at = (index) -> visibleRows[index]

    @rows = -> visibleRows.slice()

    #
    # Initialization
    #

    # Lead-in is always clear
    for r in [1..length]
      visibleRows.push("    ")


  rnd: (max) -> Math.floor(Math.random() * max)
  oneIn: (max) -> @rnd(max) == 0

  place: (item, row) -> row[@rnd(4)] = item

  newRow: (empty) =>
    row = [' ', ' ', ' ', ' ']
    return row if empty or not @oneIn(3)

    @place('/', row) while @oneIn(3)
    @place('*', row) while @oneIn(3)

    return row
