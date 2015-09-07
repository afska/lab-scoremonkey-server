fs = require("fs")

module.exports = (app) =>
  app.get "/", (req, res) -> res.send "Welcome to the ScoreMonkey server!"

  # add the routes of all controllers
  path = "#{__dirname}/controllers"
  fs
    .readdirSync(path)
    .filter (name) => /\w+\.controller\.\w+/.test name
    .forEach (file) => require("#{path}/#{file}") app
