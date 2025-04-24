/*
This is a very different approach to SuperCollider than we looked
at the other days. Here the instrument and the pattern/score are seperated. It's better suited to do percusive sounds (or any music that is better represented as separate sound events)
*/

// We have a SynthDef with different arguments.
(
SynthDef(\pling, {|out=0, freq=440, pan=0, amp=0.1|
	var sig = Saw.ar(freq) + Saw.ar(freq + 1);
	var env = EnvGen.ar(Env.perc(0.001, 1), doneAction: 2);
	var filterEnv = EnvGen.ar(Env.perc(0.0001, 0.2)) * 8000 + 200;
	sig = RLPF.ar(sig, filterEnv) * env;
	sig = Pan2.ar(sig, pan);
	Out.ar(out, sig * amp);
}).add;
)

/*
We can play the SynthDef using a pattern.
Patterns are their own world in SuperCollider - if
you want to get started best search in the SuperCollider
documentation for "Pattern Guide".
*/

(
Pdef(\sequence, Pbind(
	\instrument, \pling,
	\dur, 1/4,
	\octave, Pseq([3, 4, 5], inf),
	\scale, Scale.chromatic,
	\degree, Prand([0, 2, 4, 7, 11], inf),
	\amp, 0.4
)).play;
);

/*
This is an example for a simple drum sampler; also played
by a very simple pattern.
*/

b = Buffer.read(s, "/Users/patri/Dropbox/Audiosamples/TR808WAV/BD/BD0050.WAV");

(
SynthDef(\kick, {|out=0, freq=440, pan=0, amp=0.1, buffer=0|
	var sig = PlayBuf.ar(1, buffer, BufRateScale.kr(buffer), doneAction: 2);

	sig = Pan2.ar(sig, pan);
	Out.ar(out, sig * amp);
}).add;
)

(
Pdef(\kick, Pbind(
	\instrument, \kick,
	\buffer, b,
	\dur, 1/2,
	\amp, 1
)).play;
)