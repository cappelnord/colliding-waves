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
  vec2 st = vertTexCoord;
  vec2 stn = (st * 2.0 - 1.0) * vec2(width/height, 1.0);

  float d1 = distance(stn, vec2(0.0, -0.1));
  float d2 = distance(stn, vec2(0.5, 0.0));
  float d3 = distance(stn, vec2(-0.1, 0.0));

  float c = sin(d1 * 100.0 + time) + sin(d2 * 2.3 + time * 1.4) + sin(d3 * 8.4 + time * 0.5);

  gl_FragColor = vec4(c, c, c, 1.0);
}
