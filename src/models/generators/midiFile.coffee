Midi = require("jsmidgen")
fs = require("fs")

###
A MIDI File created by a *melody*.
###
module.exports =

class MidiFile
  constructor: (melody) ->
    @file = new Midi.File()
    track = @file.addTrack()

    #tempo related
    track.setTempo melody.tempo

    #notes convertion
    notes = melody.notesWithBeats()
    notes.forEach (note, i) =>
      previousNote = notes[i-1]
      ticks = @_getTicks note.duration

      if note.name is "r"
        track.addNoteOff 0, previousNote.name, ticks if previousNote?
      else
        track.addNote 0, note.name, ticks

  ###
  Exports the file into a *path*.
  ###
  save: (path) =>
    fs.writeFileSync path, @file.toBytes(), "binary"

  ###
  Get ticks with jsmidigen beats convention.
    1 beat ----- 512 ticks
    duration --- x = beats * 512
  ###
  _getTicks: (duration) =>
    duration * 512
