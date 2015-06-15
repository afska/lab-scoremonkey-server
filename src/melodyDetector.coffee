AubioPitch = include("lib/aubioPitch")
Melody = include("melody")
noteDictionary = include("converters/noteDictionary")
_ = require("protolodash")
module.exports =

#A generator of melodies using an audio recognizer.
#settings = {
# filePath: "/home/user/path/audioFile.wav"
# tempo: 180
# bar: { major: 4, minor: 4 }
# clef: "G"
#}
class MelodyDetector
  constructor: (@settings) ->
    @recognizer = new AubioPitch(@settings.filePath)

  #Generate the melody from the output of the recognizer.
  #returns a promise that resolves in something like [
  # { timestamp: 0, note: "r" },
  # { timestamp: 1.05, note: "c#4" }
  #]
  getMelody: =>
    @recognizer.execute().then (output) =>
      notes = @_removeRepeatedNotes output.map(@_detectNote)

      notesWithDuration = @_addDurationToNotes notes

      new Melody(@settings.tempo, notesWithDuration)

  _detectNote: (sampledNote) =>
    detectedNote = noteDictionary.whatIs sampledNote.frequency
    _.assign sampledNote,
      name: detectedNote?.note

  _removeRepeatedNotes: (notes) =>
    notes.reject (sampledNote, i) =>
      if not sampledNote.name? then return true

      detectedNote = (it) => it?.name
      detectedNote(sampledNote) is detectedNote(notes[i - 1])

  _addDurationToNotes: (notes) =>
    notes.map (note, i) =>
      nextTimestamp = notes[i+1]?.timestamp || note.timestamp
      _.assign note,
        duration: (nextTimestamp - note.timestamp) * 1000
