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

### Tap Tempo
The TapTempo class can help you determine a tempo by averaging the time between a number of taps on a button.

```Swift
let tapTempo = TapTempo(samples: 3)
tapTempo.tap()
// Wait
tapTempo.tap()
// Wait
let tempo = tapTempo.tap()
```
