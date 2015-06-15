###
A converter between beats and milliseconds.
###
module.exports =

class BeatConverter
  @Beat: 1/4 #length of a beat.
  constructor: (@tempo) ->

  ###
  To milliseconds.
  ###
  toMs: (beats) =>
    (beats / @constructor.Beat) * @beatDuration()

  ###
  To beats.
  ###
  toBeats: (ms) =>
    ms * @constructor.Beat / @beatDuration()

  ###
  Duration of a beat in milliseconds.
  ###
  beatDuration: => (60 / @tempo) * 1000
