Score = include("models/score")
Bar = include("models/bar")
Note = include("models/note")
groupNotes = include("models/converters/groupNotes")

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
      new Bar signatures, group.map (note) =>
        new Note(
          if note.splitted then "u" else note.name,
          note.duration
        )
