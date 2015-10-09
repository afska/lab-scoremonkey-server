musicalFigureDictionary = include("models/converters/musicalFigureDictionary")
_ = require("protolodash")

###
Splits a note into many "valid" notes, adding "ties" if it's necessary.
###
module.exports = (note) ->
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
