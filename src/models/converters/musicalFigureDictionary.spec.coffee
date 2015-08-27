should = require("chai").Should()
musicalFigureDictionary = require("./musicalFigureDictionary")

describe "musicalFigureDictionary", ->
  describe "findByDuration", ->
    it "can retrieve a note type by duration", ->
      musicalFigureDictionary.findByDuration(1/4 + 1/8)
        .should.eql name: "quarter", duration: 1/4 + 1/8, dot: true

    it "returns null when the figure wasn't found", ->
      should.not.exist musicalFigureDictionary.findByDuration(999)

  describe "findClosestDuration", ->
    it "can retrieve the closest duration", ->
      musicalFigureDictionary.findClosestDuration(1/4 + 1/16)
        .should.eql 1/4

    it "returns the same duration if it's exact", ->
      musicalFigureDictionary.findClosestDuration(2/4)
        .should.eql 2/4

    it "works fine with dots", ->
      musicalFigureDictionary.findClosestDuration(1/4 + 3/16)
        .should.eql 1/4 + 1/8

    it "the closest always is lower than the value", ->
      musicalFigureDictionary.findClosestDuration(15/16)
        .should.eql 1/2 + 1/4
