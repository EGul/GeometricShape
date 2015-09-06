//
//  GeometricShapeCube.m
//  GeometricShape
//
//  Created by Evan on 9/1/15.
//  Copyright (c) 2015 none. All rights reserved.
//

#import "GeometricShapeCube.h"
#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import <GLKit/GLKit.h>

@interface GeometricShapeCube () {
    
    CAEAGLLayer *_eagleLayer;
    EAGLContext *_context;
    GLuint _colorRenderBuffer;
    
    GLuint _positionSlot;
    GLuint _colorSlot;
    GLuint _projectionUniform;
    GLuint _transformationUniform;
    
    GLuint _depthRenderBuffer;
    
    GLuint _normal;
    GLuint _normalTransformation;
    
    GLuint _ambientLightColor;
    
    GLuint _diffuseLightDirection;
    GLuint _diffuseLightColor;
    
}

-(void)setupLayer;
-(void)setupContext;
-(void)setupDepthBuffer;
-(void)setupRenderBuffer;
-(void)setupFrameBuffer;
-(void)setupVertexBufferObjects;
-(void)render;

-(GLuint)compileShader:(NSString *)shaderName withType:(GLenum)shaderType;
-(void)compileShaders;

@end

@implementation GeometricShapeCube

-(id)init {
    
    if (self = [super init]) {
        
    }
    
    return self;
}

typedef struct {
    float Poisition[3];
    float Color[4];
    float Normal[4];
} Vertex;

Vertex Vertices[] = {
    
    {{1, 1, 1}, {1, 1, 1, 1}, {0, 0, 1, 0}},
    {{1, -1, 1}, {1, 1, 1, 1}, {0, 0, 1, 0}},
    {{-1, -1, 1}, {1, 1, 1, 1}, {0, 0, 1, 0}},
    {{-1, 1, 1}, {1, 1, 1, 1}, {0, 0, 1, 0}},
    
    {{1, 1, -1}, {1, 1, 1, 1}, {0, 0, -1, 0}},
    {{1, -1, -1}, {1, 1, 1, 1}, {0, 0, -1, 0}},
    {{-1, -1, -1}, {1, 1, 1, 1}, {0, 0, -1, 0}},
    {{-1, 1, -1}, {1, 1, 1, 1}, {0, 0, -1, 0}},
    
    {{-1, 1, -1}, {1, 1, 1, 1}, {0, 1, 0, 0}},
    {{1, 1, -1}, {1, 1, 1, 1}, {0, 1, 0, 0}},
    {{1, 1, 1}, {1, 1, 1, 1}, {0, 1, 0, 0}},
    {{-1, 1, 1}, {1, 1, 1, 1}, {0, 1, 0, 0}},
    
    {{-1, -1, -1}, {1, 1, 1, 1}, {0, -1, 0, 0}},
    {{1, -1, -1}, {1, 1, 1, 1}, {0, -1, 0, 0}},
    {{1, -1, 1}, {1, 1, 1, 1}, {0, -1, 0, 0}},
    {{-1, -1, 1}, {1, 1, 1, 1}, {0, -1, 0, 0}},
    
    {{-1, 1, -1}, {1, 1, 1, 1}, {-1, 0, 0, 0}},
    {{-1, 1, 1}, {1, 1, 1, 1}, {-1, 0, 0, 0}},
    {{-1, -1, 1}, {1, 1, 1, 1}, {-1, 0, 0, 0}},
    {{-1, -1, -1}, {1, 1, 1, 1}, {-1, 0, 0, 0}},
    
    {{1, 1, -1}, {1, 1, 1, 1}, {1, 0, 0, 0}},
    {{1, 1, 1}, {1, 1, 1, 1}, {1, 0, 0, 0}},
    {{1, -1, 1}, {1, 1, 1, 1}, {1, 0, 0, 0}},
    {{1, -1, -1}, {1, 1, 1, 1}, {1, 0, 0, 0}}
    
};

const GLubyte Indices[] = {
    
    0, 1, 2,
    2, 3, 0,
    
    4, 5, 6,
    6, 7, 4,
    
    8, 9, 10,
    10, 11, 8,
    
    12, 13, 14,
    14, 15, 12,
    
    16, 17, 18,
    18, 19, 16,
    
    20, 21, 22,
    22, 23, 20
    
};

-(void)setup {
    
    [self setupLayer];
    [self setupContext];
    [self setupDepthBuffer];
    [self setupRenderBuffer];
    [self setupFrameBuffer];
    [self compileShaders];
    [self setupVertexBufferObjects];
    [self render];
    
}

-(void)generate {
    [self render];
}

-(void)setColor:(UIColor *)color {
        
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat alpha;
    
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    
    int points = 4 * 6;
    
    for (int i = 0; i < points; i++) {
        Vertices[i].Color[0] = red;
        Vertices[i].Color[1] = green;
        Vertices[i].Color[2] = blue;
        Vertices[i].Color[3] = alpha;
    }
    
}

-(void)setRotate:(float)x andY:(float)y {
    rotateX = x;
    rotateY = y;
}

-(void)addAmbientLight:(GeometricShapeAmbientLight *)toAmbientLight {
    ambientLight = toAmbientLight;
}

-(void)addDiffuseLight:(GeometricShapeDiffuseLight *)toDiffuseLight {
    diffuseLight = toDiffuseLight;
}

+(Class)layerClass {
    return [CAEAGLLayer class];
}

-(GLuint)compileShader:(NSString *)shaderName withType:(GLenum)shaderType {
    
    NSString *shaderPath = [[NSBundle mainBundle]pathForResource:shaderName ofType:@"glsl"];
    NSError *error;
    NSString *shaderString = [NSString stringWithContentsOfFile:shaderPath encoding:NSUTF8StringEncoding error:&error];
    
    if (!shaderString) {
        NSLog(@"error: %@", error.localizedDescription);
        exit(1);
    }
    
    GLuint shaderHandle = glCreateShader(shaderType);
    
    const char *shaderStringUTF8 = [shaderString UTF8String];
    int shaderStringLength = (int)[shaderString length];
    glShaderSource(shaderHandle, 1, &shaderStringUTF8, &shaderStringLength);
    
    glCompileShader(shaderHandle);
    
    GLint compileSuccess;
    glGetShaderiv(shaderHandle, GL_COMPILE_STATUS, &compileSuccess);
    
    if (compileSuccess == GL_FALSE) {
        GLchar messages[256];
        glGetShaderInfoLog(shaderHandle, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"%@", messageString);
        exit(1);
    }
    
    return shaderHandle;
}

-(void)compileShaders {
    
    GLuint vertexShader = [self compileShader:@"Vertex" withType:GL_VERTEX_SHADER];
    GLuint fragmentShader = [self compileShader:@"Fragment" withType:GL_FRAGMENT_SHADER];
    
    GLuint programHandle = glCreateProgram();
    glAttachShader(programHandle, vertexShader);
    glAttachShader(programHandle, fragmentShader);
    glLinkProgram(programHandle);
    
    GLint linkSuccess;
    
    glGetProgramiv(programHandle, GL_LINK_STATUS, &linkSuccess);
    if (linkSuccess == GL_FALSE) {
        GLchar messages[256];
        glGetProgramInfoLog(programHandle, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"%@", messageString);
        exit(1);
    }
    
    glUseProgram(programHandle);
    
    _positionSlot = glGetAttribLocation(programHandle, "Position");
    _colorSlot = glGetAttribLocation(programHandle, "SourceColor");
    glEnableVertexAttribArray(_positionSlot);
    glEnableVertexAttribArray(_colorSlot);
    
    _projectionUniform = glGetUniformLocation(programHandle, "Projection");
    _transformationUniform = glGetUniformLocation(programHandle, "Transformation");
    
    _normal = glGetAttribLocation(programHandle, "normal");
    _normalTransformation = glGetUniformLocation(programHandle, "normalTransformation");
    glEnableVertexAttribArray(_normal);
    
    _ambientLightColor = glGetUniformLocation(programHandle, "ambientLightColor");
    
    _diffuseLightDirection = glGetUniformLocation(programHandle, "diffuseLightDirection");
    _diffuseLightColor = glGetUniformLocation(programHandle, "diffuseLightColor");
    
}

-(void)setupLayer {
    _eagleLayer = (CAEAGLLayer *)self.layer;
    _eagleLayer.opaque = YES;
}

-(void)setupContext {
    
    EAGLRenderingAPI api = kEAGLRenderingAPIOpenGLES2;
    _context = [[EAGLContext alloc]initWithAPI:api];
    
    if (!_context) {
        NSLog(@"error");
        exit(1);
    }
    
    if (![EAGLContext setCurrentContext:_context]) {
        NSLog(@"error");
        exit(1);
    }
    
}

-(void)setupDepthBuffer {
    glGenRenderbuffers(1, &_depthRenderBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _depthRenderBuffer);
    glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT16, self.frame.size.width, self.frame.size.height);
    glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT16, self.frame.size.width, self.frame.size.height);
}

-(void)setupRenderBuffer {
    glGenRenderbuffers(1, &_colorRenderBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderBuffer);
    [_context renderbufferStorage:GL_RENDERBUFFER fromDrawable:_eagleLayer];
}

-(void)setupFrameBuffer {
    GLuint frameBuffer;
    glGenFramebuffers(1, &frameBuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, frameBuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, _colorRenderBuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, _depthRenderBuffer);
}

-(void)setupVertexBufferObjects {
    
    GLuint vertexBuffer;
    glGenBuffers(1, &vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(Vertices), Vertices, GL_STATIC_DRAW);
    
    GLuint indexBuffer;
    glGenBuffers(1, &indexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(Indices), Indices, GL_STATIC_DRAW);
    
}

-(void)render {
    
    glClearColor(1, 1, 1, 1);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glEnable(GL_DEPTH_TEST);
    
    float h = 4.0f * self.frame.size.height / self.frame.size.width;
    GLKMatrix4 projection = GLKMatrix4MakeFrustum(-2, 2, -h/2, h/2, 4, 10);
    glUniformMatrix4fv(_projectionUniform, 1, 0, projection.m);
    
    GLKMatrix4 translation = GLKMatrix4MakeTranslation(0, 0, -7);
    
    GLKMatrix4 rotationX = GLKMatrix4MakeRotation(GLKMathDegreesToRadians(rotateX), 0, 1, 0);
    GLKMatrix4 rotationY = GLKMatrix4MakeRotation(GLKMathDegreesToRadians(rotateY), 1, 0, 0);
    
    GLKMatrix4 final = GLKMatrix4Multiply(translation, GLKMatrix4Multiply(rotationX, rotationY));
    
    glUniformMatrix4fv(_transformationUniform, 1, 0, final.m);
    
    glViewport(0, 0, self.frame.size.width, self.frame.size.height);
    
    glVertexAttribPointer(_positionSlot, 3, GL_FLOAT, GL_FALSE, sizeof(Vertex), 0);
    glVertexAttribPointer(_colorSlot, 4, GL_FLOAT, GL_FALSE, sizeof(Vertex), (GLvoid *)(sizeof(float) * 3));
    
    glVertexAttribPointer(_normal, 4, GL_FLOAT, GL_FALSE, sizeof(Vertex), (GLvoid *)(sizeof(float) * 7));
    GLKMatrix4 normalRotationX = GLKMatrix4MakeRotation(GLKMathDegreesToRadians(rotateX), 0, 1, 0);
    GLKMatrix4 normalRotationY = GLKMatrix4MakeRotation(GLKMathDegreesToRadians(rotateY), 1, 0, 0);
    GLKMatrix4 normalFinal = GLKMatrix4Multiply(normalRotationX, normalRotationY);
    glUniformMatrix4fv(_normalTransformation, 1, 0, normalFinal.m);
    
    if (ambientLight != nil) {
        glUniform4f(_ambientLightColor, ambientLight.color.red, ambientLight.color.green, ambientLight.color.blue, ambientLight.color.alpha);
    }
    
    if (diffuseLight != nil) {
        glUniform3f(_diffuseLightDirection, diffuseLight.vector.x, diffuseLight.vector.y, diffuseLight.vector.z);
        glUniform4f(_diffuseLightColor, diffuseLight.color.red, diffuseLight.color.green, diffuseLight.color.blue, diffuseLight.color.alpha);
    }
    
    glDrawElements(GL_TRIANGLES, sizeof(Indices)/sizeof(Indices[0]), GL_UNSIGNED_BYTE, 0);
    
    [_context presentRenderbuffer:GL_RENDERBUFFER];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
