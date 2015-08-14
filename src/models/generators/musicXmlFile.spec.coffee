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
              <fifths>0</fifths>
              <mode>major</mode>
            </key>
            <time>
              <beats>4</beats>
              <beat-type>4</beat-type>
            </time>
            <clef>
              <sign>G</sign>
              <line>2</line>
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
              <alter>1</alter>
            </pitch>
            <duration>1</duration>
            <voice>1</voice>
            <type>quarter</type>
          </note>
        </measure>
        <measure number="2">
          <attributes />
          <note>
            <rest />
            <duration>1</duration>
            <voice>1</voice>
            <type>whole</type>
          </note>
        </measure>
      </part>
    </score-partwise>
    '

    convertedScore = new musicXmlFile(scoreExample).convertScore()

    expect(convertedScore).xml.to.equal(musicXmlExample);



