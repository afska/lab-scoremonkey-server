mongoose = require("mongoose")
connection = mongoose.connection
Schema = mongoose.Schema
Grid = require("gridfs-stream")
Grid.mongo = mongoose.mongo
Promise = require("bluebird")

###
GridFS wrapper of MongoDb.
###
module.exports =

class GridFs
  constructor: ->
    @gfs = Grid(connection.db)

  ###
  Creates a file.
  ###
  write: (fileName, stream) =>
    new Promise (resolve) =>
      writeStream = @gfs.createWriteStream filename: fileName
      stream.pipe(writeStream).on "close", resolve

  ###
  Reads a file. It fulfills the stream with the content.
  ###
  read: (fileName, stream) =>
    new Promise (resolve) =>
      readStream = @gfs.createReadStream filename: fileName
      readStream.pipe(stream).on "close", resolve

  ###
  Deletes a file.
  ###
  delete: (fileName) =>
    new Promise (resolve, reject) =>
      @gfs.remove { filename: fileName }, (err) =>
        if err then reject err
        else resolve()
