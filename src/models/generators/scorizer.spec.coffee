require("chai").Should()
Melody = include("models/melody")
Scorizer = require("./scorizer")

describe "Scorizer", ->
  shouldBeEquivalent = (one, another) =>
    #(removes the methods in the objects for the comparison)
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

    signatures =
      time: { major: 4, minor: 4 }
      key: "Abm"
      clef: "G"

    settings = tempo: 60, signatures: signatures

    score = new Scorizer(melody).build settings

    score.settings.should.be.eql settings
    shouldBeEquivalent score.bars, [
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
