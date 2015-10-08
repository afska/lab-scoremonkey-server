promisify = require("bluebird").promisifyAll
childProcess = promisify require("child_process")

###
A program that can convert audio files to PCM WAVs.
###
module.exports =

class Mplayer
  constructor: (@inputPath) ->

  ###
  Executes the program and returns a promise that will be
  fulfilled when the convertion has finished.
  ###
  convertToWav: (outputPath) =>
    command = """mplayer -ao pcm:fast:waveheader:file="#{outputPath}" -vo null -vc null -format s16le "#{@inputPath}" """

    childProcess
      .execAsync command, maxBuffer: Number.MAX_VALUE
      .spread (stdout, stderr) => stdout

