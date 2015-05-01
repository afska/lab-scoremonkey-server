_ = require("lodash")

#add lodash methods to Array class
[
	"at", "compact", "contains", "countBy", "difference"
	"find", "findIndex", "findLast", "findLastIndex", "first"
	"flatten", "forEachRight", "groupBy", "indexBy", "initial"
	"intersection", "invoke", "last", "lastIndexOf", "max"
	"min", "pluck", "pull", "range", "reduceRight"
	"reject", "remove", "rest", "sample", "shuffle"
	"size", "sortBy", "sortedIndex", "sum", "union"
  "uniq", "where", "without", "xor", "zip"
	"zipObject", "cloneDeep", "isEmpty"
].forEach (methodName) ->
	Array::[methodName] = ->
		args = Array::slice.call arguments
		_[methodName].apply @, [@].concat args

module.exports = _
