require("chai").Should()
musicXmlFile = require("./musicXmlFile")

describe "musicXmlFile", ->
  it "converts a score object to XML as spected", ->

    scoreExample =
      settings:
        tempo: 60
        signatures:
          time:
            major: 4
            minor: 4
          key: 'Abm'
          clef: 'G'
      bars: [
        {
          signatures:
            time:
              major: 4
              minor: 4
            key: 'Abm'
            clef: 'G'
          notes: [
            {
              name:'c4'
              duration: 1/4
            }
            {
              name:'c#4'
              duration: 1/4
            }
            {
              name:'d4'
              duration: 1/4
            }
            {
              name:'d#4'
              duration: 1/4
            }
          ]
        }
        {
          signatures:
            time:
              major: 4
              minor: 4
            key: 'Abm'
            clef: 'G'
          notes: [
            {
              name:'r'
              duration: 1
            }
          ]
        }
      ]

    # tengo que hacer algo para poder testear sin poner los \n"
    musicXmlExample = '<?xml version="1.0" encoding="UTF-8"?>\n<!DOCTYPE score-partwise PUBLIC "-//Recordare//DTD MusicXML 1.0 Partwise//EN" "http://www.musicxml.org/dtds/partwise.dtd" />\n'

    #BORRAR cuando termine de testear posta:
    #new musicXmlFile(scoreExample).save('/home/javier/Escritorio/MusicXMLExample.xml')

    #new musicXmlFile(scoreExample).convertScore().should.be.equal musicXmlExample



