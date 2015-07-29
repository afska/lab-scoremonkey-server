###
A controller that serve *scores* by id.
###
module.exports = (app) =>
  app.get "/scores/:id", (req, res) ->
    res.render "scores", id: req.params.id
