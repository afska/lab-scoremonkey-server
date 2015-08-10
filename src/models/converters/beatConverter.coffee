###
A converter between beats and milliseconds.
###
module.exports =

class BeatConverter
  @BEAT: 1/4 #length of a beat.

  constructor: (@tempo) ->

  ###
  To milliseconds.
  ###
  toMs: (beats) =>
    (beats / @constructor.BEAT) * @beatDuration()

  ###
  To beats.
  ###
  toBeats: (ms) =>
    ms * @constructor.BEAT / @beatDuration()

  ###
  Duration of a beat in milliseconds.
  ###
  beatDuration: => (60 / @tempo) * 1000
