//
//  GeometricShapeCube.h
//  GeometricShape
//
//  Created by sarah on 9/1/15.
//  Copyright (c) 2015 none. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GeometricShapeCube : UIView {
        
    float rotateX;
    float rotateY;
        
}

-(void)setup;
-(void)generate;
-(void)setColor:(UIColor *)color;
-(void)setRotate:(float)x andY:(float)y;

@end
