/*

This is a quick start up that:

- Boots the audio server with 48000 Hz audio sample rate and a block size of 512.
- "Pushes" the ProxySpace, so that we can use ~variables for sound.


MAKE SURE THAT THE SAFETY NET QUARK IS INSTALLED

*/

(
s.options.sampleRate = 48000;

// a block size that large is generally not suggested for SuperCollider
// but it makes our wave interference experiments a bit easier to observe.

s.options.blockSize = 512;

p = ProxySpace.push(s.boot, clock:TempoClock.default);

s.waitForBoot {
	r = 48000/512;
	"All ready to go!".postln;
	Safety.setLimit(1.0);
};
)


// you want a test sound?
~test = {SinOsc.ar(440).dup * 0.5}

// play it
~test.play

// stop it from playing
~test.free
