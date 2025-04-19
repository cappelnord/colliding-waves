/*
IMPORTANT:

- Make sure that SafetyNet is installed for this workshop; otherwise you can get uncomfortably loud sounds.

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

// sometimes you want to execute more than one line of code.
// code can be combined into a

/*
Practice how to stop a sound; if things get loud by accident it is important to remember to key combination:

Cmd . (macOS)
Ctrl . (Windows, Linux)
*/

// Let's test it. Kill this sound with Cmd . / Ctrl .
{SinOsc.ar(440).dup * 0.1}.play

// Practice this. Memorize it. Sounds can get loud - you will need it!