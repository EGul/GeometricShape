//
//  GeometricShapeDiffuseLight.m
//  GeometricShape
//
//  Created by Evan on 9/5/15.
//  Copyright (c) 2015 none. All rights reserved.
//

#import "GeometricShapeDiffuseLight.h"

@implementation GeometricShapeDiffuseLight

-(void)setLightColor:(UIColor *)color {
    
    CGFloat red = 0;
    CGFloat green = 0;
    CGFloat blue = 0;
    CGFloat alpha = 0;
    
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    
    Color toColor = {red, green, blue, alpha};
    self.color = toColor;
    
}

-(void)setVectorX:(float)x y:(float)y z:(float)z {
    Vector toVector = {x, y, z};
    self.vector = toVector;
}

@end
