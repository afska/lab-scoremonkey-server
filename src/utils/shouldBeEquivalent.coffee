module.exports = (one, another) =>
  # (removes the methods in the objects for the comparison)

  clean = (o) => JSON.parse JSON.stringify o
  clean(one).should.be.eql clean(another)
