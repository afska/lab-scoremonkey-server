express = require("express")
mongoose = require("mongoose")
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
  app.use require("multer") dest: "#{__rootpath}/blobs/uploads" # multipart files
  app.use express.static("views") # serve client side
  app.engine "html", require("ejs").renderFile # rendering engine
  app.set "view engine", "html" # view engine

  require("./routes") app

  # ensure the blobs directories exist...
  mkdirp = require("mkdirp")
  mkdirp "#{__rootpath}/blobs/uploads"

  # connect to mongodb...
  dbUri = process.env.MONGO_URI || "mongodb://localhost/scoremonkey"
  console.log "[!] Connecting to #{dbUri}..."
  mongoose.connect dbUri, (err) =>
    if err then throw new Error(err)

    # listen...
    app.listen port
    console.log "[!] Listening in port #{port}..."
