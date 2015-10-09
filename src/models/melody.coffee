BeatConverter = include("models/converters/beatConverter")
_ = require("protolodash")

###
A melody with a *tempo* and an array of *notes*.
The array is something like: [
  { name: "a4", duration: 245 }
]
###
module.exports =

class Melody
  constructor: (@tempo, @notes) ->
    @beatConverter = new BeatConverter(@tempo)

  ###
  The notes with ms as the duration unit.
  ###
  notesWithMs: => @notes

  ###
  The notes with beats as the duration unit.
  ###
  notesWithBeats: =>
    @notes.map (note) =>
      name: note.name,
      duration: @_fixPrecision @beatConverter.toBeats(note.duration)

  ###
  Fix the precision of a number to 4 decimals.
  ###
  _fixPrecision: (duration) =>
    Math.round(duration * 10000) / 10000
