// Multichannel Expansion

// We can create rich sounds that consist of multiple generators easily
// by creating a series of frequencies (or other parameters).

// There are many built-in functions to create lists of numbers.

// A series of 16 numbers starting with 1 and adding 0.5 each step.
Array.series(16, 1, 0.5);

// A geometric series of 16 numbers, starting with 1 and each
// step is the prior number multiplied by 1.05.
Array.geom(16, 1, 1.05)

// A series of random numbers between 100 and 1000
Array.rand(16, 100.0, 1000.0);

// A series of random numbers between 100 and 1000 with exponential distribution
Array.exprand(16, 100.0, 1000.0);

// There are many more ways to create these series of numbers.
// You could also specify your own function here (ask Patrick!)


~cluster.fadeTime = 2;

// We can now easily create a stack of sounds and then mix them down
// spread in the stereo field with Splay


// cluster of random sine oscillators
(
~cluster = {
	// replace with any other series from above
	var freqs = Array.exprand(16, 100.0, 1000.0);
	// replace SinOsc with any other oscillator
	var signals = SinOsc.ar(freqs);
	Splay.ar(signals) * 0.25;
};
~cluster.play;
)


// Many Saw oscillators interfering heavily with each other
// creating a moire-like pattern in the spectrum.
(
~cluster = {
	var freqs = Array.series(32, 50, 0.01);
	var signals = Saw.ar(freqs);
	Splay.ar(signals) * 0.25;
};
~cluster.play;
)


// Many many Impulse oscillators having a similar effect
(
~cluster = {
	var freqs = Array.series(128, r, 0.001);
	var signals = Impulse.ar(freqs);
	Splay.ar(signals) * 0.25;
};
~cluster.play;
)


s.scope

// we can also just specify a number of frequencies manually :)
(
~cluster = {
	var freqs = [50, 55, 200, 240];
	var signals = SinOsc.ar(freqs);
	Splay.ar(signals) * 0.25;
};
~cluster.play;
)