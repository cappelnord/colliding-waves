// I collect more ideas here .. these are still to be fleshed out.


(
~stereo = {
	Impulse.ar([1, 1.1]) * 0.1
};
~stereo.play;
)

~stereo.clear


s.scope


// quick exampe: Keystroke to sound.
(
w = Window("OK");
w.front;
w = {|x|
	x.postln;
};
)

// Sheppard Tones