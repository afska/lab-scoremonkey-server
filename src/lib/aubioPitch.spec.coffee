require("chai").Should()
Promise = require("bluebird")
AubioPitch = require("./aubioPitch")

describe "AubioPitch", ->
  aubioPitchMock = (response) ->
    mock = new AubioPitch()
    mock._call = =>
      new Promise (resolve) -> resolve response
    mock

  it "can parse the space-newline separated values into objects", ->
    aubioPitchMock(
      "0.000000 0.000000\n0.100000 430.000000\n0.250000 522.664551"
    ).execute().then (output) =>
      output.should.be.eql [
        { timestamp: 0, frequency: 0 }
        { timestamp: 0.1, frequency: 430 }
        { timestamp: 0.25, frequency: 522.664551 }
      ]

  it "can detect errors in an early stage", ->
    aubioPitchMock("The lib has exploded!")
      .execute()
      .catch ({message}) =>
        message.should.be.eql "Unexpected output: The lib has exploded!"
