require("protolodash");

algo = ->
  ["whole", "half", "quarter", "eighth", "16th"].map (figureName, i) ->
    length = 1 / Math.pow(2, i)
    [
      { name: figureName, duration: length, dot: false }
      { name: figureName, duration: length + length / 2, dot: true }
    ]
    .flatten()

console.log algo()
