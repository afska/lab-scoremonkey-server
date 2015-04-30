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

  manager.should.be.a('string')
  manager.should.equal('English Bar')
  manager.should.have.length(3)
  it "The tea must be in the beverages, named with 3 letters long", ->
    beverages.should.have.property('tea').with.length(3)
