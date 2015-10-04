_ = require("protolodash")

###
Function that splits an array of *notes* in many arrays,
where the duration of each array is selected by the user.
  options = { markAsTied: false }
###
module.exports = (notes, maxDuration, options = {}) =>
  notes = _.clone notes, true

  groupNotes = (groups, note) =>
    lastGroup = groups.last()
    groupNewLength = _.sum(lastGroup, "duration") + note.duration

    if groupNewLength <= maxDuration
      # add
      lastGroup.push note

      if groupNewLength is maxDuration
        groups.push []
    else
      # split
      leftover = groupNewLength - maxDuration
      note.duration -= leftover

      firstPart = note
      secondPart = _.cloneDeep note

      # add first part
      if options.markAsTied
        firstPart.tie.start = true

      lastGroup.push firstPart

      # add second part
      secondPart.duration = leftover
      if options.markAsTied
        secondPart.tie.stop = true
      groups.push [secondPart]

    groups

  notes.reduce groupNotes, [[]]
