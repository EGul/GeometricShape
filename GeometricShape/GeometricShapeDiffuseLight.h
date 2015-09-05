//
//  GeometricShapeDiffuseLight.h
//  GeometricShape
//
//  Created by Evan on 9/5/15.
//  Copyright (c) 2015 none. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GeometricShapeDiffuseLight : NSObject

typedef struct {
    float red;
    float green;
    float blue;
    float alpha;
} Color;

typedef struct {
    float x;
    float y;
    float z;
} Vector;

@property(nonatomic) Color color;
@property(nonatomic) Vector vector;

-(void)setLightColor:(UIColor *)toColor;
-(void)setVectorX:(float)x y:(float)y z:(float)z;

@end
