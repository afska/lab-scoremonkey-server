Score = include("models/score")
Bar = include("models/bar")
Note = include("models/note")
groupNotes = include("models/converters/groupNotes")
musicalFigureDictionary = include("models/converters/musicalFigureDictionary")
_ = require("protolodash")

###
A *Score* builder from a *melody*.
###
module.exports =

class Scorizer
  constructor: (@melody) ->

  ###
  Builds the *score* by grouping the *melody* in *bars*.
  ###
  build: (settings) =>
    new Score settings, @_buildBars(settings.signatures)

  ###
  Splits the *melody* into *bars*, creating *notes*.
  ###
  _buildBars: (signatures) =>
    length = signatures.time.major / signatures.time.minor

    validNotes = @melody.notesWithBeats()
      .map @_buildNotes
      .flatten()

    groupNotes(validNotes, length, markAsSplitted: true).map (group) =>
      new Bar signatures, group.map (note) =>
        new Note(
          if note.splitted then "u" else note.name,
          note.duration
        )

  ###
  Splits the notes into many "valid" notes, adding "unions" if it's necessary.
  ###
  _buildNotes: (note) =>
    notes = [] ; leftover = note.duration

    while leftover > 0
      finalName = if _.isEmpty notes then note.name else "u"

      closest = musicalFigureDictionary.findClosestDuration leftover
      notes.push name: finalName, duration: closest
      leftover -= closest

    notes
