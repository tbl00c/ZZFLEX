//
//  ZZBaseViewChainModel.h
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 链式API声明
#define     ZZFLEXC_PROPERTY              @property (nonatomic, copy, readonly)
#define     ZZFLEXC_API(ZZChainType, ZZParamType, methodName)      ZZFLEXC_PROPERTY ZZChainType *(^ methodName)(ZZParamType methodName);

/// 一般链式API实现
#define     ZZFLEXC_IMP(ZZViewChainModelType, ZZViewClass, ZZParamType, methodName) \
- (ZZViewChainModelType *(^)(ZZParamType param))methodName {   \
    return ^ZZViewChainModelType *(ZZParamType param) {    \
        ((ZZViewClass *)self.view).methodName = param;   \
        return self;    \
    };\
}

/// UIKit拓展声明
#define     ZZFLEX_EX_API(ZZViewChainModelClass, ZZView)   \
@interface ZZView (ZZFLEX_EX)   \
ZZFLEXC_PROPERTY ZZViewChainModelClass *zz_setup;    \
+ (ZZViewChainModelClass *(^)(NSInteger tag))zz_create;   \
@end
/// UIKit拓展实现
#define     ZZFLEX_EX_IMP(ZZViewChainModelClass, ZZView) \
@implementation ZZView (ZZFLEX_EX)  \
+ (ZZViewChainModelClass *(^)(NSInteger tag))zz_create {\
    return ^ZZViewChainModelClass *(NSInteger tag){    \
        ZZView *view = [[ZZView alloc] init];   \
        return [[ZZViewChainModelClass alloc] initWithTag:tag andView:view];    \
    };\
}\
- (ZZViewChainModelClass *)zz_setup {   \
    return [[ZZViewChainModelClass alloc] initWithTag:self.tag andView:self];    \
}   \
@end

#define     ZZFLEXC_BASE_API(ZZParamType, methodName)      ZZFLEXC_PROPERTY ObjcType (^ methodName)(ZZParamType methodName);

@class MASConstraintMaker;
@interface ZZBaseViewChainModel <ObjcType> : NSObject

+ (Class)viewClass;

/// 视图的唯一标示
@property (nonatomic, assign, readonly) NSInteger tag;

/// 视图的唯一标示
@property (nonatomic, strong, readonly) __kindof UIView *view;

- (instancetype)initWithTag:(NSInteger)tag andView:(__kindof UIView *)view;

#pragma mark - # Frame
ZZFLEXC_BASE_API(CGRect, frame)

ZZFLEXC_BASE_API(CGPoint, origin)
ZZFLEXC_BASE_API(CGFloat, x)
ZZFLEXC_BASE_API(CGFloat, y)

ZZFLEXC_BASE_API(CGSize, size)
ZZFLEXC_BASE_API(CGFloat, width)
ZZFLEXC_BASE_API(CGFloat, height)

ZZFLEXC_BASE_API(CGPoint, center)
ZZFLEXC_BASE_API(CGFloat, centerX)
ZZFLEXC_BASE_API(CGFloat, centerY)

ZZFLEXC_BASE_API(CGFloat, top)
ZZFLEXC_BASE_API(CGFloat, bottom)
ZZFLEXC_BASE_API(CGFloat, left)
ZZFLEXC_BASE_API(CGFloat, right)

#pragma mark - # Layout
ZZFLEXC_PROPERTY ObjcType (^ masonry)( void (^constraints)(__kindof UIView *sender, MASConstraintMaker *make) );
ZZFLEXC_PROPERTY ObjcType (^ updateMasonry)( void (^constraints)(__kindof UIView *sender, MASConstraintMaker *make) );
ZZFLEXC_PROPERTY ObjcType (^ remakeMasonry)( void (^constraints)(__kindof UIView *sender, MASConstraintMaker *make) );

ZZFLEXC_BASE_API(UILayoutPriority, horizontalAxisCompressionResistancePriority)
ZZFLEXC_BASE_API(UILayoutPriority, verticalAxisCompressionResistancePriority)
ZZFLEXC_BASE_API(UILayoutPriority, horizontalAxisHuggingPriority)
ZZFLEXC_BASE_API(UILayoutPriority, verticalAxisHuggingPriority)

#pragma mark - # Color
ZZFLEXC_BASE_API(UIColor *, backgroundColor)
ZZFLEXC_BASE_API(UIColor *, tintColor)
ZZFLEXC_BASE_API(CGFloat, alpha)

#pragma mark - # Control
ZZFLEXC_BASE_API(UIViewContentMode, contentMode)

ZZFLEXC_BASE_API(BOOL, opaque)
ZZFLEXC_BASE_API(BOOL, hidden)
ZZFLEXC_BASE_API(BOOL, clipsToBounds)

ZZFLEXC_BASE_API(BOOL, userInteractionEnabled)
ZZFLEXC_BASE_API(BOOL, multipleTouchEnabled)

#pragma mark - # Layer
ZZFLEXC_BASE_API(BOOL, masksToBounds)
ZZFLEXC_BASE_API(CGFloat, cornerRadius)

ZZFLEXC_PROPERTY ObjcType (^ border)(CGFloat borderWidth, UIColor *borderColor);
ZZFLEXC_BASE_API(CGFloat, borderWidth)
ZZFLEXC_BASE_API(CGColorRef, borderColor)

ZZFLEXC_BASE_API(CGFloat, zPosition)
ZZFLEXC_BASE_API(CGPoint, anchorPoint)

ZZFLEXC_PROPERTY ObjcType (^ shadow)(CGSize shadowOffset, CGFloat shadowRadius, UIColor *shadowColor, CGFloat shadowOpacity);
ZZFLEXC_BASE_API(CGColorRef, shadowColor)
ZZFLEXC_BASE_API(CGFloat, shadowOpacity)
ZZFLEXC_BASE_API(CGSize, shadowOffset)
ZZFLEXC_BASE_API(CGFloat, shadowRadius)

ZZFLEXC_BASE_API(CATransform3D, transform)

@end
