GridFs = include("lib/gridFs")

###
A controller that serve *scores* by id.
###
module.exports = (app) =>
  app.get "/scores/:id", (req, res) ->
    res.render "scores", id: req.params.id

  app.get "/scores/:id/musicxml", (req, res) ->
    new GridFs().read("#{req.params.id}.xml")
      .then (data) =>
        res.setHeader "Content-Type", "application/xml"
        res.status(200).end data
      .catch => res.status(404).end()
