//
//  GeometricShapeCube.h
//  GeometricShape
//
//  Created by Evan on 9/1/15.
//  Copyright (c) 2015 none. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GeometricShapeDiffuseLight.h"

@interface GeometricShapeCube : UIView {
        
    float rotateX;
    float rotateY;
    
    UIColor *ambientLightColor;
    
    GeometricShapeDiffuseLight *diffuseLight;
    
}

-(void)setup;
-(void)generate;
-(void)setColor:(UIColor *)color;
-(void)setRotate:(float)x andY:(float)y;
-(void)addAmbientLightWithColor:(UIColor *)color;
-(void)addDiffuseLight:(GeometricShapeDiffuseLight *)toDiffuseLight;

@end
