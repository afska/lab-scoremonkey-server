require("chai").Should()

describe "A component", ->
  user = null
  beforeEach ->
    user = name: "Carlos", age: 23

  it "Carlos is 23 years old", ->
    user.age.should.eql 23


describe "Beverages Manager", ->
  manager = 'English Bar'
  beverages = { tea: [ 'chai', 'matcha', 'oolong' ] }

  it "The manager must be a string", ->
    manager.should.be.a('string')
  it "The manager is English Bar", ->
    manager.should.equal('English Bar')
  it "The manager should be named with 11 letters long", ->
    manager.should.have.length(11)
  it "The tea must be in the beverages, named with 3 letters long", ->
    beverages.should.have.property('tea').with.length(3)
