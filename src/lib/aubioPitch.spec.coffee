require("chai").Should()
Promise = require("bluebird")
AubioPitch = require("./aubioPitch")

describe "AubioPitch", ->
  it "can parse the space-newline separated values into objects", ->
    aubioPitch = new AubioPitch()
    aubioPitch._call = =>
      output = "0.000000 0.000000\n0.100000 430.000000\n0.250000 522.664551"
      new Promise (resolve) -> resolve output

    aubioPitch.execute()
      .then (output) =>
        output.should.be.eql [
          { timestamp: 0, frequency: 0 }
          { timestamp: 0.1, frequency: 430 }
          { timestamp: 0.25, frequency: 522.664551 }
        ]
