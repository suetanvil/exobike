
.SUFFIXES: .coffee .js

.coffee.js:
	coffee -cb $<

JS=exobike.js game.js renderer.js track.js screens.js

all: $(JS)

clean:
	rm *.js
