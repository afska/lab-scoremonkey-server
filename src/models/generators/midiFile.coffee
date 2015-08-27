Midi = require("jsmidgen")
promisify = require("bluebird").promisifyAll
fs = promisify require("fs")
streamifier = require("streamifier")

Buffer::toArrayBuffer = ->
  arrayBuffer = new ArrayBuffer @length
  view = new Uint8Array arrayBuffer

  for i in [0 .. @length]
    view[i] = @[i]

  arrayBuffer

###
A MIDI File created from a *melody*.
###
module.exports =

class MidiFile
  constructor: (melody) ->
    @file = new Midi.File()
    track = @file.addTrack()

    # tempo related
    track.setTempo melody.tempo

    # notes convertion
    notes = melody.notesWithBeats()
    notes.forEach (note, i) =>
      previousNote = notes[i-1]
      ticks = @_getTicks note.duration

      if note.name is "r"
        track.addNoteOff 0, previousNote.name, ticks if previousNote?
      else
        track.addNote 0, note.name, ticks

  ###
  Returns a buffer with the bytes.
  ###
  bytes: =>
    new Buffer(@file.toBytes(), "ascii")

  ###
  Saves the file into a *path* of the filesystem.
  ###
  save: (path) =>
    fs.writeFileAsync path, @bytes()

  ###
  Get ticks with jsmidigen beats convention.
    1 beat ----- 512 ticks
    duration --- x = beats * 512
  ###
  _getTicks: (duration) =>
    duration * 512
