require("chai").Should()
Promise = require("bluebird")
Melody = require("./melody")

describe "Melody", ->
  it "can return its notes using beats as the duration unit", ->
    notes = [
      { note: "c4", duration: 1000 }
      { note: "d4", duration: 2000 }
    ]

    new Melody(60, notes).notesWithBeats().should.eql [
      { note: "c4", duration: 1/4 }
      { note: "d4", duration: 1/2 }
    ]
