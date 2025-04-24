

~sound.fadeTime = 0

// We can use Line and XLine as very simple envelopes to
// shape sound in time. Be aware: As XLine is an exponential
// function it cannot go to/from zero.

(
~sound = {
	var freq = XLine.ar(50, 100, 20);
	var sig = Saw.ar(freq) + Saw.ar(freq + 1);
	var env = XLine.ar(0.001, 1, 1);
	sig = RLPF.ar(sig, XLine.ar(50, 15000, 20)) * env;
	sig.dup * 0.1;
};
~sound.play;
)

/*
To do more complex envelopes we can use Env and EnvGen. Many popular
envelope shapes are already implemented within SuperCollider but you
can also define your own envelopes by specifying breakpoints.
*/

// Command D (macOS ) // Ctrl D (Windows / Linux)

Env // defines an envelope
EnvGen // generates an envelope

(
~sound = {
	var freq = XLine.ar(100, 100, 20);
	var sig = Saw.ar(freq) + Saw.ar(freq + 1);
	var env = EnvGen.ar(Env.perc(0.001, 1));
	// var env = EnvGen.ar(Env.sine(5));
	// var env = EnvGen.ar(Env([0, 1, 0.1, 1, 0], [0.05, 0.1, 5, 5]));
	var filterEnv = EnvGen.ar(Env.perc(0.0001, 0.2)) * 8000 + 200;
	sig = RLPF.ar(sig, filterEnv) * env;
	sig.dup * 0.1;
};
~sound.play;
)

