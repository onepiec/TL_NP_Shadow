//
//  TLShadow.m
//  TLShadow
//
//  Created by TL on 2020/2/28.
//  Copyright © 2020 TL. All rights reserved.
//

#define RGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define WeightColor RGBColor(203,214,226)
#define LightColor  RGBColor(243,246,253)
#import "TLShadow.h"

@implementation TLShadowConfiguration
+ (instancetype)sharedInstance{
    static TLShadowConfiguration *config = nil;
    static dispatch_once_t s_predicate;
    dispatch_once(&s_predicate, ^{
        config = [[TLShadowConfiguration alloc]init];
    });
    return config;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        self.sideType = OutSide;
        self.directionType = RightBottomDirection;
    }
    return self;
}
@end

@implementation TLShadow

+ (void)tl_initShadow:(UIView *)view{
    [self tl_initShadow:view configuration:[TLShadowConfiguration sharedInstance]];
}
+ (void)tl_initShadow:(UIView *)view configuration:(TLShadowConfiguration *)configuration{
    view.layer.masksToBounds = YES;
    if (configuration.sideType == OutSide) {
        [self tl_initOutSideShadow:view direction:configuration.directionType];
    }else{
        [self tl_initInSideShadow:view direction:configuration.directionType];
    }
}

+ (void)tl_initOutSideShadow:(UIView *)view direction:(DirectionType)directionType{
    
    CGSize weightSize;
    CGSize lightSize;
    
    if (directionType == RightTopDirection) {
        weightSize = CGSizeMake(3, -3);
        lightSize  = CGSizeMake(-3, 3);
    }else if (directionType == RightBottomDirection){
        weightSize = CGSizeMake(3, 3);
        lightSize  = CGSizeMake(-3, -3);
    }else if (directionType == LeftTopDirection){
        weightSize = CGSizeMake(-3, -3);
        lightSize  = CGSizeMake(3, 3);
    }else{
        weightSize = CGSizeMake(-3, 3);
        lightSize  = CGSizeMake(3, -3);
    }

    for (int i =0; i <2; i ++) {
        CALayer *layer = [CALayer layer];
        layer.frame = view.frame;
        layer.backgroundColor = view.backgroundColor.CGColor;
        layer.cornerRadius = view.layer.cornerRadius;
        if (i == 0) {
            layer.shadowOffset = weightSize;
            layer.shadowColor = WeightColor.CGColor;
        }else{
            layer.shadowOffset = lightSize;
            layer.shadowColor = LightColor.CGColor;
        }
        layer.shadowOpacity = 1;
        [view.superview.layer insertSublayer:layer below:view.layer];
    }
}
+ (void)tl_initInSideShadow:(UIView *)view direction:(DirectionType)directionType{
    
    CGSize weightSize;
    CGSize lightSize;
    
    if (directionType == RightTopDirection) {
        weightSize = CGSizeMake(-3, 3);
        lightSize  = CGSizeMake(3, -3);
    }else if (directionType == RightBottomDirection){
        weightSize = CGSizeMake(-3, -3);
        lightSize  = CGSizeMake(3, 3);
    }else if (directionType == LeftTopDirection){
        weightSize = CGSizeMake(3, 3);
        lightSize  = CGSizeMake(-3, -3);
    }else{
        weightSize = CGSizeMake(3, -3);
        lightSize  = CGSizeMake(-3, 3);
    }
    
    CAShapeLayer* shadowLayer0 = [CAShapeLayer layer];
    CAShapeLayer* shadowLayer1 = [CAShapeLayer layer];
    NSArray *shadowLayerArr = @[shadowLayer0 ,shadowLayer1];

    for (int i =0; i <shadowLayerArr.count; i ++) {
        
        CAShapeLayer *shadowLayer = shadowLayerArr[i];
        shadowLayer.frame = view.bounds;
        if (0 == i) {
            shadowLayer.shadowOffset = weightSize;
            shadowLayer.shadowColor = WeightColor.CGColor;
        }else{
            shadowLayer.shadowOffset = lightSize;
            shadowLayer.shadowColor = LightColor.CGColor;
        }
        shadowLayer.shadowOpacity = 1;
        shadowLayer.fillRule = kCAFillRuleEvenOdd;
    }
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path,NULL,CGRectInset(view.bounds, -5, -5));//阴影的宽度
    
    CGPathRef someInnerPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-0.5, -0.5, view.bounds.size.width + 1, view.bounds.size.height + 1) cornerRadius:view.layer.cornerRadius].CGPath;//消除边界黑影
                               
    CGPathAddPath(path,NULL, someInnerPath);
    CGPathCloseSubpath(path);
    
    shadowLayer0.path = path;
    shadowLayer1.path = path;
    
    CGPathRelease(path);
    
    for (CAShapeLayer *shadowLayer in shadowLayerArr) {
        
        [view.layer addSublayer:shadowLayer];

        CAShapeLayer* maskLayer = [CAShapeLayer layer];
        maskLayer.path = someInnerPath;
        
        shadowLayer.mask = maskLayer;
    }
}
@end
