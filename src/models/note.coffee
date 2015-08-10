_ = require("protolodash")

###
A note.

  *duration* is in beats: 3/8 is a "quarter with dot" (1/4 + 1/8)
  *name* can be:
    - a note
    - a "r" (a silence)
    - a "u" (an union)
###
module.exports =

class Note
  constructor: (@name, @duration) ->
