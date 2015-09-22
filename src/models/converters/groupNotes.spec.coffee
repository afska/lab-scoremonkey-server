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

  it "should group the notes by duration and mark them as tied", ->
    groupNotes([
      { duration: 2 }
      { duration: 4 }
      { duration: 5 }
      { duration: 4 }
      { duration: 3 }
    ], 5, markAsTied: true).should.eql [
      [
        { duration: 2 }
        { duration: 3, tie: 't'}
      ]
      [
        { duration: 1, tie: 'u' }
        { duration: 4, tie: 't'}
      ]
      [
        { duration: 1, tie: 'u' }
        { duration: 4 }
      ]
      [
        { duration: 3 }
      ]
    ]
