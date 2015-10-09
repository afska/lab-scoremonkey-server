_ = require("protolodash")
musicalFigureDictionary = include("models/converters/musicalFigureDictionary")

###
A note.

  *duration* is in beats: 3/8 is a "quarter with dot" (1/4 + 1/8)
  *name* can be a pitch name (ex. "A5") or a "r" (silence)
###
module.exports =

class Note
  constructor: (note) ->
    _.assign @, note

  ###
  Returns the figure data of the note, according with his duration.
  ###
  figure: =>
    musicalFigureDictionary.findByDuration @duration

