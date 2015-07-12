

class FixedScreens

  constructor: (pre) ->
    NUMLINES = 21

    @show = (doc, noIndent = false) =>
      lines = doc.split("\n")

      lines = lines[0..NUMLINES-1] if lines.length > NUMLINES
      lines.push "" while lines.length < NUMLINES

      lines = lines.map( (l) -> "        " + l) unless noIndent

      pre.textContent = lines.join("\n")


    compositeLine = (fg, bg) ->
      result = ''
      for n in [0 .. Math.max(fg.length, bg.length)]
        fc = fg[n] || ' '
        bc = bg[n] || ' '

        nc = bc
        if fc == '.'
          nc = ' '
        else if fc != ' '
          nc = fc

        result += nc

      return result


    @superimpose = (doc) =>
      bglines = pre.textContent.split("\n")
      fglines = doc.split("\n")

      newText = []
      for i in [0 .. Math.max(bglines.length, fglines.length) - 1]
        newline = compositeLine(fglines[i] || "", bglines[i] || "")
        newText.push(newline)

      @show(newText.join("\n"), true)



  showTitle: ->
    # ASCII art: http://patorjk.com/software/taag/
    @show('''

                        ______           __    _ __
                       / ____/  ______  / /_  (_) /_____
                      / __/ | |/_/ __ \\/ __ \\/ / //_/ _ \\
                     / /____>  </ /_/ / /_/ / / ,< /  __/
                    /_____/_/|_|\\____/_.___/_/_/|_|\\___/

                              By Chris Reuter

                                  Age 12



                       *** ONE KEYSTROKE ONE PLAY ***


                                  0 O
                                   +|
                                    O

''')


  showTitleAlt: ->
    @show('''

                        ______           __    _ __
                       / ____/  ______  / /_  (_) /_____
                      / __/ | |/_/ __ \\/ __ \\/ / //_/ _ \\
                     / /____>  </ /_/ / /_/ / / ,< /  __/
                    /_____/_/|_|\\____/_.___/_/_/|_|\\___/

                              By Chris Reuter

                                  Age 12






                                    0 O
                                    `y
                                    O

''')





  showInstructions: ->
    @show('''

                        ______           __    _ __
                       / ____/  ______  / /_  (_) /_____
                      / __/ | |/_/ __ \\/ __ \\/ / //_/ _ \\
                     / /____>  </ /_/ / /_/ / / ,< /  __/
                    /_____/_/|_|\\____/_.___/_/_/|_|\\___/



                        A, D -> left and right
                        S    -> wheelie

                        *    puddles slow you down

                        /=/  ramps make you jump IF
                             DOING A WHEELIE.  Otherwise,
                             they make you CRASH

                        Jumping speeds you up; wheelies
                        slow you down a bit.

''')



  showCrashed: ->
    crashed = '''




                   ______                __             ________
                  /.____/________.______/./_..___..____/././././
                 /./.../.___/.__.`/.___/.__.\\/._.\\/.__.././././
                /./___/./.././_/.(__..)./././..__/./_/./_/_/_/
                \\____/_/...\\__,_/____/_/./_/\\___/\\__,_(_|_|_)
    '''

    # Put back the leading spacess coffeescript removes:
    crashed = crashed.split("\n").map( (l) -> "              " + l).join("\n")

    @superimpose(crashed)


  showWin: (time) ->
    win = """
                         _______       _      __             __
      __/|___/|___/|_   / ____(_)___  (_)____/ /_  ___  ____/ /  __/|___/|___/|_
     |    /    /    /  / /_  / / __ \\/ / ___/ __ \\/ _ \\/ __  /  |    /    /    /
    /_ __/_ __/_ __|  / __/ / / / / / (__  ) / / /  __/ /_/ /  /_ __/_ __/_ __|
     |/   |/   |/    /_/   /_/_/ /_/_/____/_/ /_/\\___/\\__,_/    |/   |/   |/


                            Your time: #{time}

    """

    @show(win)

 # _______ _     _  _____  ______  _____ _     _ _______
 # |______  \___/  |     | |_____]   |   |____/  |______
 # |______ _/   \_ |_____| |_____] __|__ |    \_ |______
