// https://en.wikipedia.org/wiki/Lissajous_curve

// Open the Scope and set it to X/Y Mode (Click on Tracks, then X/Y)
s.scope

~lissajous.fadeTime = 2;

(
// A static circle

~lissajous = {
	var left = SinOsc.ar(r * 2);
	var right = SinOsc.ar(r * 2, 0.5pi);
	[left, right] * 0.5;
};
~lissajous.play;
)

(
// Once one of the frequencies differs a bit the circle is moving

~lissajous = {
	var left = SinOsc.ar(r * 2);
	var right = SinOsc.ar(r * 2 + 0.2, 0.5pi);
	[left, right] * 0.5;
};
~lissajous.play;
)

(
// Different patterns from different harmonic relationships

~lissajous = {
	var left = SinOsc.ar(r * 3);
	var right = SinOsc.ar(r * 2 + 0.2, 0.5pi);
	[left, right] * 0.5;
};
~lissajous.play;
)

(
~lissajous = {
	var left = SinOsc.ar(r * 3);
	var right = SinOsc.ar(r * 5 + 0.2, 0.5pi);
	[left, right] * 0.5;
};
~lissajous.play;
)


// also try different Oscillators
(
~lissajous = {
	var left = SinOsc.ar(r * 3);
	var right = Saw.ar(r * 2 + 0.2, 0.5pi);

	// you can also use other techniques to change the sound

	// filter out high frequencies from right channel
	right = LPF.ar(right, 1000);

	[left, right] * 0.5;
};
~lissajous.play;
)

(
~lissajous = {
	var left = SinOsc.ar(r * 3);
	var right = Saw.ar(r * 2 + 0.2, 0.5pi);

	// you can also use other techniques to change the sound

	// filter out high frequencies from right channel
	right = LPF.ar(right, 3000);

	[left, right] * 0.5;
};
~lissajous.play;
)