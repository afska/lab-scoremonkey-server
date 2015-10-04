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

  it "should not add an empty array when the last group is full", ->
    groupNotes([
      { duration: 2 }
      { duration: 4 }
      { duration: 5 }
      { duration: 4 }
    ], 5).should.eql [
      [ { duration: 2 }, { duration: 3 } ]
      [ { duration: 1 }, { duration: 4 } ]
      [ { duration: 1 }, { duration: 4 } ]
    ]

  it "should group the notes by duration and mark them as tied", ->
    groupNotes([
      { duration: 2, tie: { start: false, stop: false } }
      { duration: 4, tie: { start: true, stop: false } }
      { duration: 5, tie: { start: false, stop: true } }
      { duration: 4, tie: { start: false, stop: false } }
      { duration: 3, tie: { start: false, stop: false } }
    ], 5, markAsTied: true).should.eql [
      [
        { duration: 2, tie: { start: false, stop: false } }
        { duration: 3, tie: { start: true, stop: false } }
      ]
      [
        { duration: 1, tie: { start: true, stop: true } }
        { duration: 4, tie: { start: true, stop: true } }
      ]
      [
        { duration: 1, tie: { start: false, stop: true } }
        { duration: 4, tie: { start: false, stop: false } }
      ]
      [
        { duration: 3, tie: { start: false, stop: false } }
      ]
    ]
