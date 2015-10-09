noteDictionary = include("models/converters/noteDictionary")
BeatConverter = include("models/converters/beatConverter")
_ = require("protolodash")

MINIMUM_NOTE_LENGTH = 1/16

###
Detects the note for each group and determines if it can be merged.
 Input: [[{frequency, duration}, ...], ...]
 Output: [{name, duration, canBeMerged}, ...]
###
module.exports = (settings, groups) =>
  beatConverter = new BeatConverter(settings.tempo)

  groups.map (group) =>
    detectedNotes = group.map (sample) =>
      name: noteDictionary.whatIs(sample.frequency).name
      duration: sample.duration

    stats = detectedNotes.countBy "name"
    finalNote = count: 0
    for name, count of stats
      if count > finalNote.count
        finalNote = { name, count }

    name: finalNote.name
    duration: beatConverter.toMs MINIMUM_NOTE_LENGTH
    canBeMerged: finalNote.name is "r" or
      (not detectedNotes.some (note) => note.name is "r")
