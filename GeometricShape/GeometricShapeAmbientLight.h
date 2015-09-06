//
//  GeometricShapeAmbientLight.h
//  GeometricShape
//
//  Created by sarah on 9/6/15.
//  Copyright (c) 2015 none. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GeometricShapeAmbientLight : NSObject

typedef struct {
    float red;
    float green;
    float blue;
    float alpha;
} LightColor;

@property(nonatomic) LightColor color;

-(void)setLightColor:(UIColor *)toColor;

@end
