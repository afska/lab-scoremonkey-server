require("./globals");
var MelodyDetector = include("models/generators/melodyDetector");
var MidiFile = include("models/generators/midiFile");

var options = process.argv[4];

var settings = {
  filePath: process.argv[2],
  tempo: process.argv[3],
  bar: { numerator: 4, denominator: 4 },
  clef: "G",
  options: options != "" ? options : null
}

new MelodyDetector(settings)
  .getMelody()
  .then(function(melody) {
    new MidiFile(melody).save("tmp.mid")
  });
