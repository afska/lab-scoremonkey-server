require("chai").Should()

describe "A component", ->
  user = null
  beforeEach ->
    user = name: "Carlos", age: 23

  it "Carlos is 23 years old", ->
    user.age.should.eql 23

#Supongo que cada "describe" es un test a parte, verdad?
describe "Another component? Or should we simply call them 'tests'?", ->
  #actually call the function
  foo = 'bar'
  beverages = { tea: [ 'chai', 'matcha', 'oolong' ] }

  foo.should.be.a('string')
  foo.should.equal('bar')
  foo.should.have.length(3)
  it "The tea must be in the beverages, named with 3 letters long", ->
    beverages.should.have.property('tea').with.length(3)
