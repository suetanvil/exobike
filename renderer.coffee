
# Render the game screen as a <pre/>
class Renderer


  constructor: (pre, @ypos) ->
    @pre = -> pre
    @indent = -> 20

    @cycle =     ['  0_O',
                  '  `y ',
                  ' _O  ']
    @wheelie =   ['0_O',
                  ' +|',
                  '  O']


  render: (track, count, speed, time, bikeX, bikeY, wheelie) =>
    result = ''
    result += @renderCount(count, speed, time)
    result += @renderTrack(track, bikeX, bikeY, wheelie)

    @pre().textContent = result

  padNum: (num, width, pre) ->
    x = pre + pre + pre + pre + pre + "#{num}"
    return x.substr(x.length - width)

  timefmt: (seconds) ->
    minutes = @padNum(Math.floor(seconds / 60), 2, '0')
    seconds = @padNum(seconds % 60, 2, '0')
    return "#{minutes}:#{seconds}"

  renderCount: (count, speed, time) ->
    "#{@padNum(count,3,'0')}m #{@timefmt(time)} #{Math.floor(speed*KM)}km/h\n"

  renderTrack: (obstList, bikeX, bikeY, wheelie) =>
    buffer = @renderLanes(obstList)
    @addBike(buffer, bikeX, bikeY, wheelie)
    return @flattenTrack(buffer)

  addBike: (buffer, bikeX, bikeY, wheelie) =>
    sy = buffer.length - (@ypos + 3) - bikeY  # sy is y pos of rear wheel
    sx = (@indent() - 4) + 2*bikeX - bikeY    # sx is x pos of rear wheel
    wheelx = sx + 2     # 2 leading spaces

    sprite = if wheelie then @wheelie else @cycle
    sprite = sprite.map (l) -> l.split ''

    for y in [0 .. sprite.length - 1]
      for x in [0 .. sprite[0].length - 1]
        bp = sprite[y][x]
        xpos = x+sx + y     # starting point + offset + compensation for slope
        ypos = y+sy

        # Hide the bike behind uprights from ramps in the lane to the
        # right.
        continue if buffer[ypos][xpos] == '|' && x == (4 - y)

        # Render the bike.  Spaces are transparent; '_' is a
        # non-transparent space.
        buffer[ypos][xpos] = bp  if bp != ' ' && bp != '_'
        buffer[ypos][xpos] = ' ' if bp == '_'

  renderLanes: (track) =>
    count = track.length

    result = []
    for line in track
      outln = ([0..@indent()].map -> ' ').join('')

      outln += '/'
      for c in line
        seq = switch c
          when " " then  " /"
          when "*" then  "*/"
          when "/" then "|=|/"

        dl = (seq.length - 2) + 1
        outln = outln[0..-dl] if seq.length > 3
        outln += seq

      result.push(outln.split '')

    return result


  flattenTrack: (track) =>
    result = []
    width = track.length
    for line in track
      outln = ([0..width].map -> ' ').join('')
      width -= 1

      outln += line.join("")
      outln += "\n"
      result.push outln

    return result.join("")
