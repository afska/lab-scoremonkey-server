promisify = require("bluebird").promisifyAll
childProcess = promisify require("child_process")
_ = require("protolodash")

###
A library that recognizes notes in a file stored in *path*.
###
module.exports =

class AubioPitch
  constructor: (@path) ->
    @AUBIO_PATH = process.env.AUBIO_PATH || "lib"

  ###
  Executes the program and return a promise with the output.
  Returns a promise that resolves to something like [
   { timestamp: 0, frequency: 441.24 },
   { timestamp: 1.05, frequency: 439.88 }
  ] or rejects to an error.
  ###
  execute: => @_call().then @_parseOutput

  ###
  Converts the *output* of the stdout into objects.
  ###
  _parseOutput: (output) =>
    lines = output.split("\n").filter @_matches
    if _.isEmpty lines
      throw new Error "Unexpected output:\n#{output}"

    lines.map (line) =>
      noteInfo = line.split " "

      timestamp: parseFloat noteInfo.first()
      frequency: parseFloat noteInfo.last()

  ###
  Invokes the binary.
  ###
  _call: =>
    childProcess
      .execAsync "#{@AUBIO_PATH}/aubiopitch -i #{@path}"
      .spread (stdout, stderr) => stdout

  ###
  Checks if a line matches with a format like:
   {number} {number}
  ###
  _matches: (line) =>
    /[0-9]*\.?[0-9]+ [0-9]*\.?[0-9]+/.test line
