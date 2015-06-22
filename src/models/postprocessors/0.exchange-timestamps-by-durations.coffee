###
Deletes the *timestamp*s and adds the *duration*s in ms.*
 Input: [{timestamp, frequency}, ...]
 Output: [{frequency, duration}, ...]
###
module.exports = (samples) =>
  notes = samples.map (sample, i) =>
    nextTimestamp = samples[i+1]?.timestamp || sample.timestamp

    frequency: sample.frequency
    duration: (nextTimestamp - sample.timestamp) * 1000
