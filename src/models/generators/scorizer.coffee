Score = include("models/score")
Bar = include("models/bar")
Note = include("models/note")
groupNotes = include("models/converters/groupNotes")
musicalFigureDictionary = include("models/converters/musicalFigureDictionary")
require("protolodash")

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

    groupNotes(@melody.notesWithBeats(), length, markAsSplitted: true).map (group) =>
      new Bar signatures, @_buildNotes(group)

  ###
  Splits the notes into many, adding "union" notes if it's necessary.
  ###
  _buildNotes: (group) =>
    group.map (note) =>
      name = if note.splitted then "u" else note.name

      notes = [] ; leftOver = 1
      while leftover > 0
        finalName = if notes is [] then name else "u"

        closest = musicalFigureDictionary.findClosestDuration note.duration
        notes.push new Note(finalName, closest)
        leftover = note.duration - closest

      notes.flatten()
