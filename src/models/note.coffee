_ = require("protolodash")

###
Note Entity.

A bar is composed by a set of signatures and a collection of notes:

  signatures: {
    time: { major: 4, minor: 4 },
    key: "Abm",
    clef: "G"
  }
###
module.exports =

class Bar
  constructor: (@signatures, @notes) ->

  ###
  Checks that the bar is completely filled with notes
  ###
  isComplete: =>
    @notes.sum("duration") is (@signatures.time.major)
