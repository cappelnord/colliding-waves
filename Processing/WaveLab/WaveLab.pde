import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

AlignedAudioBlockProvider aabp;
Minim minim;

int blockSize = 1024;

void setup() {
  size(1280, 720, P3D);
  frameRate(60);
  
  minim = new Minim(this);
  
  aabp = new AlignedAudioBlockProvider(minim.getLineIn(Minim.STEREO, blockSize, 48000), blockSize);
  
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
