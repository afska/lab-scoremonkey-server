MelodyDetector = include("models/generators/melodyDetector")
MidiFile = include("models/generators/midiFile")
MusicXmlFile = include("models/generators/musicXmlFile")
Scorizer = include("models/generators/scorizer")
GridFs = include("lib/gridFs")
Promise = require("bluebird")
fs = require("fs")
uuid = require("uuid")
_ = require("protolodash")

###
A controller that manages audio recognition.
###
class MelodyController
  ###
  Recognizes an audio file, returns the links to the MIDI and the Score.
  ###
  recognize: (req, res) =>
    errors = @_parseAndFindErrors req
    if not _.isEmpty errors
      @_deleteFiles req
      return res.status(400).json errors: errors

    settings =
      filePath: req.files.audio.path
      tempo: req.body.tempo
      signatures:
        time: { numerator: req.body.major, denominator: req.body.minor }
        clef: req.body.clef
        key: req.body.key


    new MelodyDetector(settings)
      .getMelody()
      .then (melody) =>
        @_generateMidiAndMusicXml(melody, settings).then (links) =>
          res.json links
      .finally =>
        @_deleteFiles req

  ###
  Generates and stores the MIDI and the MusicXML file.
  It returns a promise with links.
  ###
  _generateMidiAndMusicXml: (melody, settings) =>
    id = uuid.v4()
    midi = new MidiFile(melody).bytes()
    score = new Scorizer(melody).build(settings)
    musicxml = new MusicXmlFile(score).convertScore()

    gridFs = new GridFs()
    Promise.props
      midi: gridFs.write "#{id}.mid", midi
      score: gridFs.write "#{id}.xml", musicxml
    .then =>
      midi: "#{process.env.DOMAIN}/midis/#{id}"
      score: "#{process.env.DOMAIN}/scores/#{id}"
      musicxml: "#{process.env.DOMAIN}/scores/#{id}/musicxml"

  ###
  Parse the numbers and find possible errors in the request.
  ###
  _parseAndFindErrors: (req) ->
    errors = []

    if not req.files.audio?
      errors.push "You must send a file named 'audio'."

    [
      { name: "tempo", type: "isNumber", values: [1 .. 250], parse: true }
      { name: "major", type: "isNumber", values: [1 .. 32], parse: true }
      { name: "minor", type: "isNumber", values: [1, 2, 4, 8, 16], parse: true }
      { name: "key", type: "isString", values: ["Abm", "Ebm", "Bbm", "Fm", "Cm", "Gm", "Dm", "Am", "Em", "Bm", "F#m", "C#m", "G#m", "D#m", "A#m", "Cb", "Gb", "Db", "Ab", "Eb", "Bb", "F", "C", "G", "D", "A", "E", "B", "F#", "C#"] }
      { name: "clef", type: "isString", values: ["G", "C", "F"] }
    ].forEach (it) =>
      value = req.body[it.name]
      if it.parse then value = parseInt value
      if not value? or not _[it.type](value) or not it.values.includes(value)
        errors.push "You must send a parameter named '#{it.name}', with any value from #{it.values}."

    errors

  ###
  Deletes all the files of the request.
  ###
  _deleteFiles: (req) ->
    for name, file of req.files
      fs.unlink file.path

module.exports = (app) =>
  ctrl = new MelodyController()
  app.post "/melodies", ctrl.recognize
