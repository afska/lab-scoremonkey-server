require("chai").Should()
Promise = require("bluebird")
MelodyDetector = require("./melodyDetector")
include("utils/objectUtils")

describe "MelodyDetector", (done) ->
  it "can map frequencies to notes and filter repeated notes", ->
    detector = new MelodyDetector()
    detector.recognizer = execute: =>
      new Promise (resolve) -> resolve [
          { timestamp: 0, frequency: 0 }
          { timestamp: 0.1, frequency: 430 }
          { timestamp: 0.12, frequency: 430 }
          { timestamp: 0.25, frequency: 522.664551 }
        ]

    detector.getMelody().then (melody) =>
      melody.should.eql [
          { detected: "r", timestamp: 0, frequency: 0 }
          { detected: "a4", timestamp: 0.1, frequency: 430 }
          { detected: "c5", timestamp: 0.25, frequency: 522.664551 }
      ]
