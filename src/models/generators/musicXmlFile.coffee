Midi = require("jsmidgen")
promisify = require("bluebird").promisifyAll
fs = promisify require("fs")
o2x = require('object-to-xml');

###
A MusicXml File created from a *score*.
###
module.exports =

class MusicXmlFile
  constructor: (score) ->
    @file = {
      '?xml version=\"1.0\" encoding=\"UTF-8\"?' : null,
      '!DOCTYPE score-partwise PUBLIC \"-//Recordare//DTD MusicXML 1.0 Partwise//EN\"
                                \"http://www.musicxml.org/dtds/partwise.dtd\"' : null,
      }


  ###
  var obj = {
    '?xml version=\"1.0\" encoding=\"UTF-8\"?' : null,
    request : {
      '@' : {
        type : 'product',
        id : 12344556
      },
      '#' : {
        query : {
          vendor : 'redhat',
          name : 'linux'
        }
      }
    }
  };
  ###

  ###
  <?xml version="1.0" encoding="iso-8859-1"?>
  <request type="product" id="12344556">
    <query>
      <vendor>redhat</vendor>
      <name>linux</name>
    </query>
  </request>
  ###


  ###
  Converts the Score into a Xml.
  ###
  convertScore: =>
    o2x(@file)

  ###
  Exports the file into a *path*.
  ###
  save: (path) =>
    fs.writeFileAsync path, convertScore()

