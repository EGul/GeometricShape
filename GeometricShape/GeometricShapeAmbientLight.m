//
//  GeometricShapeAmbientLight.m
//  GeometricShape
//
//  Created by sarah on 9/6/15.
//  Copyright (c) 2015 none. All rights reserved.
//

#import "GeometricShapeAmbientLight.h"

@implementation GeometricShapeAmbientLight

-(void)setLightColor:(UIColor *)toColor {
    
    CGFloat red = 0;
    CGFloat green = 0;
    CGFloat blue = 0;
    CGFloat alpha = 0;
    
    [toColor getRed:&red green:&green blue:&blue alpha:&alpha];
    
    LightColor lightColor = {red, green, blue, alpha};
    self.color = lightColor;
    
}

@end
