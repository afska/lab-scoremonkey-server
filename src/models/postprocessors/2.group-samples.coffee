BeatConverter = include("models/converters/beatConverter")
_ = require("protolodash")

MINIMUM_NOTE_LENGTH = 1/16

###
Groups the samples by a minimum note length.
 Input: [{frequency, duration}, ...]
 Output: [[{frequency, duration}, ...], ...]
###
module.exports = (settings, samples) =>
  minimumMs = new BeatConverter(settings.tempo).toMs MINIMUM_NOTE_LENGTH

  groupByMs = (groups, sample) =>
    lastGroup = groups.last()
    lastGroup.push sample
    groupLength = _.sum lastGroup, "duration"

    if groupLength > minimumMs
      leftover = groupLength - minimumMs
      sample.duration -= leftover

      groups.push [
        frequency: sample.frequency, duration: leftover
      ]

    groups

  samples.reduce groupByMs, [[]]
