//
//  ZZBaseViewChainModel.m
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZBaseViewChainModel.h"
#import "UIView+ZZFrame.h"
#import <Masonry/Masonry.h>

#define     ZZFLEXC_BASE_IMP(ZZParamType, methodName)   \
- (id (^)(ZZParamType param))methodName {   \
return ^id (ZZParamType param) {    \
    ((UIView *)self.view).methodName = param;   \
    return self;    \
};\
}

#define     ZZFLEXC_MASONRY_IMP(methodName, masonryMethod) \
- (id (^)( void (^constraints)(__kindof UIView *, MASConstraintMaker *)) )methodName    \
{   \
return ^id ( void (^constraints)(__kindof UIView *, MASConstraintMaker *) ) {  \
if (self.view.superview) { \
[self.view masonryMethod:^(MASConstraintMaker *make){   \
constraints(self.view, make);   \
}];    \
}   \
return self;    \
};  \
}

#define     ZZFLEXC_LAYER_IMP(ZZParamType, methodName) \
- (id (^)(ZZParamType param))methodName    \
{   \
return ^id (ZZParamType param) {    \
self.view.layer.methodName = param;   \
return self;    \
};\
}

@implementation ZZBaseViewChainModel

+ (Class)viewClass
{
    return [UIView class];
}

- (id)initWithTag:(NSInteger)tag andView:(__kindof UIView *)view
{
    if (self = [super init]) {
        _tag = tag;
        _view = view;
        [view setTag:tag];
    }
    return self;
}

#pragma mark - # Frame
ZZFLEXC_BASE_IMP(CGRect, frame)

ZZFLEXC_BASE_IMP(CGPoint, origin)
ZZFLEXC_BASE_IMP(CGFloat, x)
ZZFLEXC_BASE_IMP(CGFloat, y)

ZZFLEXC_BASE_IMP(CGSize, size)
ZZFLEXC_BASE_IMP(CGFloat, width)
ZZFLEXC_BASE_IMP(CGFloat, height)

ZZFLEXC_BASE_IMP(CGPoint, center)
ZZFLEXC_BASE_IMP(CGFloat, centerX)
ZZFLEXC_BASE_IMP(CGFloat, centerY)

ZZFLEXC_BASE_IMP(CGFloat, top)
ZZFLEXC_BASE_IMP(CGFloat, bottom)
ZZFLEXC_BASE_IMP(CGFloat, left)
ZZFLEXC_BASE_IMP(CGFloat, right)

#pragma mark - # Layout
ZZFLEXC_MASONRY_IMP(masonry, mas_makeConstraints);
ZZFLEXC_MASONRY_IMP(updateMasonry, mas_updateConstraints);
ZZFLEXC_MASONRY_IMP(remakeMasonry, mas_remakeConstraints);

- (id (^)(UILayoutPriority priority))horizontalAxisCompressionResistancePriority {
    return ^id(UILayoutPriority priority) {
        [self.view setContentCompressionResistancePriority:priority forAxis:UILayoutConstraintAxisHorizontal];
        return self;
    };
}

- (id (^)(UILayoutPriority priority))verticalAxisCompressionResistancePriority {
    return ^id(UILayoutPriority priority) {
        [self.view setContentCompressionResistancePriority:priority forAxis:UILayoutConstraintAxisVertical];
        return self;
    };
}

- (id (^)(UILayoutPriority priority))horizontalAxisHuggingPriority {
    return ^id(UILayoutPriority priority) {
        [self.view setContentHuggingPriority:priority forAxis:UILayoutConstraintAxisHorizontal];
        return self;
    };
}

- (id (^)(UILayoutPriority priority))verticalAxisHuggingPriority {
    return ^id(UILayoutPriority priority) {
        [self.view setContentHuggingPriority:priority forAxis:UILayoutConstraintAxisVertical];
        return self;
    };
}

#pragma mark - # Color
ZZFLEXC_BASE_IMP(UIColor *, backgroundColor)
ZZFLEXC_BASE_IMP(UIColor *, tintColor)
ZZFLEXC_BASE_IMP(CGFloat, alpha)

#pragma mark - # Control
ZZFLEXC_BASE_IMP(UIViewContentMode, contentMode)

ZZFLEXC_BASE_IMP(BOOL, opaque)
ZZFLEXC_BASE_IMP(BOOL, hidden)
ZZFLEXC_BASE_IMP(BOOL, clipsToBounds)

ZZFLEXC_BASE_IMP(BOOL, userInteractionEnabled)
ZZFLEXC_BASE_IMP(BOOL, multipleTouchEnabled)

#pragma mark - # Layer
ZZFLEXC_LAYER_IMP(BOOL, masksToBounds)

- (id (^)(CGFloat cornerRadius))cornerRadius
{
    return ^__kindof ZZBaseViewChainModel *(CGFloat cornerRadius) {
        [self.view.layer setMasksToBounds:YES];
        [self.view.layer setCornerRadius:cornerRadius];
        return self;
    };
}

- (id (^)(CGFloat borderWidth, UIColor *borderColor))border
{
    return ^__kindof ZZBaseViewChainModel *(CGFloat borderWidth, UIColor *borderColor) {
        [self.view.layer setBorderWidth:borderWidth];
        [self.view.layer setBorderColor:borderColor.CGColor];
        return self;
    };
}
ZZFLEXC_LAYER_IMP(CGFloat, borderWidth)
ZZFLEXC_LAYER_IMP(CGColorRef, borderColor)

ZZFLEXC_LAYER_IMP(CGFloat, zPosition)
ZZFLEXC_LAYER_IMP(CGPoint, anchorPoint)

- (id (^)(CGSize shadowOffset, CGFloat shadowRadius, UIColor *shadowColor, CGFloat shadowOpacity))shadow
{
    return ^__kindof ZZBaseViewChainModel *(CGSize shadowOffset, CGFloat shadowRadius, UIColor *shadowColor, CGFloat shadowOpacity) {
        [self.view.layer setShadowOffset:shadowOffset];
        [self.view.layer setShadowRadius:shadowRadius];
        [self.view.layer setShadowColor:shadowColor.CGColor];
        [self.view.layer setShadowOpacity:shadowOpacity];
        return self;
    };
}
ZZFLEXC_LAYER_IMP(CGColorRef, shadowColor)
ZZFLEXC_LAYER_IMP(CGFloat, shadowOpacity)
ZZFLEXC_LAYER_IMP(CGSize, shadowOffset)
ZZFLEXC_LAYER_IMP(CGFloat, shadowRadius)

ZZFLEXC_LAYER_IMP(CATransform3D, transform)

@end

