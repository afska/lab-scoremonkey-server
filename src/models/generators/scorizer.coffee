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
      .map @_splitNotes
      .flatten()

    groupNotes(validNotes, length, markAsTied: true).map (group) =>
      new Bar signatures, group.map (note) =>
        new Note(
          note.name,
          note.duration
        )

  ###
  Splits the notes into many "valid" notes, adding "ties" if it's necessary.
  ###
  _splitNotes: (note) =>
    notes = [] ; leftover = note.duration ; closest = 1

    while leftover > 0 && closest != 0

      if not _.isEmpty notes
        lastNote = notes.last()
        _.assign lastNote , tie: []
        lastNote.tie.push {start: true}
        _.assign note , tie: []
        note.tie.push {stop: true}


      closest = musicalFigureDictionary.findClosestDuration leftover

      if closest > 0
        note.duration = closest
        notes.push _.clone(note)

      leftover -= closest


    notes
