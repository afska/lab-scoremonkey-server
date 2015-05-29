Midi = require("jsmidgen")
fs = require("fs")
BeatConverter = include("converters/beatConverter")
module.exports =

#A MIDI File created by a *melody*
class MidiFile
  constructor: (@melody) ->
    @file = new Midi.File()
    @track = @file.addTrack()

    #tempo related
    @track.setTempo @melody.tempo
    @beatConverter = new BeatConverter(@melody.tempo)

    @melody.notes.forEach (note, i) =>
      previousNote = @melody.notes[i-1]
      ticks = @_getTicks note.duration

      if note.name is "r"
        @track.addNoteOff 0, previousNote.name, ticks if previousNote?
      else
        @track.addNote 0, note.name, ticks

  #Exports the file into a *path*
  save: (path) =>
    fs.writeFileSync path, @file.toBytes(), "binary"

  #Get ticks with jsmidigen beats convention
  # beats  ----- x = beats * 512
  # 1 beat ----- 512 ticks
  _getTicks: (duration) =>
    @beatConverter.toBeats(duration) * 512
