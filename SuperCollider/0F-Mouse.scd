// MouseX and MouseY are fun UGens! With them you can easily
// control parameters of synths. A little example:

(
~fun = {
	var freq = MouseX.kr(50, 2000);
	var saw1 = Saw.ar(freq);
	var saw2 = Saw.ar(freq * 1.01);
	var sig = saw1 + saw2;
	sig = RLPF.ar(sig, MouseY.kr(20, 8000), 0.5);
	sig.dup * 0.2;
};
~fun.play;
)