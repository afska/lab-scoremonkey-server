require("protolodash")

###
A dictionary for finding all the playable notes with each frequency.
"c#5" is c sharp at the 5th octave, "r" is a rest.
###
module.exports = new #singleton

class NoteDictionary
  constructor: ->
    @base = freq: 440, index: @positionOf "a4"
    @notes =
      @noteNames().map (name) =>
        name: name
        frequency: @_frequencyOf name

  ###
  All available note names.
  ###
  noteNames: =>
    names = [0 .. 10]
      .map (octave) =>
        [
          "c", "c#", "d"
          "d#", "e", "f"
          "f#", "g", "g#"
          "a", "a#", "b"
        ].map (name) => "#{name}#{octave}"
      .flatten()
      .concat "r"

  ###
  Get all the info of a *name*.
  ###
  get: (name) =>
    @notes.find (noteInfo) => noteInfo.name is name

  ###
  Position of a *name* in the notes array.
   e.g. "d#0" is 3
  ###
  positionOf: (name) => @noteNames().indexOf name

  ###
  Identifies a note info by *frequency*.
  ###
  whatIs: (frequency) =>
    log2 = (n) => Math.log(n) / Math.log(2)
    index = (Math.round(12 * log2(frequency / @base.freq)) + @base.index).toFixed()
    @notes[index] || @get "r"

  ###
  Frequency of a *name*.
   440 * (2^(1/12))^semitonesFromA4
  ###
  _frequencyOf: (name) =>
    if name is "r" then return 0

    twelthRootOf2 = Math.pow 2, 1/12

    distanceToBase = @positionOf(name) - @base.index
    @base.freq * Math.pow twelthRootOf2, distanceToBase
