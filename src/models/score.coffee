###
Score Entity.

A score is composed by a collection of bars and settings defined as:

  *settings* = {
    tempo: 120,
    signatures: {
      time: { major: 4, minor: 4 },
      key: "Abm",
      clef: "G"
    }
  }
###
module.exports =

class Score
  constructor: (@settings, @bars) ->
