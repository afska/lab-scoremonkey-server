module.exports = (app) =>
  app.get "/", (req, res) -> res.send "Welcome to the ScoreMonkey server!"

  require("./melodiesController") app
