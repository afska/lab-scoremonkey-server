require("chai").Should()
BeatConverter = require("./beatConverter")

describe "BeatConverter", ->
  it "can convert beats to milliseconds", ->
    converter = new BeatConverter 120
    converter.toMs(1/4).should.eql 500

  it "can milliseconds convert to beats", ->
    converter = new BeatConverter 150
    converter.toBeats(400).should.eql 1/4
