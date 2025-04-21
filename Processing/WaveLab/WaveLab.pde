import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

AlignedAudioBlockProvider aabp;
Minim minim;

AudioLiveShaderHost host;
AudioLiveShader shader;

int blockSize = 1024;
int fps = 60;

// make sure, that the audio rate is the same as in the audio file!
int audioSampleRate = 48000;

boolean readFromFile = true;
String fileName = "amen.wav";

boolean drawShader = true;
String fragmentShaderFile = "data/shaders/frag-interference.fs";

boolean renderVideo = false;
String renderFilePattern = "render/render-######.png";

void setupAudio() {
  minim = new Minim(this);

  if(!readFromFile) {
    aabp = new AlignedAudioBlockProvider(minim.getLineIn(Minim.STEREO, blockSize, audioSampleRate), blockSize);
  } else {
    if(!renderVideo) {
      AudioPlayer audioPlayer = minim.loadFile(fileName);
      audioPlayer.loop();
      aabp = new AlignedAudioBlockProvider(audioPlayer, blockSize);
    } else {
      aabp = new AlignedAudioBlockProvider(minim, fileName, blockSize);
    }
  }  
}

void setupShader() {
  host = new AudioLiveShaderHost(this, aabp);
  shader = new AudioLiveShader(host, width, height, fragmentShaderFile);
}

void setup() {
  size(1280, 720, P3D);
  frameRate(fps);
  
  setupAudio();
  setupShader();

}

void draw() {
  aabp.update();
  
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
  
  if(drawShader) {
    shader.render();
    image(shader.texture, 0, 0);
  }
  
  
  if(renderVideo) {
    if(aabp.hasFinished()) {
      exit();
    }
    saveFrame(renderFilePattern);
  }
  
  if(shader.hasError()) {
    fill(255, 0, 0);
    stroke(255, 0, 0);
    shader.displayError(0, 0);
  }
}
