express = require("express")
_ = require("protolodash")

###
A http server that listen to connections and delegates requests to the controller.
###
module.exports = =>
  _.assign process.env, try require("./config/env")
  port = process.env.PORT || 8081

  app = express()
  app.use require("body-parser").json limit: "50mb" # json parser
  app.use require("morgan") "dev" # logger
  app.use require("multer") dest: "#{__rootpath}/uploads" # multipart files

  require("./routes") app

  app.listen port
  console.log "[!] Listening in port #{port}"
