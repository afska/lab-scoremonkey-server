require("chai").Should()
Melody = include("models/melody")
Scorizer = require("./scorizer")
shouldBeEquivalent = include("utils/shouldBeEquivalent")

describe "Scorizer", ->
  signatures =
    time: { numerator: 4, denominator: 4 }
    key: "Abm"
    clef: "G"

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
            { name: "c4", duration: 1/4, tie: { start: false, stop: false }  }
            { name: "c#4", duration: 1/2, tie: { start: false, stop: false }  }
            { name: "a5", duration: 1/4, tie: { start: true, stop: false } }
          ]
        }
        {
          signatures: signatures
          notes: [
            { name: "a5", duration: 1/8, tie: { start: false, stop: true } }
            { name: "e8", duration: 1/8, tie: { start: false, stop: false } }
            { name: "r", duration: 3/4, tie: { start: false, stop: false } }
          ]
        }
        {
          signatures: signatures
          notes: [
            { name: "d4", duration: 1/16, tie: { start: false, stop: false } }
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
    score = new Scorizer(melody).build settings

    shouldBeEquivalent score,
      settings: settings
      bars:[
        {
          signatures: signatures
          notes: [
            { name: "c4", duration: 1/2 + 1/4, tie: { start: false, stop: false } } # half with dot
            { name: "c#4", duration: 1/4, tie: { start: true, stop: false } } # quarter
          ]
        }
        {
          signatures: signatures
          notes: [
            { name: "c#4", duration: 1/16, tie: { start: false, stop: true } } # sixteenth
            { name: "e5", duration: 1/2 + 1/4, tie: { start: true, stop: false } } # half with dot
            { name: "e5", duration: 1/8 + 1/16, tie: {  start: false, stop: true } } # eighth with dot
          ]
        }
      ]
