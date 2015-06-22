require("./globals");
var MelodyDetector = include("models/melodyDetector");
var MidiFile = include("models/midiFile");

var settings = {
  filePath: "tmp.wav",
  tempo: 120,
  bar: { major: 4, minor: 4 },
  clef: "G"
}

new MelodyDetector(settings)
  .getMelody()
  .then(function(melody) {
    new MidiFile(melody).save("tmp.mid")
  });
