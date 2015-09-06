//
//  GeometricShapeCube.h
//  GeometricShape
//
//  Created by Evan on 9/1/15.
//  Copyright (c) 2015 none. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GeometricShapeDiffuseLight.h"
#import "GeometricShapeAmbientLight.h"

@interface GeometricShapeCube : UIView {
        
    float rotateX;
    float rotateY;
    
    GeometricShapeAmbientLight *ambientLight;
    GeometricShapeDiffuseLight *diffuseLight;
    
}

-(void)setup;
-(void)generate;
-(void)setColor:(UIColor *)color;
-(void)setRotate:(float)x andY:(float)y;
-(void)addAmbientLight:(GeometricShapeAmbientLight *)toAmbientLight;
-(void)addDiffuseLight:(GeometricShapeDiffuseLight *)toDiffuseLight;

@end
