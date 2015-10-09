Mplayer = include("lib/mPlayer")
AubioPitch = include("lib/aubioPitch")
Melody = include("models/melody")
promisify = require("bluebird").promisifyAll
uuid = require("uuid")
fs = promisify require("fs")
_ = require("protolodash")

###
A generator of *melodies* using an audio recognizer.
  @Input:
  settings =
    filePath: "/home/user/path/audioFile.wav"
    tempo: 180
    signatures:
      key: "Abm"
      time: { numerator: 4, denominator: 4 }
      clef: "G"
###
module.exports =

class MelodyDetector
  constructor: (@settings) ->
    @tmpFile = "#{__rootpath}/blobs/encoded/#{uuid.v4()}.wav"

    @decoder = new Mplayer(@settings.filePath)
    @recognizer = new AubioPitch(@tmpFile, @settings.options)

  ###
  Generates the melody using the output of the recognizer
  and a dynamic list of chained postprocessors (_.flow).
  ###
  getMelody: =>
    @_recognize().then (samples) =>
      path = "#{__dirname}/postprocessors"

      fs.readdirAsync(path).then (dir) =>
        postProcessors = dir
          .reject (file) => file.startsWith(".") or _.contains(file, "spec")
          .map (file) => require("#{path}/#{file}").bind @, @settings

        notes = (_.flow.apply @, postProcessors)(samples)

        new Melody @settings.tempo, notes

  ###
  Uses mplayer and aubiopitch to recognize the frequencies.
  ###
  _recognize: =>
    @decoder
      .convertToWav @tmpFile
      .then @recognizer.execute
      .finally =>
        fs.unlink @tmpFile
