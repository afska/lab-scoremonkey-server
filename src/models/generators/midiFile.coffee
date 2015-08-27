Midi = require("jsmidgen")
promisify = require("bluebird").promisifyAll
fs = promisify require("fs")
streamifier = require("streamifier")

###
A MIDI File created from a *melody*.
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
  Returns a readable stream with the bytes.
  ###
  stream: => streamifier.createReadStream @_bytes()

  ###
  Saves the file into a *path* of the filesystem.
  ###
  save: (path) =>
    fs.writeFileAsync path, @_bytes(), "binary"

  ###
  Returns a buffer with the bytes.
  ###
  _bytes: => @file.toBytes()

  ###
  Get ticks with jsmidigen beats convention.
    1 beat ----- 512 ticks
    duration --- x = beats * 512
  ###
  _getTicks: (duration) =>
    duration * 512
