# GeometricShape
Create geometric shapes

## Usage
### GeometricShapeCube
```objective-c
#import "GeometricShape.h"

GeometricShapeCube *cube = [[GeometricShapeCube alloc]init];
[cube setFrame:CGRectMake(0, 0, 50, 50)];
[cube setColor:[UIColor blueColor]];

GeometricShapeAmbientLight *ambientLight = [[GeometricShapeAmbientLight alloc]init];
[ambientLight setLightColor:[UIColor whiteColor]];

GeometricShapeDiffuseLight *diffuseLight = [[GeometricShapeDiffuseLight alloc]init];
[diffuseLight setVectorX:1 y:1, z:1];
[diffuseLight setLightColor:[UIColor whiteColor]];

[cube addAmbientLight:ambientLight];
[cube addDiffuseLight:diffuseLight];

[view setup];

[view addSubview:cube];
```

## API
### GeometricShapeCube
```objective-c
-(void)setColor:(UIColor *)color;
```
set cube color
```objective-c
-(void)setRotate:(float)x andY:(float)y;
```
set cube rotate
```objective-c
-(void)addAmbientLight:(GeometricShapeAmbientLight *)toAmbientLight;
```
add ambient light
```objective-c
-(void)addDiffuseLight:(GeometricShapeDiffuseLight *)toDiffuseLight;
```
add diffuse light
```objective-c
-(void)setup;
```
setup cube
```objective-c
-(void)generate;
```
generate cube

### GeometricShapeAmbientLight
```objective-c
-(void)setLightColor:(UIColor *)toColor;
```
set ambient light color

### GeometricShapeDiffuseLight
```objective-c
-(void)setVectorX:(float)x y:(float)y z:(float)z;
```
set diffuse light vector
```objective-c
-(void)setLightColor:(UIColor *)toColor;
```
set diffuse light color

## Install
```objective-c
git clone https://github.com/egul/geometricshape.git
```
Move files in GeometricShape folder to project

## License
MIT
