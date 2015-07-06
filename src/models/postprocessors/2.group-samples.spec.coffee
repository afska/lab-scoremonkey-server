require("chai").Should()
execute = require("./2.group-samples")

describe "2.group-Samples", ->
  it "can group the samples in an array of arrays, by 16th notes", ->
    # in 60 bpm: 16th note = 250ms

    execute(tempo: 60, [
      { frequency: 1, duration: 80 } # 80
      { frequency: 2, duration: 80 } # 160
      { frequency: 3, duration: 80 } # 240
      { frequency: 4, duration: 80 } # 320
      { frequency: 5, duration: 80 } # 400
      { frequency: 6, duration: 80 } # 480
      { frequency: 7, duration: 80 } # 560
    ]).should.eql [
      [
        { frequency: 1, duration: 80 } # 80
        { frequency: 2, duration: 80 } # 160
        { frequency: 3, duration: 80 } # 240
        { frequency: 4, duration: 10 } # 250
      ]
      [
        { frequency: 4, duration: 70 } # 320
        { frequency: 5, duration: 80 } # 400
        { frequency: 6, duration: 80 } # 480
        { frequency: 7, duration: 20 } # 500
      ]
      [
        { frequency: 7, duration: 60 } # 560
      ]
    ]
