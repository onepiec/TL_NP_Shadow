//
//  TLShadow.h
//  TLShadow
//
//  Created by TL on 2020/2/28.
//  Copyright © 2020 TL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    OutSide,  // 阴影朝外
    InSide,   // 阴影朝里
} SideType;

typedef enum : NSUInteger {
    RightTopDirection,      // 重阴影色在右上
    RightBottomDirection,   // 重阴影色在右下
    LeftTopDirection,       // 重阴影色在左上
    LeftBottomDirection,    // 重阴影色在左下
} DirectionType;

NS_ASSUME_NONNULL_BEGIN

@interface TLShadowConfiguration : NSObject

+ (instancetype)sharedInstance;
@property (nonatomic ,assign)SideType       sideType;
@property (nonatomic ,assign)DirectionType  directionType;

@end

@interface TLShadow : NSObject

+ (void)tl_initShadow:(UIView *)view;
+ (void)tl_initShadow:(UIView *)view configuration:(TLShadowConfiguration *)configuration;

@end

NS_ASSUME_NONNULL_END
