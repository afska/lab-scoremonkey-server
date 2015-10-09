###
A score, composed by a collection of *bars* and *settings* defined as:
  settings = {
    tempo: 120,
    signatures: {
      time: { numerator: 4, denominator: 4 },
      key: "Abm",
      clef: "G"
    }
  }
###
module.exports =

class Score
  constructor: (@settings, @bars) ->
