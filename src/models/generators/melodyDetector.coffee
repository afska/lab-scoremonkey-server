AubioPitch = include("lib/aubioPitch")
Melody = include("models/melody")
promisify = require("bluebird").promisifyAll
fs = promisify require("fs")
_ = require("protolodash")

###
A generator of *melodies* using an audio recognizer.
  @Input  settings =
            filePath: "/home/user/path/audioFile.wav"
            tempo: 180
            signatures:
              key: "Abm"
              time: { major: 4, minor: 4 }
              clef: "G"
###
module.exports =

class MelodyDetector
  constructor: (@settings) ->
    @recognizer = new AubioPitch(@settings.filePath, @settings.options)

  ###
  Generates the melody using the output of the recognizer
  and a dynamic list of chained postprocessors (_.flow).
  ###
  getMelody: =>
    @recognizer.execute().then (samples) =>
      path = "#{__dirname}/postprocessors"

      fs.readdirAsync(path).then (dir) =>
        postProcessors = dir
          .reject (file) => file.startsWith(".") or _.contains(file, "spec")
          .map (file) => require("#{path}/#{file}").bind @, @settings

        notes = (_.flow.apply @, postProcessors)(samples)

        new Melody @settings.tempo, notes
