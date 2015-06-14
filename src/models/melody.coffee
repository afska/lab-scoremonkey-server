BeatConverter = include("converters/beatConverter")
_ = require("protolodash")

###
A melody with a *tempo* and an array of *notes*.
The array is something like: [
 { note: "a4", frequency: 441.23, duration: 245 }
]
###
module.exports =

class Melody
  constructor: (@tempo, @notes) ->
    @beatConverter = new BeatConverter(@tempo)

  ###
  The notes with ms as the duration unit
  ###
  notesWithMs: => @notes

  ###
  The notes with beats as the duration unit
  ###
  notesWithBeats: =>
    @notes.map (note) =>
      _.assign note,
        duration: @beatConverter.toBeats(note.duration)
