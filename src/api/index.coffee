express = require("express")
_ = require("protolodash")

#A http server that listen to connections and delegates requests to the controller.
module.exports = =>
  port = process.env.PORT || 8081

  app = express()
  app.use require("body-parser").json() # json parser
  app.use require("morgan") "dev" # logger
  app.use require("multer") dest: "#{__rootpath}/uploads" # multipart files

  require("./routes") app

  app.listen port
  console.log "[!] Listening in port #{port}"
