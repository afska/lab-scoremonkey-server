MelodyDetector = include("melodyDetector")
MidiFile = include("midiFile")
_ = require("protolodash")

#A controller that manages server's requests.
class Controller
  #process a *request*.
  #request = { method, url, headers, body }
  do: (request, response) =>
    @log request
    new MelodyDetector("examples/happybirthday.wav")
      .getMelody()
      .then (melody) =>
        new MidiFile(melody).save "monkeybirthday.mid"
        @json response, 200, melody

  #responds a HTTP *statusCode* with a *body* in JSON format.
  json: (response, statusCode, body) =>
    response.writeHead statusCode, "Content-Type": "application/json"
    response.end JSON.stringify body

  #prints in stdout *something*, with the current date.
  log: (something) =>
    console.log new Date()
    console.log JSON.stringify _.omit something, "headers"
    console.log "----------"

module.exports = new Controller().do
