promisify = require("bluebird").promisifyAll
childProcess = promisify require("child_process")

module.exports =

class PitchDetector
  constructor: (@filePath) ->

  getPitch: =>
    childProcess
      .execAsync "#{__rootpath}/lib/aubiopitch -i #{@filePath}"
      .spread (stdout, stderr) => stdout
