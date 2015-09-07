GridFs = include("lib/gridFs")

###
A controller that serve the MIDI files of the db.
###
module.exports = (app) =>
  app.get "/midis/:id", (req, res) ->
    new GridFs().read("#{req.params.id}.mid")
      .then (data) =>
        res.setHeader "Content-Type", "application/x-midi"
        res.status(200).end data
      .catch => res.status(404).end()
