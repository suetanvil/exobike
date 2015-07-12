// Generated by CoffeeScript 1.9.2
var TrackGenerator,
  bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

TrackGenerator = (function() {
  function TrackGenerator(length) {
    this.newRow = bind(this.newRow, this);
    var addRow, i, r, ref, rowCount, visibleRows;
    visibleRows = [];
    rowCount = 0;
    this.rowCount = function() {
      return rowCount;
    };
    addRow = (function(_this) {
      return function(empty) {
        var row;
        row = _this.newRow(empty).join("");
        visibleRows.push(row);
        return rowCount++;
      };
    })(this);
    this.advance = function(empty) {
      addRow(empty);
      return visibleRows.shift();
    };
    this.at = function(index) {
      return visibleRows[index];
    };
    this.rows = function() {
      return visibleRows.slice();
    };
    for (r = i = 1, ref = length; 1 <= ref ? i <= ref : i >= ref; r = 1 <= ref ? ++i : --i) {
      visibleRows.push("    ");
    }
  }

  TrackGenerator.prototype.rnd = function(max) {
    return Math.floor(Math.random() * max);
  };

  TrackGenerator.prototype.oneIn = function(max) {
    return this.rnd(max) === 0;
  };

  TrackGenerator.prototype.place = function(item, row) {
    return row[this.rnd(4)] = item;
  };

  TrackGenerator.prototype.newRow = function(empty) {
    var row;
    row = [' ', ' ', ' ', ' '];
    if (empty || !this.oneIn(3)) {
      return row;
    }
    while (this.oneIn(3)) {
      this.place('/', row);
    }
    while (this.oneIn(3)) {
      this.place('*', row);
    }
    return row;
  };

  return TrackGenerator;

})();