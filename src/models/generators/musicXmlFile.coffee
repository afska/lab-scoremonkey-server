promisify = require("bluebird").promisifyAll
fs = promisify require("fs")
o2x = require('object-to-xml')
_ = require("protolodash")
Note = include("models/note")


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
  Converts the Score into a Xml.
  ###
  convertScore: =>
    o2x(@file)

  ###
  Exports the file into a *path*.
  ###
  save: (path) =>
    fs.writeFileAsync path, @convertScore()

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
        'fifths': @_getFifthsAmount(bar.signatures.key), #(-7,7)
        'mode': @_getMode(bar.signatures.key) # {'minor', 'major'}
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
    notes.map (note, i) =>

      mappedNote =
        duration : 1
        voice : 1
        type : note.figure().name

      if note.name is "r"
         _.assign mappedNote , {rest : null}
      else
        _.assign mappedNote , {
          pitch :
            step : note.name.charAt(0).toUpperCase()
            octave : note.name.slice(-1)
          }

      if note.name.charAt(1) is "#"
        _.assign mappedNote.pitch , {alter : "1"}
      if note.name.charAt(1) is "b"
        _.assign mappedNote.pitch , {alter : "-1"}
      if note.figure().dot is true
        _.assign mappedNote , {dot: null}
      if note.tie
        mappedNote = @_appendTies(note, mappedNote)

      mappedNote

  ###
  Append ties from a note to another note.
  First checks for the stop, then for the start
  (this is the right order... do not alter it!).
  ###
  _appendTies: (note, mappedNote) =>
    _.assign mappedNote , notations: []
    _.assign mappedNote , tie: []

    if note.tie.stop is true
      mappedNote.tie.push
          '@' :
            type : 'stop'
          ,
          '#' :
            null
      mappedNote.notations.push
        '@' :
          null
        '#' :
          tied :
            '@' :
              type : 'stop'
            ,
            '#' :
              null
    if note.tie.start is true
      mappedNote.tie.push
          '@' :
            type : 'start'
          ,
          '#' :
            null
      mappedNote.notations.push
        '@' :
          null
        '#' :
          tied :
            '@' :
              type : 'start'
            ,
            '#' :
              null

    mappedNote

  ###
  Gets the amount of fifths inside the key signature.
    A negative amount represents flats; a positive amount represents sharps.
  ###
  _getFifthsAmount: (key) =>
    sharpMajor = ["C", "G", "D", "A", "E", "B", "F#", "C#"]
    flatMajor = ["C", "F", "Bb", "Eb", "Ab", "Db", "Gb", "Cb"]
    sharpMinor = ["Am", "Em", "Bm", "F#m", "C#m", "G#m", "D#m", "A#m"]
    flatMinor = ["Am", "Dm", "Gm", "Cm", "Fm", "Bbm", "Ebm", "Abm"]

    mappedKey = [sharpMajor, flatMajor, sharpMinor, flatMinor]
      .map (array, j) =>
        factor = if j % 2 > 0 then -1 else 1
        array.map (keyName, i) =>
          { key: "#{keyName}", fifthsAmount: "#{i*factor}" }
      .flatten()
      .find { key }

    mappedKey.fifthsAmount

  ###
  Gets the mode of the melody.
  ###
  _getMode: (key) =>
    if _.endsWith(key, 'm') then 'minor' else 'major'

  ###
  Gets the pentagram line for a clef.
  ###
  _getClefLine: (clefName) =>
    associatedLine = {'G': 2, 'F': 4, 'C': 3}
    associatedLine[clefName]
