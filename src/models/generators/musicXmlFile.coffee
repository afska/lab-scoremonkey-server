promisify = require("bluebird").promisifyAll
fs = promisify require("fs")
o2x = require('object-to-xml');
_ = require("protolodash")

###
A MusicXml File created from a *score*.
###
module.exports =

class MusicXmlFile
  constructor: (score) ->
    @file =
      '?xml version=\"1.0\" encoding=\"UTF-8\"?' : null,
      'score-partwise' :
        '#' :
          'part-list' :
            'score-part' :
              '@' :
                id : 'P1'
              ,
              '#' :
                'part-name': 'MusicXML Part'

          part :
            '@' :
              id : 'P1'
            ,
            '#' :
              @_mapBars(score)

  ###
  Maps the bars into XML notation.
  ###
  _mapBars: (score) =>

    measureNum = 0
    measures = {}

    measures = for bar in score.bars
      measureNum += 1
      {
        '@' :
          'number' : measureNum
        '#' :
          'attributes' : if (measureNum == 1)
            @_getAtributes(bar)
          'note' : [@_mapNotes(bar.notes)]
      }

    mappedBars = 'measure' : [
      measures
    ]


  ###
  Get atributes for a MusicXML measure (bar).
  ###
  _getAtributes: (bar) =>
    {
      'divisions' : 1,
      'key':
        'fifths': 0,
        'mode': 'major'
      'time':
        'beats' : bar.signatures.time.major
        'beat-type' : bar.signatures.time.minor
      'clef':
        'sign' : bar.signatures.clef
        'line' :  @_getClefLine(bar.signatures.clef)
    }

  ###
  Maps the notes into a MusicXML object.
  ###
  _mapNotes: (notes) =>
    for note in notes
      if note.name != "r"
        mappedNote = {
          pitch :
            step : note.name.charAt(0).toUpperCase()
            octave : note.name.slice(-1)

          duration : 1
          voice : 1
          type : @_noteType(note.duration).type
        }

        if note.name.charAt(1) == "#"
          _.assign mappedNote.pitch , {alter : "1"}
        if note.name.charAt(1) == "b"
          _.assign mappedNote.pitch , {alter : "-1"}
        if note.dot == true
          _.assign mappedNote , {dot : null}

      else
        mappedNote = {
          rest : null
          duration : 1
          voice : 1
          type : @_noteType(note.duration).type
        }

      note = mappedNote


  ###
  Receives a duration and returns a note with type information with the format:

  note:{
    type: String
    duration: Float
    dot: Boolean
  }
  ###
  _noteType: (duration) =>
    noteTypes = ["whole", "half", "quarter", "eighth", "sixteenth"]
    .map (typeName, i) => [
      { type: typeName, duration: 1 / Math.pow(2, i), dot: false }
      { type: typeName, duration: 1 / Math.pow(2, i) + (1 / Math.pow(2, i + 1)) / 2, dot: true }
    ]
    .flatten()

    (noteTypes.find { duration })

  ###
  Get the pentagram line for a clef.
  ###
  _getClefLine: (clefName) =>
    associatedLine = {'G': 2, 'F': 4, 'C': 3}
    associatedLine[clefName]


  ###
  Converts the Score into a Xml.
  ###
  convertScore: =>
    o2x(@file)


  ###
  Exports the file into a *path*.
  ###
  save: (path) =>
    fs.writeFileAsync path, @convertScore()
