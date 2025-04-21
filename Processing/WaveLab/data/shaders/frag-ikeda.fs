#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

varying vec4 vertColor;
varying vec2 vertTexCoord;

uniform sampler2D texture;
uniform sampler2D audioTexture;

uniform float width;
uniform float height;
uniform float time;
uniform float level;

float PI = 3.14159265359;

void main(void) {
  vec2 st = vertTexCoord;

  float pixelate_x = floor(st.x * 8.0) / 8.0;
  float b = texture2D(audioTexture, vec2(st.y + pixelate_x, 0.0)).r;
  b = abs(b - 0.5) * 2.0 * 8.0;

  gl_FragColor = vec4(b, b, b, 1.0);
}












