Melody = include("models/melody")
noteDictionary = include("converters/noteDictionary")
AubioPitch = include("lib/aubioPitch")
_ = require("protolodash")

###
A generator of melodies using an audio recognizer.
settings = {
 filePath: "/home/user/path/audioFile.wav"
 tempo: 180
 bar: { major: 4, minor: 4 }
 clef: "G"
}
###
module.exports =

class MelodyDetector
  constructor: (@settings) ->
    @recognizer = new AubioPitch(@settings.filePath)

  ###
  Generate the melody from the output of the recognizer.
  returns a promise that resolves in something like [
   { frequency: 0, name: "r", timestamp: 0, duration: 100 }
   { frequency: 430, name: "a4", timestamp: 0.1, duration: 150 }
   { frequency: 522.664551, name: "c5", timestamp: 0.25, duration: 0 }
  ]
  ###
  getMelody: =>
    @recognizer.execute().then (output) =>
      notesWithDuration = @_addDurationToNotes output

      #groupBySemicorchea
      #notesWithDuration.reduce ,[]
      # falta para esto :)
      #new Melody(@settings.tempo, notesWithDuration)

  _addDurationToNotes: (notes) =>
    notes.map (note, i) =>
      nextTimestamp = notes[i+1]?.timestamp || note.timestamp
      _.assign note,
        duration: (nextTimestamp - note.timestamp) * 1000
