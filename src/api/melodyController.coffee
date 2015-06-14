MelodyDetector = include("models/melodyDetector")
MidiFile = include("models/midiFile")
unlink = require("fs").unlinkSync
_ = require("protolodash")

###
A controller that manages audio recognition.
###
class MelodyController

  ###
  Recognizes an audio file, returns the MIDI & MusicXML
  ###
  recognize: (req, res) =>
    errors = @_findErrors req
    if not _.isEmpty errors
      @_deleteFiles req
      return res.status(400).json errors: errors

    settings =
      filePath: req.files.audio.path
      tempo: req.body.tempo
      bar: { major: req.body.major, minor: req.body.minor }
      clef: req.body.clef

    new MelodyDetector(settings)
      .getMelody()
      .then (melody) =>
        new MidiFile(melody).save "monkeybirthday.mid"
        res.json melody
      .finally => @_deleteFiles req

  ###
  Find possible errors in the request
  ###
  _findErrors: (req) ->
    errors = []

    if not req.files.audio?
      errors.push "You must send a file named 'audio'."

    [
      { name: "tempo", type: "isNumber", values: [1 .. 250], parse: true }
      { name: "major", type: "isNumber", values: [1 .. 32], parse: true }
      { name: "minor", type: "isNumber", values: [1, 4, 8, 16], parse: true }
      { name: "clef", type: "isString", values: ["G", "C", "F"] }
    ].forEach (it) =>
      value = req.body[it.name]
      if it.parse then value = parseInt value
      if not value? or not _[it.type](value) or not it.values.includes(value)
        errors.push "You must send a parameter named '#{it.name}', with any value from #{it.values}."

    errors

  ###
  Deletes all the files of the request
  ###
  _deleteFiles: (req) ->
    for name, file of req.files
      unlink file.path

module.exports = (app) =>
  ctrl = new MelodiesController()
  app.post "/melodies", ctrl.recognize
