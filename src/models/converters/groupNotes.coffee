noteSplitter = include("models/generators/noteSplitter")
_ = require("protolodash")

###
Function that splits an array of *notes* in many arrays,
where the duration of each array is selected by the user.
  options = { createTies: false }
###
module.exports = (notes, maxDuration, options = {}) =>
  notes = _.clone notes, true

  groupNotes = (groups, note) =>
    isLastNote = notes.last() is note
    lastGroup = groups.last()
    groupNewLength = _.sum(lastGroup, "duration") + note.duration

    if groupNewLength <= maxDuration
      # add
      makeValidAndPush lastGroup, note

      if groupNewLength is maxDuration and not isLastNote
        createGroup groups
    else
      # split
      leftover = groupNewLength - maxDuration
      note.duration -= leftover

      firstPart = makeValid note
      secondPart = makeValid(
        _.assign _.cloneDeep(note), duration: leftover
      )

      # add first part
      markTie firstPart.last(), "start"
      pushMany lastGroup, firstPart

      # add second part
      markTie secondPart.first(), "stop"
      pushMany createGroup(groups), secondPart

    groups

  markTie = (part, point) ->
    if options.createTies
      part.tie[point] = true

  makeValid = (note) ->
    if options.createTies then noteSplitter note
    else [note]

  pushMany = (group, notes) ->
    notes.forEach (note) ->
      group.push note

  makeValidAndPush = (group, note) ->
    pushMany group, makeValid(note)

  createGroup = (groups) ->
    newGroup = []
    groups.push newGroup
    newGroup

  notes.reduce groupNotes, [[]]
