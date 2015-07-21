_ = require("protolodash")

###
Note Entity.

  *duration* is in beats: 3/8 is a "negra con puntillo" (1/4 + 1/8)
  *name* can be:
    - a note
    - a "r" (a silence)
    - a "u" (an union or "nota ligada a la anterior")
###
class Note
  constructor: (@name, @duration) ->
