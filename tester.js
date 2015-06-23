require("./globals");
var MelodyDetector = include("models/melodyDetector");
var MidiFile = include("models/midiFile");

var settings = {
  filePath: process.argv[2],
  tempo: process.argv[3],
  bar: { major: 4, minor: 4 },
  clef: "G",
  options: process.argv[4]
}

new MelodyDetector(settings)
  .getMelody()
  .then(function(melody) {
    new MidiFile(melody).save("tmp.mid")
  });
