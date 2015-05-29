AubioPitch = include("lib/aubioPitch")
Melody = include("melody")
noteDictionary = include("converters/noteDictionary")
_ = require("protolodash")
module.exports =

#A generator of melodies using an audio recognizer.
#The audio source is in a file stored in *filePath*.
class MelodyDetector
  constructor: (filePath) ->
    @recognizer = new AubioPitch(filePath)

  #Generate the melody from the output of the recognizer.
  #returns a promise that resolves in something like [
  # { timestamp: 0, note: "r" },
  # { timestamp: 1.05, note: "c#4" }
  #]
  # -> TODO: Deshardcodear el 120 del tempo
  getMelody: =>
    @recognizer.execute().then (output) =>
      notes = @_removeRepeatedNotes output.map(@_detectNote)

      notesWithDuration = @_addDurationToNotes notes

      new Melody(120, notesWithDuration)

  _detectNote: (sampledNote) =>
    detectedNote = noteDictionary.whatIs sampledNote.frequency
    _.assign _.omit(sampledNote, "frequency"), name: detectedNote?.note

  _removeRepeatedNotes: (notes) =>
    notes.reject (sampledNote, i) =>
      if not sampledNote.name? then return true

      detectedNote = (it) => it?.name
      detectedNote(sampledNote) is detectedNote(notes[i - 1])

  _addDurationToNotes: (notes) =>
    notes.map (note, i) =>
      nextTimestamp = notes[i+1]?.timestamp || note.timestamp
      _.assign note, duration: (nextTimestamp - note.timestamp) * 1000
