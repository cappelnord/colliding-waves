class AlignedAudioBlockProvider implements AudioListener {
  
  private boolean fromFile;
  MultiChannelBuffer buffer;
  private int filePointer = 0;
  
  public int blockSize;

  private float[] internalLeft;
  private float[] internalRight;
  
  private float[] left;
  private float[] right;
  
  private boolean samplesAreAligned = false;
  private int silenceCounter = 0;
  private int writePointer = 0;
  
  
  private void initializeBuffers(int blockSize) {
    this.blockSize = blockSize;
    internalLeft = new float[blockSize];
    internalRight = new float[blockSize];
    
    left = new float[blockSize];
    right = new float[blockSize];
  }
  
  AlignedAudioBlockProvider(Minim minim, String filename, int blockSize) {
    initializeBuffers(blockSize);
    fromFile = true;
    
    buffer = new MultiChannelBuffer(0, 2);
    minim.loadFileIntoBuffer(filename, buffer);
  }
  
  // we get our feed from LineIn
  AlignedAudioBlockProvider(Recordable recordable, int blockSize) {
    initializeBuffers(blockSize);
    fromFile = false;
    
    recordable.addListener(this);
  }
  
  public float[] getLeft() {
    return left;
  }
  
  public float[] getRight() {
     return right; 
  }
  
  private void copyBuffers() {
    for(int i = 0; i < blockSize; i++) {
      left[i] = internalLeft[i];
      right[i] = internalRight[i];
    }
  }
  
  public void feed(float[] sampL, float[] sampR) {

    for(int i = 0; i < sampL.length; i++) {
      float l = sampL[i];
      float r = sampR[i];
      
      // jump over this sample if we are waiting for alignment
      if(!samplesAreAligned && l == 0.0) continue;
      
      // we have our first sample; let's start writing!
      if(!samplesAreAligned && l != 0.0) {
        println("Samples are aligned!");
        samplesAreAligned = true;
        writePointer = 0;
      }
      
      if(l == 0.0) {
        silenceCounter++;
      } else {
        silenceCounter = 0;
      }
      
      internalLeft[writePointer] = l;
      internalRight[writePointer] = r;
      
      writePointer++;
      
      if(writePointer == blockSize) {
        copyBuffers();
        if(silenceCounter >= blockSize) {
          samplesAreAligned = false;
          println("Waiting for alignment ...");
        }
        writePointer = 0;
      }
    }
  }
  
  public synchronized void samples(float[] sampL, float[] sampR) {
    feed(sampL, sampR);
  }
  
  public synchronized void samples(float[] samp) {
     samples(samp, samp); 
  }
  
  public void tick() {
    if(!fromFile) return;
    
    // TODO advance
  }
  
  public boolean hasFinished() {
    if(!fromFile) return false;
    
    return filePointer >= buffer.getBufferSize();
  }
}
