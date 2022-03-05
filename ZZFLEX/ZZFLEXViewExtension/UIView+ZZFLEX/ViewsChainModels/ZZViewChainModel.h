//
//  ZZViewChainModel.h
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZBorder.h"
#import "ZZShadow.h"
#import "ZZFLEXChainModelMacros.h"

@class MASConstraintMaker;
@interface _ZZViewChainModel <ObjcType> : NSObject

+ (Class)viewClass;

/// 视图的唯一标示
@property (nonatomic, assign, readonly) NSInteger tag;

/// 视图的唯一标示
@property (nonatomic, strong, readonly) __kindof UIView *view;

- (instancetype)initWithTag:(NSInteger)tag andView:(__kindof UIView *)view;

#pragma mark - # Frame
ZZFLEXC_API(CGRect, frame)

ZZFLEXC_API(CGPoint, origin)
ZZFLEXC_API(CGFloat, x)
ZZFLEXC_API(CGFloat, y)

ZZFLEXC_API(CGSize, size)
ZZFLEXC_API(CGFloat, width)
ZZFLEXC_API(CGFloat, height)

ZZFLEXC_API(CGPoint, center)
ZZFLEXC_API(CGFloat, centerX)
ZZFLEXC_API(CGFloat, centerY)

ZZFLEXC_API(CGFloat, top)
ZZFLEXC_API(CGFloat, bottom)
ZZFLEXC_API(CGFloat, left)
ZZFLEXC_API(CGFloat, right)

ZZFLEXC_API(UIViewAutoresizing, autoresizingMask)
ZZFLEXC_API(NSString *, accessibilityLabel)

#pragma mark - # Layout
ZZFLEXC_PROPERTY ObjcType (^ masonry)( void (^constraints)(__kindof UIView *sender, MASConstraintMaker *make) );
ZZFLEXC_PROPERTY ObjcType (^ updateMasonry)( void (^constraints)(__kindof UIView *sender, MASConstraintMaker *make) );
ZZFLEXC_PROPERTY ObjcType (^ remakeMasonry)( void (^constraints)(__kindof UIView *sender, MASConstraintMaker *make) );

ZZFLEXC_API(UILayoutPriority, horizontalAxisCompressionResistancePriority)
ZZFLEXC_API(UILayoutPriority, verticalAxisCompressionResistancePriority)
ZZFLEXC_API(UILayoutPriority, horizontalAxisHuggingPriority)
ZZFLEXC_API(UILayoutPriority, verticalAxisHuggingPriority)

#pragma mark - # Color
ZZFLEXC_API(UIColor *, backgroundColor)
ZZFLEXC_API(UIColor *, tintColor)
ZZFLEXC_API(CGFloat, alpha)

#pragma mark - # Control
ZZFLEXC_API(UIViewContentMode, contentMode)

ZZFLEXC_API(BOOL, opaque)
ZZFLEXC_API(BOOL, hidden)
ZZFLEXC_API(BOOL, clipsToBounds)

ZZFLEXC_API(BOOL, userInteractionEnabled)
ZZFLEXC_API(BOOL, multipleTouchEnabled)
ZZFLEXC_API(BOOL, exclusiveTouch)
ZZFLEXC_API(BOOL, autoresizesSubviews)

#pragma mark - # Layer
ZZFLEXC_API(BOOL, masksToBounds)
ZZFLEXC_API(CGFloat, cornerRadius)

ZZFLEXC_API(ZZBorderModel *, border)
ZZFLEXC_PROPERTY ObjcType (^border2)(CGFloat borderWidth, UIColor *borderColor);
ZZFLEXC_API(CGFloat, borderWidth)
ZZFLEXC_API(UIColor *, borderColor)

ZZFLEXC_API(CGFloat, zPosition)
ZZFLEXC_API(CGPoint, anchorPoint)

ZZFLEXC_API(ZZShadowModel *, shadow)
ZZFLEXC_PROPERTY ObjcType (^shadow4)(CGSize shadowOffset, CGFloat shadowRadius, UIColor *shadowColor, CGFloat shadowOpacity);
ZZFLEXC_API(UIColor *, shadowColor)
ZZFLEXC_API(CGFloat, shadowOpacity)
ZZFLEXC_API(CGSize, shadowOffset)
ZZFLEXC_API(CGFloat, shadowRadius)

ZZFLEXC_API(CATransform3D, transform)

@end

ZZFLEX_EX_API(ZZViewChainModel, UIView)
