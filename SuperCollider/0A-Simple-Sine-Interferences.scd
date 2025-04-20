// r is 48000/512, so that our wavelength aligns with the scope

// Let's not forget our scope
s.scope

/* Simple Sine Wave Interference (Beating) */

(
// Oscillators are in phase
~beating = {
	var sig = SinOsc.ar(r) + SinOsc.ar(r + 0) * 0.1;
	sig.dup; // Stereo
};
)

~beating.play;


(
// Frequencies are 1 Hz apart - 1 beating per second
~beating = {
	var sig = SinOsc.ar(r) + SinOsc.ar(r + 1) * 0.1;
	sig.dup; // Stereo
};
)

// At what point do we still hear a beating and when
// do the 2 frequencies form 2 tones (or a spectrum)?


(
// We can keep the signal aligned by centering the difference
// around our root frequency.

~beating = {
	var sig = SinOsc.ar(r - 0.5) + SinOsc.ar(r + 0.5) * 0.1;
	sig.dup; // Stereo
};
)

// TODO: more fun variations