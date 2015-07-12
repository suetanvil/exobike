
KM=240      # Number of km per internal distance units

State = null
Pre = null
Splash = null

$(document).ready ->
  initGlobals()
  attractLoop()

initGlobals = ->
  Pre = $("#ascii_art").get(0)
  Splash = new FixedScreens(Pre)

setKey = (down, up) ->
  $(document).off("keydown")
  $(document).off("keyup")

  $(document).on("keydown", null, null, down) if down
  $(document).on("keyup", null, null, up)     if up

attractLoop = ->
  insert = 0
  setKey(null, -> ++insert)

  count = 0
  loopFn = ->
    if count % 2
      Splash.showTitleAlt()
    else
      Splash.showTitle()

    count++

    if count < 1 or not insert
      setTimeout(loopFn, 500)
      insert = false
    else if insert
      helpLoop()

  loopFn()


helpLoop = ->
  Splash.showInstructions()
  setTimeout(playGame, 4000)


playGame = ->
  State = new Game(Pre, 500)
  setKey(keyDownHandler, keyUpHandler)
  mainLoop()

paused = false
x=0
keyDownHandler = (event) =>
  switch String.fromCharCode(event.keyCode)
    when 'A' then State.left()
    when 'D' then State.right()
    when 'S' then State.setWheelie(true)
    when 'P' then paused = !paused
    when 'N' then if paused then State.oneRound()

keyUpHandler = (event) ->
  State.setWheelie(false) if String.fromCharCode(event.keyCode) == 'S'

mainLoop = () ->
  if not State.oneRound()
    endScreen()
    return

  delay = State.delayTime()
  setTimeout(mainLoop, delay)

endScreen = () ->
  setKey(null, null)

  if State.crashed
    Splash.showCrashed()
  else
    Splash.showWin(State.elapsedTimeFmt())

  setTimeout(attractLoop, 4000)
