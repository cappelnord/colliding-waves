import java.io.*;
import java.util.Date.*;
import java.text.SimpleDateFormat;
import ddf.minim.analysis.*;
import ddf.minim.*;

// import codeanticode.syphon.*;

public static String getStackTrace(final Throwable throwable) {
  final StringWriter sw = new StringWriter();
  final PrintWriter pw = new PrintWriter(sw, true);
  throwable.printStackTrace(pw);
  return sw.getBuffer().toString();
}

class AudioLiveShader {

  // Syphon Support
  // SyphonServer syphon;
  
  private AudioLiveShaderHost host;

  final static String vertexShaderFilename = "vert.vs";

  private int texturePingPong = 0;
  private PGraphics textures[];
  String filename;
  PGraphics texture;

  private long shaderLastModified = 0;
  PShader program = null;
  PShader oldProgram = null;

  String error = null;

  HashMap<String, Uniform> uniforms;

  int width;
  int height;
  
  private boolean videoMode = false;
  private String videoName;
  private int videoFPS;
  private int videoFrameCount;

  public AudioLiveShader(AudioLiveShaderHost host, int width, int height, String filename) {
    
    this.host = host;
    
    uniforms = new HashMap<String, Uniform>();
    
    textures = new PGraphics[2];

    for (int i = 0; i < 2; i++) { 
      textures[i] = createGraphics(width, height, P3D);
      textures[i].beginDraw();
      textures[i].textureWrap(REPEAT); 
      textures[i].background(0);
      textures[i].endDraw();
    }

    this.width = width;
    this.height = height;
    
    setShaderFile(filename);
  }
  
  public void enableVideoOutput(String name, int fps) {
    videoMode = true;
    videoName = name;
    videoFPS = fps;
    videoFrameCount = 0;
  }
  
  public void setShaderFile(String filename) {
    this.filename = filename;
    updateShader();
  }

  /*
  public void enableSyphon(String name) {
    syphon = new SyphonServer(AudioLiveShaderHost.main, name);
  }
  */

  private void updateShader() {
    File file = new File(sketchPath(filename));
    if (file.lastModified() > shaderLastModified) {
      shaderLastModified = file.lastModified();
      error = null;
      program = loadShader(filename, vertexShaderFilename);
    }
  }

  private void setUniforms(PGraphics texture) {
    try {
      if (program != null) {
        texture.shader(program);
        AudioLiveShaderHost.setUniforms(program);
        program.set("feedback", textures[(texturePingPong+1) % 2]);
        program.set("width", (float) this.width);
        program.set("height", (float) this.height);
        
        if(!videoMode) {
          program.set("time", (float) millis() / 1000.0);
          program.set("frameCount", (float) frameCount);
        } else {
          program.set("time", (float) videoFrameCount / (float) videoFPS);
          program.set("frameCount", (float) videoFrameCount);
        }
        
        for(String key : uniforms.keySet()) {
          uniforms.get(key).apply(program);
        }
      }
    } 
    catch(RuntimeException e) {
      error = e.getMessage();
      program = oldProgram;
    }
  }

  public void render() {
    host.update();

    PGraphics tryTexture = textures[texturePingPong % 2];

    // try
    updateShader();
    setUniforms(tryTexture);

    // we should know by now!
    if (!hasError()) {
      texture = tryTexture;

      texture.beginDraw();
      texture.image(textures[(texturePingPong + 1) % 2], 0, 0, this.width, this.height);
      texture.endDraw();
      texturePingPong++;
    }

    resetShader();

    /*
    if (syphon != null) {
      syphon.sendImage(texture);
    }
    */
    
    if (videoMode) {
      saveVideoFrame();
    }
  }
  
  private void saveVideoFrame() {
    // check if output directory is there and if not create it
    File f = new File("videos/" + videoName);
    if(!f.isDirectory()) {
      f.mkdir();
    }
    snapshot("videos/" + videoName + "/" + videoName + "-" + nf(videoFrameCount, 6) + ".png");
    videoFrameCount++;
  }
  
  public void snapshot(String filename) {
    texture.save(filename);
    println("Saved image to: " + filename);
  }
  
  public void snapshot() {
    String filename = (new SimpleDateFormat("yyyy.MM.dd.HH.mm.ss").format(new java.util.Date())) + ".png";
    snapshot("snapshots/" + filename);
  }
  public boolean hasError() {
    return error != null;
  }

  public void displayError(int x, int y) {
    if (hasError()) {
      resetShader();
      text(error, x, y);
    }
  }
  
  void removeUniform(String name) {
    uniforms.remove(name);
  }
  
  void set(String name, float a) {
    set(name, new Uniform(name, a));
  }
  
  void set(String name, float a, float b) {
    set(name, new Uniform(name, a, b));
  }
  
  void set(String name, float a, float b, float c) {
    set(name, new Uniform(name, a, b, c));
  }
  
  void set(String name, float a, float b, float c, float d) {
    set(name, new Uniform(name, a, b, c, d));
  }
  
  void set(String name, PImage texture) {
     set(name, new Uniform(name, texture));
  }
  
  void set(String name, Uniform uniform) {
    uniforms.put(name, uniform);
  }
}

// 0: float, 1: vec2, 2: vec3, 3: vec4, 4: sampler2D

public class Uniform {

  int type;
  float data[];
  String name;
  
  PImage texture;

  Uniform(String name, float a) {
    this.name = name;
    data = new float[1];
    data[0] = a;
    type = 0;
  }

  Uniform(String name, float a, float b) {
    this.name = name;
    data = new float[2];
    data[0] = a;
    data[1] = b;
    type = 1;
  }
  
  Uniform(String name, float a, float b, float c) {
    this.name = name;
    data = new float[3];
    data[0] = a;
    data[1] = b;
    data[2] = c;
    type = 2;
  }
  
  Uniform(String name, float a, float b, float c, float d) {
    this.name = name;
    data = new float[3];
    data[0] = a;
    data[1] = b;
    data[2] = c;
    data[3] = d;
    type = 3;
  }
  
  Uniform(String name, PImage graphics) {
    this.name = name;
    type = 4;
    this.texture = graphics;
  }
  
  void apply(PShader program) {
    switch(type) {
      case 0:
        program.set(name, data[0]);
        break;
      case 1:
        program.set(name, data[0], data[1]);
        break;
      case 2:
        program.set(name, data[0], data[1], data[2]);
        break;
      case 3:
        program.set(name, data[0], data[1], data[2], data[3]);
        break;
      case 4:
        program.set(name, texture);
        break;
    }
  }
}
