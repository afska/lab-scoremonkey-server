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
    (beats / @constructor.Beat) * @_beatDuration()

  ###
  To beats.
  ###
  toBeats: (ms) =>
    ms * @constructor.Beat / @_beatDuration()

  ###
  Duration of a beat in milliseconds.
  ###
  _beatDuration: => (60 / @tempo) * 1000
