detectPitch = require "detect-pitch"
wavToArray = require "ndarray-wav"
noteDictionary = require "./utils/noteDictionary"

SAMPLE_RATE = 44100

fileName = "../input/#{process.argv[2]}"
wavToArray.open fileName, (err, chunkMap) =>
	return console.error "File not found!" if err?

	signal = chunkMap.data.data
	freq = SAMPLE_RATE / detectPitch signal, threshold: 0.99

	console.log noteDictionary.whatIs freq