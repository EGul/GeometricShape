//
//  GeometricShapeCube.h
//  GeometricShape
//
//  Created by Evan on 9/1/15.
//  Copyright (c) 2015 none. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GeometricShapeCube : UIView {
        
    float rotateX;
    float rotateY;
    
    UIColor *ambientLightColor;
    
    NSArray *diffuseLightVector;
    UIColor *diffuseLightColor;
    
}

-(void)setup;
-(void)generate;
-(void)setColor:(UIColor *)color;
-(void)setRotate:(float)x andY:(float)y;
-(void)addAmbientLightWithColor:(UIColor *)color;
-(void)addDiffuseLightWithVectorX:(float)x y:(float)y z:(float)z color:(UIColor *)color;

@end
