_ = require("protolodash")

###
Function that splits an array of *notes* in many arrays,
where the duration of each array is selected by the user.
  options = { markAsSplitted: false }

if groupNewLength > maxDuration,
  then 'groupNewLength' is the remaining duration of a tied group of notes
###
module.exports = (notes, maxDuration, options = {}) =>
  notes = _.clone notes, true

  groupNotes = (groups, note) =>
    lastGroup = groups.last()
    groupNewLength = _.sum(lastGroup, "duration") + note.duration

    if groupNewLength <= maxDuration
      # add
      lastGroup.push note
    else
      # split

      # >>> toda esta lógica está bastannnte inexacta
      leftover = groupNewLength - maxDuration
      note.duration -= leftover

      lastGroup.push note if note.duration > 0

      groups.push [
        _.assign _.clone(note), duration: leftover
      ]
      # <<<

    groups

  notes.reduce groupNotes, [[]]
