###
Deletes the *timestamps* and adds the *durations* in ms.
Removes the last useless sample.
 Input: [{timestamp, frequency}, ...]
 Output: [{frequency, duration}, ...]
###
module.exports = (settings, samples) =>
  samples = samples.map (sample, i) =>
    nextTimestamp = samples[i+1]?.timestamp || sample.timestamp

    frequency: sample.frequency
    duration: (nextTimestamp - sample.timestamp) * 1000

  samples.slice 0, samples.length - 1
