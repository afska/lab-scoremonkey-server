require("./globals");
var MelodyDetector = include("models/generators/melodyDetector");
var MidiFile = include("models/generators/midiFile");

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
