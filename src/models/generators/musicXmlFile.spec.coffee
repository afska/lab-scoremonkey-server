chai = require("chai")
expect  = require('chai').expect;
MusicXmlFile = require("./musicXmlFile")
chaiXml = require('chai-xml');
Melody = include("models/melody")
Note = include("models/note")
Scorizer = require("./scorizer")

chai.use(chaiXml);

describe "MusicXmlFile", ->
  it "converts a score object to XML as spected", ->
    scoreExample =
      settings:
        tempo: 60
        signatures:
          time:
            numerator: 4
            denominator: 4
          key: 'Abm'
          clef: 'F'
      bars: [
        {
          signatures:
            time:
              numerator: 4
              denominator: 4
            key: 'Abm'
            clef: 'F'
          notes: [
            new Note(
              {
                name:'c4'
                duration: 1/4
              }
            ),
            new Note(
              {
                name:'c#4'
                duration: 1/4
              }
            ),
            new Note(
              {
                name:'d4'
                duration: 1/4
              }
            ),
            new Note(
              {
                name:'db4'
                duration: 1/8
                tie: {start: true}
              }
            )
          ]
        }
        {
          signatures:
            time:
              numerator: 4
              denominator: 4
            key: 'Abm'
            clef: 'F'
          notes: [
            new Note(
              {
                name:'db4'
                duration: 1/8
                tie: {
                  stop: true
                  start: true
                }
              }
            ),
            new Note(
              {
                name:'db4'
                duration: 1/8
                tie: {stop: true}
              }
            ),
            new Note(
              {
                name:'r'
                duration: 1.5
              }
            ),
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
            <staves>1</staves>
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
            <duration>64</duration>
            <voice>1</voice>
            <type>quarter</type>
          </note>
          <note>
            <pitch>
              <step>C</step>
              <octave>4</octave>
              <alter>1</alter>
            </pitch>
            <duration>64</duration>
            <voice>1</voice>
            <type>quarter</type>
          </note>
          <note>
            <pitch>
              <step>D</step>
              <octave>4</octave>
            </pitch>
            <duration>64</duration>
            <voice>1</voice>
            <type>quarter</type>
          </note>
          <note>
            <pitch>
              <step>D</step>
              <octave>4</octave>
              <alter>-1</alter>
            </pitch>
            <duration>32</duration>
            <voice>1</voice>
            <type>eighth</type>
            <tie type="start" />
            <notations>
              <tied type="start" />
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
            <duration>32</duration>
            <voice>1</voice>
            <type>eighth</type>
            <tie type="stop" />
            <tie type="start" />
            <notations>
              <tied type="stop" />
            </notations>
            <notations>
              <tied type="start" />
            </notations>
          </note>
          <note>
            <pitch>
              <step>D</step>
              <octave>4</octave>
              <alter>-1</alter>
            </pitch>
            <duration>32</duration>
            <voice>1</voice>
            <type>eighth</type>
            <tie type="stop" />
            <notations>
              <tied type="stop" />
            </notations>
          </note>
          <note>
            <rest />
            <duration>384</duration>
            <voice>1</voice>
            <type>whole</type>
            <dot />
          </note>
        </measure>
      </part>
    </score-partwise>
    '

    #No borrar esta línea hasta salir a producción (la uso todo el tiempo :P)
    #new musicXmlFile(scoreExample).save('/home/javier/Escritorio/testingMusic.xml')

    convertedScore = new MusicXmlFile(scoreExample).convertScore()
    expect(convertedScore).xml.to.equal(musicXmlExample);


  it "create a MusicXML from a scorized Score", ->
    signatures =
      time: { numerator: 4, denominator: 4 }
      key: "Abm"
      clef: "G"

    melody = new Melody 60, [
      { name: "c4", duration: 3000 } # half + quarter
      { name: "c#4", duration: 1250 } # quarter + sixteenth
      { name: "e5", duration: 3750 } # 15 sixteenth's to complete the second bar
    ]

    settings = tempo: 60, signatures: signatures
    scoreExample = new Scorizer(melody).build settings

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
            <staves>1</staves>
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
            <duration>192</duration>
            <voice>1</voice>
            <type>half</type>
            <dot />
          </note>
          <note>
            <pitch>
              <step>C</step>
              <octave>4</octave>
              <alter>1</alter>
            </pitch>
            <duration>64</duration>
            <voice>1</voice>
            <type>quarter</type>
            <notations>
              <tied type="start" />
            </notations>
            <tie type="start" />
          </note>
        </measure>
        <measure number="2">
          <attributes />
          <note>
            <pitch>
              <step>C</step>
              <octave>4</octave>
              <alter>1</alter>
            </pitch>
            <duration>16</duration>
            <voice>1</voice>
            <type>16th</type>
            <tie type="stop" />
            <notations>
              <tied type="stop" />
            </notations>
          </note>
          <note>
            <pitch>
              <step>E</step>
              <octave>5</octave>
            </pitch>
            <duration>192</duration>
            <voice>1</voice>
            <type>half</type>
            <dot />
            <tie type="start" />
            <notations>
              <tied type="start" />
            </notations>
          </note>
          <note>
            <pitch>
              <step>E</step>
              <octave>5</octave>
            </pitch>
            <duration>48</duration>
            <voice>1</voice>
            <type>eighth</type>
            <dot />
            <tie type="stop" />
            <notations>
              <tied type="stop" />
            </notations>
          </note>
        </measure>
      </part>
    </score-partwise>
    '

    convertedScore = new MusicXmlFile(scoreExample).convertScore()
    expect(convertedScore).xml.to.equal(musicXmlExample);


