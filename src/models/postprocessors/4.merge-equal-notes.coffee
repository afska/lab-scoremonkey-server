noteDictionary = include("models/converters/noteDictionary")
_ = require("protolodash")

###
Merges the notes with the same name that can be merged
 Input: [{name, duration, canBeMerged}, ...]
 Output: [{name, duration}, ...]
###
module.exports = (settings, notes) =>
  merge = (merged, note) =>
    last = merged.last()

    if last? and note.canBeMerged and note.name is last.name
      last.duration += note.duration
    else
      merged.push note

    merged

  notes
    .reduce merge, []
    .map (note) => _.omit note, "canBeMerged"
