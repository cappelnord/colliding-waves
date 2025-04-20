import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

AlignedAudioBlockProvider aabp;
Minim minim;

int blockSize = 1024;

boolean readFromFile = true;
String fileName = "amen.wav";

boolean renderVideo = false;

void setupAudio() {
  minim = new Minim(this);


  if(!readFromFile) {
    aabp = new AlignedAudioBlockProvider(minim.getLineIn(Minim.STEREO, blockSize, 48000), blockSize);
  } else {
    if(!renderVideo) {
        AudioPlayer audioPlayer = minim.loadFile(fileName);
        audioPlayer.loop();
        aabp = new AlignedAudioBlockProvider(audioPlayer, blockSize);
    }
  }  
}

void setup() {
  size(1280, 720, P3D);
  frameRate(60);
  
  setupAudio();

}

void draw() {
  background(0);
  fill(255);
  noStroke();
  float[] left = aabp.getLeft();
  float[] right = aabp.getRight();
  
  for(int i = 0; i < aabp.blockSize; i++) {
    float x = map(i, 0, blockSize, 0, width);
    float y = map(left[i], 1, -1, 0, height);
    ellipse(x, y, 5, 5);
  }
}
