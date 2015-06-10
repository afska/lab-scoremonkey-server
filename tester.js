require("./globals");
var MelodyDetector = include("melodyDetector");
var MidiFile = include("midiFile");

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
