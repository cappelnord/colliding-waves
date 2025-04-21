/*
IMPORTANT:

Make sure that SafetyNet is installed for this workshop; otherwise you can get uncomfortably loud sounds, in particular on macOS due to a bug/feature of it.

https://github.com/adcxyz/SafetyNet

For a beginner SafetyNet is always advised. If you get more advanced you might want to check out what it is actually doing; then you can decide if you want it or not.

*/

/*
Practice how to execute code:

Execute a block of code (or a single line) with:
Cmd Return (macOS)
Ctrl Return (Windows, Linux)

Execute only a single line of code with:
Shift Return (macOS, Windows, Linux)

*/

// try it on a single line of code
1 + 1;
2 + 2;
3 + 3;

// Blocks of code are surrounded by round brackets

(
var a = 5;
var b = 10;
a + b;
)

/*
Practice how to stop a sound; if things get loud by accident it is important to remember to key combination:

Cmd . (macOS)
Ctrl . (Windows, Linux)
*/

// First we need to make sure that the audio server is running ...
s.boot;

// Let's test it. Kill this sound with Cmd . / Ctrl .
{SinOsc.ar(440).dup * 0.1}.play;

// Practice this. Memorize it. Sounds can get loud - you will need it!