
varying lowp vec4 DestinationColor;

varying highp float diffuseLightIntensity;

varying lowp vec4 destinationAmbientLightColor;
varying lowp vec4 destinationDiffuseLightColor;

void main(void) {
    lowp vec4 diffuseColor = 0.5 * (diffuseLightIntensity * destinationDiffuseLightColor);
    lowp vec4 ambientColor = 0.5 * destinationAmbientLightColor;
    gl_FragColor = vec4(((ambientColor + diffuseColor) * DestinationColor).rgb, 1.0);
    //gl_FragColor = vec4((diffuseColor * DestinationColor).rgb, 1.0);
}