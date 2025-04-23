// r is 48000/512, so that our wavelength aligns with the scope

// Let's not forget our scope
s.scope

// smooth fade-over of changes
~beats.fadeTime = 5;


/* Simple Sine Wave Interference (Beats) */

(
// Oscillators are in phase
~beats = {
	var sig = SinOsc.ar(r) + SinOsc.ar(r + 0) * 0.25;
	sig.dup; // Stereo
};
~beats.play;
)


(
// Frequencies are 1 Hz apart - 1 beat per second
~beats = {
	var sig = SinOsc.ar(r) + SinOsc.ar(r + 1) * 0.25;
	sig.dup; // Duplicate to Stereo
};
~beats.play;
)

// At what point do we still hear a beats and when
// do the 2 frequencies form 2 tones (or a spectrum)?


(
// We can keep the signal aligned by centering the difference
// around our root frequency.

~beats = {
	var sig = SinOsc.ar(r - 0.5) + SinOsc.ar(r + 0.5) * 0.25;
	sig.dup; // Duplicate to Stereo
};
~beats.play;
)


(
// We can also work with harmonics; multiples of our root frequency
// and combine things as we want.

~beats = {
	var w1 = SinOsc.ar(r * 2 - 0.4);
	var w2 = SinOsc.ar(r * 3 + 0.8);
	var w3 = SinOsc.ar(r * 6 - 0.5);
	var sig = w1 + w2 + w3 * 0.25;
	sig.dup; // Duplicate to Stereo
};
~beats.play;
)


(
// What if the amount of detune is a sine oscillator as well?

~beats = {
	var w1 = SinOsc.ar(r * 3 + SinOsc.ar(0.42).range(-0.4, 0.4));
	var w2 = SinOsc.ar(r * 2.5 + SinOsc.ar(0.51).range(-0.5, 0.5));
	var w3 = SinOsc.ar(r * 1 + SinOsc.ar(0.33).range(-0.6, 0.6));
	var sig = w1 + w2 + w3 * 0.25;
	sig.dup; // Duplicate to Stereo
};
~beats.play;
)

// ...


