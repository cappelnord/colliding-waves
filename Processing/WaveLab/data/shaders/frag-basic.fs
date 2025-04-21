#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

varying vec4 vertColor;
varying vec2 vertTexCoord;

uniform sampler2D feedback;
uniform sampler2D audioTexture;

uniform float width;
uniform float height;
uniform float time;
uniform float level;

float PI = 3.14159265359;

void main(void) {
  // vec2 st = vertTexCoord;

  gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0);
}
