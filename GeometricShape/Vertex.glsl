
attribute vec4 Position;
attribute vec4 SourceColor;

varying vec4 DestinationColor;

uniform mat4 Projection;
uniform mat4 Transformation;

attribute vec4 normal;
uniform mat4 normalTransformation;

uniform vec4 ambientLightColor;
varying vec4 destinationAmbientLightColor;

uniform vec3 diffuseLightDirection;
uniform vec4 diffuseLightColor;
varying float diffuseLightIntensity;
varying vec4 destinationDiffuseLightColor;

void main(void) {

    DestinationColor = SourceColor;
    destinationAmbientLightColor = ambientLightColor;
    destinationDiffuseLightColor = diffuseLightColor;
    diffuseLightIntensity = max(0.0, dot((normalTransformation * normal).xyz, diffuseLightDirection));
    
    gl_Position = Projection * Transformation * Position;
    
}