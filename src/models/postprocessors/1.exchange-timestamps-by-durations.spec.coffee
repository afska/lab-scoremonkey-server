require("chai").Should()
execute = require("./1.exchange-timestamps-by-durations")

describe "1.exchange-timestamps-by-durations", ->
  it "can calculate the duration in ms, based on the timestamps", ->
    execute({}, [
      { timestamp: 0, frequency: 0 }
      { timestamp: 0.1, frequency: 430 }
      { timestamp: 0.25, frequency: 522.664551 }
      { timestamp: 0.50, frequency: 0 }
    ]).samples.should.eql [
      { frequency: 0, duration: 100 }
      { frequency: 430, duration: 150 }
      { frequency: 522.664551, duration: 250 }
    ]
