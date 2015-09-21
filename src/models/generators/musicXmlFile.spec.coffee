chai = require("chai")
expect  = require('chai').expect;
musicXmlFile = require("./musicXmlFile")
chaiXml = require('chai-xml');

chai.use(chaiXml);

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
          clef: 'F'
      bars: [
        {
          signatures:
            time:
              major: 4
              minor: 4
            key: 'Abm'
            clef: 'F'
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
              name:'db4'
              duration: 1/8
              splitted: 't'
            }
          ]
        }
        {
          signatures:
            time:
              major: 4
              minor: 4
            key: 'Abm'
            clef: 'F'
          notes: [
            {
              name:'db4'
              duration: 1/8
              splitted: 'u'
            }
            {
              name:'r'
              duration: 1
              dot: true
            }
          ]
        }
      ]


    musicXmlExample = '<?xml version="1.0" encoding="UTF-8"?>
    <score-partwise>
      <part-list>
        <score-part id="P1">
          <part-name>MusicXML Part</part-name>
        </score-part>
      </part-list>
      <part id="P1">
        <measure number="1">
          <attributes>
            <divisions>1</divisions>
            <key>
              <fifths>-7</fifths>
              <mode>minor</mode>
            </key>
            <time>
              <beats>4</beats>
              <beat-type>4</beat-type>
            </time>
            <clef>
              <sign>F</sign>
              <line>4</line>
            </clef>
          </attributes>
          <note>
            <pitch>
              <step>C</step>
              <octave>4</octave>
            </pitch>
            <duration>1</duration>
            <voice>1</voice>
            <type>quarter</type>
          </note>
          <note>
            <pitch>
              <step>C</step>
              <octave>4</octave>
              <alter>1</alter>
            </pitch>
            <duration>1</duration>
            <voice>1</voice>
            <type>quarter</type>
          </note>
          <note>
            <pitch>
              <step>D</step>
              <octave>4</octave>
            </pitch>
            <duration>1</duration>
            <voice>1</voice>
            <type>quarter</type>
          </note>
          <note>
            <pitch>
              <step>D</step>
              <octave>4</octave>
              <alter>-1</alter>
            </pitch>
            <duration>1</duration>
            <voice>1</voice>
            <type>eighth</type>
            <tie type="start"/>
            <notations>
              <tied type="start"/>
            </notations>
          </note>
        </measure>
        <measure number="2">
          <attributes />
          <note>
            <pitch>
              <step>D</step>
              <octave>4</octave>
              <alter>-1</alter>
            </pitch>
            <duration>1</duration>
            <voice>1</voice>
            <type>eighth</type>
            <tie type="stop"/>
            <notations>
              <tied type="stop"/>
            </notations>
          </note>
          <note>
            <rest />
            <duration>1</duration>
            <voice>1</voice>
            <type>whole</type>
            <dot />
          </note>
        </measure>
      </part>
    </score-partwise>
    '

    #No borrar esta línea hasta salir a producción (la uso todo el tiempo :P)
    #new musicXmlFile(scoreExample).save('/home/javiersorella/Desktop/testingMusic.xml')

    convertedScore = new musicXmlFile(scoreExample).convertScore()

    expect(convertedScore).xml.to.equal(musicXmlExample);



