require("chai").Should()
Bar = require("./bar")

describe "Bar", ->
  describe "isComplete method", ->

    it "returns true when a bar is completely filled with notes", ->

      signatures = {
        time: { major: 4, minor: 4 },
        key: "Abm",
        clef: "G"
      }

      notes = [
        { name: "c4", duration: 1/8 }
        { name: "c4", duration: 1/8 }
        { name: "c4", duration: 1/4 }
        { name: "c4", duration: 1/2 }
      ]

      new Bar(signatures, notes).isComplete().should.eql true


    it "returns false when a bar is incomplete", ->
      signatures = {
        time: { major: 6, minor: 8 },
        key: "Abm",
        clef: "G"
      }

      notes = [
        { name: "c4", duration: 1/4 }
        { name: "d4", duration: 1/8 }
        { name: "e4", duration: 1/8 }
        { name: "f4", duration: 1/8 }
      ]

      new Bar(signatures, notes).isComplete().should.eql false
