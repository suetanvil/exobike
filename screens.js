// Generated by CoffeeScript 1.9.2
var FixedScreens;

FixedScreens = (function() {
  function FixedScreens(pre) {
    var NUMLINES, compositeLine;
    NUMLINES = 21;
    this.show = (function(_this) {
      return function(doc, noIndent) {
        var lines;
        if (noIndent == null) {
          noIndent = false;
        }
        lines = doc.split("\n");
        if (lines.length > NUMLINES) {
          lines = lines.slice(0, +(NUMLINES - 1) + 1 || 9e9);
        }
        while (lines.length < NUMLINES) {
          lines.push("");
        }
        if (!noIndent) {
          lines = lines.map(function(l) {
            return "        " + l;
          });
        }
        return pre.textContent = lines.join("\n");
      };
    })(this);
    compositeLine = function(fg, bg) {
      var bc, fc, j, n, nc, ref, result;
      result = '';
      for (n = j = 0, ref = Math.max(fg.length, bg.length); 0 <= ref ? j <= ref : j >= ref; n = 0 <= ref ? ++j : --j) {
        fc = fg[n] || ' ';
        bc = bg[n] || ' ';
        nc = bc;
        if (fc === '.') {
          nc = ' ';
        } else if (fc !== ' ') {
          nc = fc;
        }
        result += nc;
      }
      return result;
    };
    this.superimpose = (function(_this) {
      return function(doc) {
        var bglines, fglines, i, j, newText, newline, ref;
        bglines = pre.textContent.split("\n");
        fglines = doc.split("\n");
        newText = [];
        for (i = j = 0, ref = Math.max(bglines.length, fglines.length) - 1; 0 <= ref ? j <= ref : j >= ref; i = 0 <= ref ? ++j : --j) {
          newline = compositeLine(fglines[i] || "", bglines[i] || "");
          newText.push(newline);
        }
        return _this.show(newText.join("\n"), true);
      };
    })(this);
  }

  FixedScreens.prototype.showTitle = function() {
    return this.show('\n    ______           __    _ __\n   / ____/  ______  / /_  (_) /_____\n  / __/ | |/_/ __ \\/ __ \\/ / //_/ _ \\\n / /____>  </ /_/ / /_/ / / ,< /  __/\n/_____/_/|_|\\____/_.___/_/_/|_|\\___/\n\n          By Chris Reuter\n\n              Age 12\n\n\n\n   *** ONE KEYSTROKE ONE PLAY ***\n\n\n              0 O\n               +|\n                O\n');
  };

  FixedScreens.prototype.showTitleAlt = function() {
    return this.show('\n    ______           __    _ __\n   / ____/  ______  / /_  (_) /_____\n  / __/ | |/_/ __ \\/ __ \\/ / //_/ _ \\\n / /____>  </ /_/ / /_/ / / ,< /  __/\n/_____/_/|_|\\____/_.___/_/_/|_|\\___/\n\n          By Chris Reuter\n\n              Age 12\n\n\n\n\n\n\n                0 O\n                `y\n                O\n');
  };

  FixedScreens.prototype.showInstructions = function() {
    return this.show('\n    ______           __    _ __\n   / ____/  ______  / /_  (_) /_____\n  / __/ | |/_/ __ \\/ __ \\/ / //_/ _ \\\n / /____>  </ /_/ / /_/ / / ,< /  __/\n/_____/_/|_|\\____/_.___/_/_/|_|\\___/\n\n\n\n    A, D -> left and right\n    S    -> wheelie\n\n    *    puddles slow you down\n\n    /=/  ramps make you jump IF\n         DOING A WHEELIE.  Otherwise,\n         they make you CRASH\n\n    Jumping speeds you up; wheelies\n    slow you down a bit.\n');
  };

  FixedScreens.prototype.showCrashed = function() {
    var crashed;
    crashed = '\n\n\n\n   ______                __             ________\n  /.____/________.______/./_..___..____/././././\n /./.../.___/.__.`/.___/.__.\\/._.\\/.__.././././\n/./___/./.././_/.(__..)./././..__/./_/./_/_/_/\n\\____/_/...\\__,_/____/_/./_/\\___/\\__,_(_|_|_)';
    crashed = crashed.split("\n").map(function(l) {
      return "              " + l;
    }).join("\n");
    return this.superimpose(crashed);
  };

  FixedScreens.prototype.showWin = function(time) {
    var win;
    win = "                     _______       _      __             __\n  __/|___/|___/|_   / ____(_)___  (_)____/ /_  ___  ____/ /  __/|___/|___/|_\n |    /    /    /  / /_  / / __ \\/ / ___/ __ \\/ _ \\/ __  /  |    /    /    /\n/_ __/_ __/_ __|  / __/ / / / / / (__  ) / / /  __/ /_/ /  /_ __/_ __/_ __|\n |/   |/   |/    /_/   /_/_/ /_/_/____/_/ /_/\\___/\\__,_/    |/   |/   |/\n\n\n                        Your time: " + time + "\n";
    return this.show(win);
  };

  return FixedScreens;

})();