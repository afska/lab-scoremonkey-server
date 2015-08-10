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
      '!DOCTYPE score-partwise PUBLIC \"-//Recordare//DTD MusicXML 1.0 Partwise//EN\"
                                \"http://www.musicxml.org/dtds/partwise.dtd\"' : null,
      'score-partwise' :
        '#' :
          'part-list' :
            'score-part' :
              '@' :
                id : 'P1'
              ,
              '#' :
                'part-name': 'MusicXML Part'
          ,
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

    mesureNum = 1;
    mappedBars = {}


    mappedBars = 'measure' : [
      for bar in score.bars
        '@' :
          'number' : mesureNum
        '#' :
          ###if mesureNum == 1###
          'attributes' :
            'divisions' : 1,
            'key':
              'fifths': 0,
              'mode': 'major'

          'note' : [bar.notes]



    ]

    #mesureNum += 1

    mappedBars




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

