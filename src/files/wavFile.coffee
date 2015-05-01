promisify = require("bluebird").promisifyAll
wavToArray = promisify require("ndarray-wav")
module.exports =

#A WAV file that is stored in a *path*.
class WavFile
  constructor: (@path) ->

  getBuffer: =>
    wavToArray
      .openAsync @path
      .spread ({data}) => data.data
