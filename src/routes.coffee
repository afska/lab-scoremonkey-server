module.exports = (app) =>
  app.get "/", (req, res) -> res.send "Welcome to the ScoreMonkey server!"

  require("./controllers/melodyController") app
  require("./controllers/scoreController") app
