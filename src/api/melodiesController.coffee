MelodyDetector = include("melodyDetector")
MidiFile = include("midiFile")

#A controller that manages audio recognition.
class MelodiesController
  #recognize an audio file, returns the MIDI & MusicXML
  recognize: (req, res) =>
    new MelodyDetector("examples/happybirthday.wav")
      .getMelody()
      .then (melody) =>
        new MidiFile(melody).save "monkeybirthday.mid"
        res.json melody

module.exports = (app) =>
  ctrl = new MelodiesController()
  app.post "/melodies", ctrl.recognize
