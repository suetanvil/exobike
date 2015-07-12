

class Game

  trk: null
  renderer: null
  maxCount: 0
  bikepos: 1
  wheelie: false
  jumpCount: 0
  speed: 0.5
  elapsedTime: 0
  crashed: false

  advanceCount: 0

  constructor: (pre, @maxCount) ->
    gameOn = true
    @gameOver =     => gameOn = false
    @gameOn =       => gameOn

    @ypos = -> 4
    @jumpLen = -> 6

    @trk = new TrackGenerator(20)
    @renderer = new Renderer(pre, @ypos())
    @bikepos = 1
    @count = @maxCount

  left:  =>
    return unless @bikepos > 1
    @bikepos--
    @render()

  right: =>
    return unless @bikepos < 4
    @bikepos++
    @render()

  setWheelie: (up) =>
    return if @wheelie == up
    @wheelie = up
    @render()

  die: ->
    count = 0
    @crashed = true
    @gameOver()


  bikeHits: (len, char) ->
    rows = @trk.rows()
    for ym in [0..len]
      return true if rows[@ypos() + ym][@bikepos - 1] == char
    false

  jump:     -> @jumpCount = @jumpLen()
  jumping:  -> @jumpCount > 0

  # Game loop body.  Returns false to quit
  oneRound: ->
    return false unless @gameOn()

    @oneMovement()

    @gameOver() unless @count > 0
    return @gameOn()

  delayTime: => 50 + 200 * (1 - @speed)

  elapsedTimeFmt: -> @renderer.timefmt(Math.floor(@elapsedTime/1000))

  # Perform one game movement
  oneMovement: ->
    @trk.advance(@count <= 20)
    @die()  if !@wheelie && !@jumping() && @bikeHits(2, '/')
    @jump() if  @wheelie && !@jumping() && @bikeHits(1, '/')

    @render()

    @elapsedTime += @delayTime()

    @adjustSpeed()
    @count -= 1
    @jumpCount -= 1


  adjustSpeed: ->
    bikelen = if @wheelie then 1 else 2

    @speed += 0.1   if @jumping()
    @speed -= 0.025 if @wheelie && !@jumping()
    @speed -= 0.2   if !@jumping() && @bikeHits(bikelen, '*')

    @speed = Math.min(1, Math.max(0, @speed))

    @speed += 0.02 if @speed < 0.5
    @speed -= 0.02 if @speed > 0.5
    #@speed = 0.5 if Math.abs(@speed - 0.5) <= 0.02

  bikeY: ->
    return 0 unless @jumping()

    sofar = @jumpCount / @jumpLen()
    return Math.floor(Math.sin(sofar * Math.PI) * 7)


  render: =>
    @renderer.render(@trk.rows().reverse(), @maxCount - @count, @speed,
                     Math.floor(@elapsedTime/1000), @bikepos, @bikeY(),
                     @wheelie || @jumping())
