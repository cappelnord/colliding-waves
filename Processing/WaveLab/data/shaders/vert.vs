uniform mat4 transform;

attribute vec4 vertex;
attribute vec4 color;
attribute vec2 texCoord;

varying vec4 vertColor;
varying vec2 vertTexCoord;

void main() {
  gl_Position = transform * vertex;
  vertTexCoord = texCoord;
  vertColor = color;
}
