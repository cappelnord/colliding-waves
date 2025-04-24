/*
Modular Synthesis techniques can be easily applied in SuperCollider, as
most UGens will accept not only a constant value as parameter but also
any other UGens. Here is a quick example for a sound with both a
Frequency and a Filter LFO.

*/


~sound.fadeTime = 5;

(
~sound = {
	// the .range operation scales the output of an oscillator to the given range.
	// Most oscillators will (by default) output a range of -1 to 1.
	var freqLfo = SinOsc.ar(2).range(20, 300);
	var filterLfo = SinOsc.ar(2.1).range(50, 4000);
	var sig = Saw.ar(freqLfo);
	sig = RLPF.ar(sig, filterLfo) * 0.1;
	sig.dup;
};
~sound.play;
)


/*
(with ProxySpace) it is also (easily) possible to have the LFOs
seperate from the sound process; sometimes it behaves a bit odd though ...
*/

(
~freqLfo = {SinOsc.ar(2).range(20, 300)};
~freqLfo.fadeTime = 2;
// note, that we will not play the LFO! We will use it later.
)

(
~filterLfo = {SinOsc.ar(2.1).range(50, 4000)};
~filterLfo.fadeTime = 2;
)

(
~sound = {
	var sig = Saw.ar(~freqLfo);
	sig = RLPF.ar(sig, ~filterLfo) * 0.1;
	sig.dup;
};
~sound.play;
)


// you can now redefine the LFOs without redefining the running sound.


~filterLfo = {LFSaw.ar(4.1).range(50, 4000)};

~freqLfo = {LFPulse.ar(4).range(50, 400)};



