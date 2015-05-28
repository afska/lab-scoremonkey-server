AubioPitch = include("lib/aubioPitch")
noteDictionary = include("noteDictionary")
_ = require("protolodash")
module.exports =

#A generator of melodies using an audio recognizer.
#The audio source is in a file stored in *filePath*.
class MelodyDetector
  constructor: (filePath) ->
    @recognizer = new AubioPitch(filePath)

  #generate the melody from the output of the recognizer.
  #returns a promise that resolves in something like [
  # { timestamp: 0, note: "r" },
  # { timestamp: 1.05, note: "c#4" }
  #]
  getMelody: =>
    @recognizer.execute().then (output) =>
      mapped = output
        .map (sampleInfo) =>
          detected = noteDictionary.whatIs sampleInfo.frequency
          _.assign _.omit(sampleInfo, "frequency"), note: detected?.note

      mapped
        .reject (sampleInfo, i) =>
          if not sampleInfo.note? then return true

          detected = (it) => it?.note
          detected(sampleInfo) is detected(mapped[i - 1])
