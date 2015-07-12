// Generated by CoffeeScript 1.9.2
var KM, Pre, Splash, State, attractLoop, endScreen, helpLoop, initGlobals, keyDownHandler, keyUpHandler, mainLoop, paused, playGame, setKey, x;

KM = 240;

State = null;

Pre = null;

Splash = null;

$(document).ready(function() {
  initGlobals();
  return attractLoop();
});

initGlobals = function() {
  Pre = $("#ascii_art").get(0);
  return Splash = new FixedScreens(Pre);
};

setKey = function(down, up) {
  $(document).off("keydown");
  $(document).off("keyup");
  if (down) {
    $(document).on("keydown", null, null, down);
  }
  if (up) {
    return $(document).on("keyup", null, null, up);
  }
};

attractLoop = function() {
  var count, insert, loopFn;
  insert = 0;
  setKey(null, function() {
    return ++insert;
  });
  count = 0;
  loopFn = function() {
    if (count % 2) {
      Splash.showTitleAlt();
    } else {
      Splash.showTitle();
    }
    count++;
    if (count < 1 || !insert) {
      setTimeout(loopFn, 500);
      return insert = false;
    } else if (insert) {
      return helpLoop();
    }
  };
  return loopFn();
};

helpLoop = function() {
  Splash.showInstructions();
  return setTimeout(playGame, 4000);
};

playGame = function() {
  State = new Game(Pre, 500);
  setKey(keyDownHandler, keyUpHandler);
  return mainLoop();
};

paused = false;

x = 0;

keyDownHandler = (function(_this) {
  return function(event) {
    switch (String.fromCharCode(event.keyCode)) {
      case 'A':
        return State.left();
      case 'D':
        return State.right();
      case 'S':
        return State.setWheelie(true);
      case 'P':
        return paused = !paused;
      case 'N':
        if (paused) {
          return State.oneRound();
        }
    }
  };
})(this);

keyUpHandler = function(event) {
  if (String.fromCharCode(event.keyCode) === 'S') {
    return State.setWheelie(false);
  }
};

mainLoop = function() {
  var delay;
  if (!State.oneRound()) {
    endScreen();
    return;
  }
  delay = State.delayTime();
  return setTimeout(mainLoop, delay);
};

endScreen = function() {
  setKey(null, null);
  if (State.crashed) {
    Splash.showCrashed();
  } else {
    Splash.showWin(State.elapsedTimeFmt());
  }
  return setTimeout(attractLoop, 4000);
};