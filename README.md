#GeometricShape
Create geometric shapes

##Usage
###GeometricShapeCube
```objective-c
GeometricShapeCube *cube = [[GeometricShapeCube alloc]init];

[cube setFrame:CGRectMake(0, 0, 50, 50)];

[cube setColor:[UIColor blueColor]];

[cube addAmbientLightWithColor:[UIColor whiteColor]];
[cube addDiffuseLightWithVectorX:1, y:1, z:1 color:[UIColor whiteColor]];

[view addSubview:cube];
```

##API
###GeometricShapeCube
```objective-c
-(void)setColor:(UIColor *)color;
```
set cube color
```objective-c
-(void)addAmbientLightWithColor:(UIColor *)color;
```
add ambient light
```objective-c
-(void)addDiffuseLightWithVectorX:(int)x y:(int)y z:(int)z color:(UIColor *)color;
```
add diffuse light with vector

##Install
```objective-c
git clone https://github.com/EGul/GeometricShape
```
Move files in GeometricShape folder to project

##License
MIT
