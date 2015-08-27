require("chai").Should()
Melody = include("models/melody")
Scorizer = require("./scorizer")

describe "Scorizer", ->
  signatures =
    time: { major: 4, minor: 4 }
    key: "Abm"
    clef: "G"

  shouldBeEquivalent = (one, another) =>
    # (removes the methods in the objects for the comparison)
    clean = (o) => JSON.parse JSON.stringify o
    clean(one).should.be.eql clean(another)

  it "should convert a melody into a score", ->
    melody = new Melody 60, [
      { name: "c4", duration: 1000 }
      { name: "c#4", duration: 2000 }
      { name: "a5", duration: 1500 }
      { name: "e8", duration: 500 }
      { name: "r", duration: 3000 }
      { name: "d4", duration: 250 }
    ]

    settings = tempo: 60, signatures: signatures
    score = new Scorizer(melody).build settings

    shouldBeEquivalent score,
      settings: settings
      bars: [
        {
          signatures: signatures
          notes: [
            { name: "c4", duration: 1/4 }
            { name: "c#4", duration: 1/2 }
            { name: "a5", duration: 1/4 }
          ]
        }
        {
          signatures: signatures
          notes: [
            { name: "u", duration: 1/8 }
            { name: "e8", duration: 1/8 }
            { name: "r", duration: 3/4 }
          ]
        }
        {
          signatures: signatures
          notes: [
            { name: "d4", duration: 1/16 }
          ]
        }
      ]

  it "detects valid durations correctly", ->
    melody = new Melody 60, [
      { name: "c4", duration: 3000 } # half + quarter
      { name: "c#4", duration: 1250 } # quarter + sixteenth
      { name: "e5", duration: 3750 } # 15 sixteenth's to complete the second bar
    ]

    settings = tempo: 60, signatures: signatures
    debugger
    score = new Scorizer(melody).build settings

    shouldBeEquivalent score,
      settings: settings
      bars:[
        {
          signatures: signatures
          notes: [
            { name: "c4", duration: 1/2 + 1/4 }
            { name: "c#4", duration: 1/4 }
          ]
        }
        {
          signatures: signatures
          notes: [
            { name: "u", duration: 1/16 }
            { name: "e5", duration: 1/2 + 1/4 }
            { name: "u", duration: 1/4 + 1/8 }
          ]
        }
      ]
