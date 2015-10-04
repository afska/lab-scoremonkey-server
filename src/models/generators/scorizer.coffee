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
      .map @_buildNote
      .flatten()

    groupNotes(validNotes, length, markAsTied: true).map (group) =>
      new Bar signatures, group.map (note) =>
        new Note(note)

  ###
  Splits the notes into many "valid" notes, adding "ties" if it's necessary.
  ###
  _buildNote: (note) =>
    notes = [] ; leftover = note.duration

    while leftover > 0
      closest = musicalFigureDictionary.findClosestDuration leftover
      leftover -= closest

      isTheFirst = _.isEmpty notes
      isTheLast = leftover is 0
      isTheUnique = isTheFirst and isTheLast

      notes.push
        name: note.name
        duration: closest
        tie:
          start: not isTheLast and not isTheUnique
          stop: not isTheFirst and not isTheUnique

    notes
