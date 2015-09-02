
attribute vec4 Position;
attribute vec4 SourceColor;

varying vec4 DestinationColor;

uniform mat4 Projection;
uniform mat4 Transformation;

void main(void) {
    DestinationColor = SourceColor;
    gl_Position = Projection * Transformation * Position;
}