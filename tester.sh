#!/bin/bash

arecord -f dat -D hw:0,0 tmp.wav
node ./tester.js
timidity tmp.mid
rm tmp.wav tmp.mid
