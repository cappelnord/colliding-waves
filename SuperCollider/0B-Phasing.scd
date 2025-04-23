// Steve Reich – Come Out cover ...

// take any audio file and put it here.
b = Buffer.read(s, "/Users/patri/Dropbox/Audiosamples/amen.wav");

// Beatrice had this idea to play the audio file always with a slight delay.
// Nice!

(
x = {
	32.do {
		b.play;
		(b.duration).wait;
	};
}.fork;

y = {
	32.do {
		b.play;
		(b.duration + (b.duration * (1/32))).wait;
	};
}.fork;
)


// Another option is to play the audio files in slightly different playback
// rates (think of: The record is spinning slightly faster/slower).


(
~phasing = {
	var rate1 = 1;
	var sig1 = PlayBuf.ar(b.numChannels, b, BufRateScale.kr(b) * rate1, loop:1);
	var rate2 = 1.01;
	var sig2 = PlayBuf.ar(b.numChannels, b, BufRateScale.kr(b) * rate2, loop:1);
	sig1.dup + sig2.dup;
};
~phasing.play;
)

// Here an example with 3 playbacks of the same sample

(
~phasing = {
	var rate1 = 1;
	var sig1 = PlayBuf.ar(b.numChannels, b, BufRateScale.kr(b) * rate1, loop:1);
	var rate2 = 1.01;
	var sig2 = PlayBuf.ar(b.numChannels, b, BufRateScale.kr(b) * rate2, loop:1);
	var rate3 = 1.02;
	var sig3 = PlayBuf.ar(b.numChannels, b, BufRateScale.kr(b) * rate3, loop:1);
	sig1.dup + sig2.dup + sig3.dup;
};
~phasing.play;
)