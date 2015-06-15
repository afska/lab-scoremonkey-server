require("chai").Should()
Promise = require("bluebird")
MelodyDetector = require("./melodyDetector")

describe "MelodyDetector", (done) ->
  # it "can map frequencies to notes and filter repeated notes", ->
  #   detector = new MelodyDetector filePath: ""
  #   detector.recognizer = execute: =>
  #     new Promise (resolve) -> resolve [
  #         { timestamp: 0, frequency: 0 }
  #         { timestamp: 0.1, frequency: 430 }
  #         { timestamp: 0.12, frequency: 430 }
  #         { timestamp: 0.25, frequency: 522.664551 }
  #       ]

  #   detector.getMelody().then (melody) =>
  #     melody.notes.should.eql [
  #       { frequency: 0, name: "r", timestamp: 0, duration: 100 }
  #       { frequency: 430, name: "a4", timestamp: 0.1, duration: 150 }
  #       { frequency: 522.664551, name: "c5", timestamp: 0.25, duration: 0 }
  #     ]
