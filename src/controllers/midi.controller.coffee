GridFs = include("lib/gridFs")

###
A controller that serve the MIDI files of the db.
###
module.exports = (app) =>
  app.get "/midis/:fileName", (req, res) ->
    res.setHeader "Content-Type", "application/x-midi"
    new GridFs().read req.params.fileName, res
