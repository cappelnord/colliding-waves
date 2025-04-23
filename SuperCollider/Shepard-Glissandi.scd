// Rising Shepard-Risset Glissandi
// Maybe a bit too naive implementation or I did actually something wrong ...

(
SynthDef(\tone, {|startFreq=100, endFreq=12800, duration=30, fade=5|
	var freq = XLine.ar(startFreq, endFreq, duration);
	var sig = SinOsc.ar(freq) * 0.05;
	var env = EnvGen.ar(Env([0, 1, 1, 0], [fade, duration-fade-fade, fade], \sine), doneAction: 2);
	Out.ar(0, sig.dup * env);
}).add;
)

(
v = {|root| {
	var duration = 60;
	var octaves = 8;
	var startFreq = root.midicps;
	var endFreq = startFreq * (2**octaves);
	inf.do {
		(instrument: \tone, duration: duration, startFreq: startFreq, endFreq: endFreq, fade: 20).play;
		(duration / (octaves)).wait;
	};
}.fork};
)

(
v.value(20.midicps);
)
