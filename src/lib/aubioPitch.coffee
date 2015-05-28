promisify = require("bluebird").promisifyAll
childProcess = promisify require("child_process")
include("utils/objectUtils")
module.exports =

#A library that recognize notes in a file stored in *path*.
class AubioPitch
  constructor: (@path) ->
    @AUBIO_PATH = process.env.AUBIO_PATH || "lib"

  #execute the program and return a promise with the output.
  #the return value is a promise.
  execute: => @_call().then @_parseOutput

  #convert the *output* of the stdout to objects.
  _parseOutput: (output) =>
    lines = output.split "\n"
    lines.map (line) =>
      noteInfo = line.split " "

      timestamp: parseFloat noteInfo.first()
      frequency: parseFloat noteInfo.last()

  #invoke the binary.
  _call: =>
    childProcess
      .execAsync "#{@AUBIO_PATH}/aubiopitch -i #{@path}"
      .spread (stdout, stderr) => stdout