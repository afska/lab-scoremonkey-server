_ = require("protolodash")

###
A bar, composed by a set of *signatures* and a collection of *notes*:
  signatures = {
    time: { numerator: 4, denominator: 4 },
    key: "Abm",
    clef: "G"
  }
###
module.exports =

class Bar
  constructor: (@signatures, @notes) ->

  ###
  Checks that the bar is completely filled with notes.
  ###
  isComplete: =>
    @notes.sum("duration") is (@signatures.time.numerator / @signatures.time.denominator)
