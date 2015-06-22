require("chai").Should()
BeatConverter = require("./beatConverter")

describe "BeatConverter", ->
  it "can convert beats to milliseconds", ->
    new BeatConverter(120)
      .toMs(1/4).should.eql 500

  it "can convert milliseconds to beats", ->
    new BeatConverter(150)
      .toBeats(400).should.eql 1/4

  it "can calculate the duration in ms of a beat", ->
    new BeatConverter(60)
      .beatDuration().should.eql 1000
