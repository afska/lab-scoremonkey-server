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

      if note.duration > 0
        if options.markAsTied
          _.assign note , { tie: {start: true} }

        lastGroup.push note

      groups.push [
        _.assign _.clone(note), duration: leftover,
        if options.markAsTied and note.duration > 0
          tie: {stop: true}
      ]
      # <<<

    groups

  notes.reduce groupNotes, [[]]
