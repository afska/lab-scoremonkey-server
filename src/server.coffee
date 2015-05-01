http = require("http")
controller = include("controller")
_ = include("utils/objectUtils")

#A http server that listen to connections and delegates requests to the controller.
module.exports = =>
  port = process.env.PORT || 8081

  http
    .createServer (req, res) =>
      data = ""
      req.on "data", (chunk) => data += chunk
      req.on "end", =>
        req = _.pick req, "method", "url", "headers"
        controller (_.assign req, body: data), res
    .listen port

  console.log "[!] Listening in port #{port}"
