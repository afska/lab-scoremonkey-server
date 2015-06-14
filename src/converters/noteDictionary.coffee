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
      @noteNames().map (note) =>
        note: note
        frequency: @_frequencyOf note

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
        ].map (note) => "#{note}#{octave}"
      .flatten()
      .concat "r"

  ###
  Get all the info of a *note*.
  ###
  get: (note) =>
    @notes.find (noteInfo) => noteInfo.note is note

  ###
  Position of a *note* in the notes array.
   e.g. "d#0" is 3
  ###
  positionOf: (note) => @noteNames().indexOf note

  ###
  Identifies a note info by *frequency*.
  ###
  whatIs: (frequency) =>
    log2 = (n) => Math.log(n) / Math.log(2)
    index = (Math.round(12 * log2(frequency / @base.freq)) + @base.index).toFixed()
    if index <= 0 then return @get "r"
    @notes[index]

  ###
  Frequency of a *note*.
   440 * (2^(1/12))^semitonesFromA4
  ###
  _frequencyOf: (note) =>
    if note is "r" then return 0

    twelthRootOf2 = Math.pow 2, 1/12

    distanceToBase = @positionOf(note) - @base.index
    @base.freq * Math.pow twelthRootOf2, distanceToBase
