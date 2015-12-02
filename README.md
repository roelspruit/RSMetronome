[![Build Status](https://travis-ci.org/roelspruit/RSMetronome.svg)](https://travis-ci.org/roelspruit/RSMetronome)

# RSMetronome
RSMetronome is an library written in Swift that can be used to implement a basic metronome.

## Usage

### Start the metronome
```Swift
let metronome = Metronome()
metronome.start()
```

### Stop the metronome
```Swift
metronome.stop()
```

### Change the metronome's tempo
```Swift
metronome.settings.tempo = 60
```
