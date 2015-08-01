require("chai").Should()
groupNotes = require("./groupNotes")

describe "groupNotes", ->
  it "should group the notes by duration", ->
    groupNotes([
      { duration: 2 }
      { duration: 4 }
      { duration: 5 }
      { duration: 4 }
      { duration: 3 }
    ], 5).should.eql [
      [ { duration: 2 }, { duration: 3 } ]
      [ { duration: 1 }, { duration: 4 } ]
      [ { duration: 1 }, { duration: 4 } ]
      [ { duration: 3 } ]
    ]

  it "should group the notes by duration and mark them as splitted", ->
    groupNotes([
      { duration: 2 }
      { duration: 4 }
      { duration: 5 }
      { duration: 4 }
      { duration: 3 }
    ], 5, markAsSplitted: true).should.eql [
      [
        { duration: 2 }
        { duration: 3 }
      ]
      [
        { duration: 1, splitted: true }
        { duration: 4 }
      ]
      [
        { duration: 1, splitted: true }
        { duration: 4 }
      ]
      [
        { duration: 3 }
      ]
    ]
