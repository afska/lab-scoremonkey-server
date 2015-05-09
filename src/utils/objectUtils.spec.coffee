require("chai").Should()
lodash = require("lodash")
_ = require("./objectUtils")

describe "ObjectUtils", ->
  it "should add some lodash methods to the Array class", ->
    [[2, 3], [4, 5]].flatten()
      .should.be.eql [2, 3, 4, 5]

    [2, 6].sum().should.be.eql 8

  it "should return the lodash instance", ->
    _.should.be.equal lodash
