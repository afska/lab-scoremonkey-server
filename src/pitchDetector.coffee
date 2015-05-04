promisify = require("bluebird").promisifyAll
childProcess = promisify require("child_process")

module.exports =

class PitchDetector
  constructor: (@filePath) ->
    @AUBIO_PATH = process.env.AUBIO_PATH || "lib"

  getPitch: =>
    childProcess
      .execAsync "#{@AUBIO_PATH}/aubiopitch -i #{@filePath}"
      .spread (stdout, stderr) => stdout
