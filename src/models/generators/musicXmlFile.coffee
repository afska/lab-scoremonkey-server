Midi = require("jsmidgen")
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
  Get atributes.
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
        'line' : 2
    }

  ###
  Maps the notes.
  ###
  _mapNotes: (notes) =>
    for note in notes
      if note.name != "r"
        mappedNote = {
          pitch :
            step : note.name.charAt(0)
            octave : note.name.slice(-1)

          duration : 1
          voice : 1
          type : @_noteType(note.duration)
        }

        if note.name.charAt(1) == "#"
          _.assign mappedNote.pitch , {alter : "1"}
        if note.name.charAt(1) == "b"
          _.assign mappedNote.pitch , {alter : "-1"}

      else
        mappedNote = {
          rest : null
          duration : 1
          voice : 1
          type : @_noteType(note.duration)
        }

      note = mappedNote


  ###
  Returns the name of the note type.
  ###
  _noteType: (duration) =>
    durationToName = []
    durationToName[1] = 'whole'
    durationToName[0.5] = 'half'
    durationToName[0.25] = 'quarter'
    durationToName[0.125] = 'eighth'
    durationToName[0.0625] = 'sixteenth'

    durationToName[duration]



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

