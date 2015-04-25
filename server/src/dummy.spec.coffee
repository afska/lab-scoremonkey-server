require("chai").Should()

describe "A component", ->
  user = null
  beforeEach ->
    user = name: "Carlos", age: 23

  it "Carlos is 23 years old", ->
    user.age.should.eql 23
