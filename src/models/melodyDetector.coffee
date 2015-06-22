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
  Generates the melody from the output of the recognizer.
  ###
  getMelody: =>
    @recognizer.execute().then (samples) =>
      notesWithDuration = @_addDurationToNotes output

      #Hacer flow de postprocessors y volar @_addDurationToNotes

      #groupBySemicorchea
      #notesWithDuration.reduce ,[]
      # falta para esto :)
      #new Melody(@settings.tempo, notesWithDuration)

  _addDurationToNotes: (notes) =>
    notes.map (note, i) =>
      nextTimestamp = notes[i+1]?.timestamp || note.timestamp
      _.assign note,
        duration: (nextTimestamp - note.timestamp) * 1000
