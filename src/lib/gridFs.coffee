Grid = require("gridfs")
Promise = require("bluebird")
mongoose = require("mongoose")

###
GridFS wrapper of MongoDb.
###
module.exports =

class GridFs
  constructor: ->
    connection = mongoose.connection
    mongo = mongoose.mongo

    @gfs = Promise.promisifyAll Grid(connection.db, mongo)

  ###
  Creates a file.
  ###
  write: (fileName, buffer) =>
    @gfs.writeFileAsync { filename: fileName }, buffer

  ###
  Reads a file and return a promise with its content.
  ###
  read: (fileName) =>
    @gfs.readFileAsync { filename: fileName }
