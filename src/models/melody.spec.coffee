require("chai").Should()
Melody = require("./melody")

describe "Melody", ->
  it "can return its notes using beats as the duration unit", ->
    notes = [
      { name: "c4", duration: 1000 }
      { name: "d4", duration: 2000 }
    ]

    new Melody(60, notes).notesWithBeats().should.eql [
      { name: "c4", duration: 1/4 }
      { name: "d4", duration: 1/2 }
    ]
