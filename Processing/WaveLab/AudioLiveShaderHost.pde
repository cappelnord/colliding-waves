static class AudioLiveShaderHost {
  
  private PApplet main;
  public AlignedAudioBlockProvider aabp;

  public static PGraphics tex;
  
  final static int audioTextureBandwidth = 1;

  private static int lastProcessedFrame = -1;


  AudioLiveShaderHost(PApplet main, AlignedAudioBlockProvider aabp) {
    this.main = main;
    this.aabp = aabp;
    tex = main.createGraphics(aabp.blockSize, audioTextureBandwidth, P3D);
  }

  private int simpleValueFromAudioSample(float sample) {
    int ret = (int) (sample * 127.0 + 127);
    return ret;
  }

  private void drawSimpleAudioTexture() {
    float[] left = aabp.getLeft();
    float[] right = aabp.getRight();
    for (int i = 1; i <= aabp.blockSize; i++) {
      // https://forum.processing.org/two/discussion/8086/what-is-a-color-in-processing
      int r = simpleValueFromAudioSample(left[i-1]);
      int g = simpleValueFromAudioSample(right[i-1]);
      int b = 0;
      int c = (255 << 24) | (r << 16) | (g << 8) | b;
      tex.stroke(c);
      tex.line(i, 0, i, audioTextureBandwidth);
    }
  }
  
  public void update() {
    if (lastProcessedFrame == main.frameCount) {
      return;
    }

    tex.noSmooth();
    tex.beginDraw();
    tex.background(0);

    drawSimpleAudioTexture();
    tex.endDraw();
  }
  
  // this should never fail, try before!
  
  public static void setUniforms(PShader program) {
    program.set("audioTexture", tex);
  }
}
