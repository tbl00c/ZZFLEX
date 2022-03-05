//
//  _ZZViewChainModel.m
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZViewChainModel.h"
#import "UIView+ZZFrame.h"
#import <Masonry/Masonry.h>
#import "ZZFLEXAppearance.h"
#import "ZZViewChainModel.h"

#define     ZZFLEXC_IMP_VIEW_TYPE   UIView

/// Masonry链式API实现
#define     ZZFLEXC_MASONRY_IMP(methodName, masonryMethod) \
- (id (^)( void (^constraints)(__kindof UIView *, MASConstraintMaker *)) )methodName {   \
    return ^id ( void (^constraints)(__kindof UIView *, MASConstraintMaker *) ) {  \
        if (self.view.superview) { \
            [self.view masonryMethod:^(MASConstraintMaker *make){   \
                constraints(self.view, make);   \
            }];    \
        }   \
        return self;    \
    };  \
}

/// Layer链式API实现
#define     ZZFLEXC_LAYER_IMP(ZZParamType, methodName) \
- (id (^)(ZZParamType param))methodName {   \
    return ^id (ZZParamType param) {    \
        self.view.layer.methodName = param;   \
        return self;    \
    };\
}

@implementation _ZZViewChainModel

+ (Class)viewClass {
    return [UIView class];
}

- (id)initWithTag:(NSInteger)tag andView:(__kindof UIView *)view {
    if (self = [super init]) {
        _tag = tag;
        _view = view;
        [view setTag:tag];
    }
    return self;
}

#pragma mark - # Frame
ZZFLEXC_IMP(CGRect, frame)

ZZFLEXC_IMP(CGPoint, origin)
ZZFLEXC_IMP(CGFloat, x)
ZZFLEXC_IMP(CGFloat, y)

ZZFLEXC_IMP(CGSize, size)
ZZFLEXC_IMP(CGFloat, width)
ZZFLEXC_IMP(CGFloat, height)

ZZFLEXC_IMP(CGPoint, center)
ZZFLEXC_IMP(CGFloat, centerX)
ZZFLEXC_IMP(CGFloat, centerY)

ZZFLEXC_IMP(CGFloat, top)
ZZFLEXC_IMP(CGFloat, bottom)
ZZFLEXC_IMP(CGFloat, left)
ZZFLEXC_IMP(CGFloat, right)

ZZFLEXC_IMP(UIViewAutoresizing, autoresizingMask)
ZZFLEXC_IMP(NSString *, accessibilityLabel)

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
ZZFLEXC_IMP(UIColor *, backgroundColor)
ZZFLEXC_IMP(UIColor *, tintColor)
ZZFLEXC_IMP(CGFloat, alpha)

#pragma mark - # Control
ZZFLEXC_IMP(UIViewContentMode, contentMode)

ZZFLEXC_IMP(BOOL, opaque)
ZZFLEXC_IMP(BOOL, hidden)
ZZFLEXC_IMP(BOOL, clipsToBounds)

ZZFLEXC_IMP(BOOL, userInteractionEnabled)
ZZFLEXC_IMP(BOOL, multipleTouchEnabled)
ZZFLEXC_IMP(BOOL, exclusiveTouch)
ZZFLEXC_IMP(BOOL, autoresizesSubviews)

#pragma mark - # Layer
ZZFLEXC_LAYER_IMP(BOOL, masksToBounds)

- (id (^)(CGFloat cornerRadius))cornerRadius {
    return ^__kindof _ZZViewChainModel *(CGFloat cornerRadius) {
        [self.view.layer setMasksToBounds:YES];
        [self.view.layer setCornerRadius:cornerRadius];
        return self;
    };
}

- (id (^)(ZZBorderModel *border))border {
    return ^__kindof _ZZViewChainModel *(ZZBorderModel *border) {
        [self.view.layer setMasksToBounds:YES];
        [self.view.layer setBorderWidth:border.width];
        [self.view.layer setBorderColor:border.color.CGColor];
        [self.view.layer setCornerRadius:border.radius];
        return self;
    };
}
- (id (^)(CGFloat borderWidth, UIColor *borderColor))border2 {
    return ^__kindof _ZZViewChainModel *(CGFloat borderWidth, UIColor *borderColor) {
        [self.view.layer setBorderWidth:borderWidth];
        [self.view.layer setBorderColor:borderColor.CGColor];
        return self;
    };
}

ZZFLEXC_LAYER_IMP(CGFloat, borderWidth)
- (id (^)(UIColor *borderColor))borderColor {
    return ^__kindof _ZZViewChainModel *(UIColor *borderColor) {
        [self.view.layer setBorderColor:borderColor.CGColor];
        if ([ZZFLEXAppearance appearance].borderColorAction) {
            [ZZFLEXAppearance appearance].borderColorAction(self.view, borderColor);
        }
        return self;
    };
}

ZZFLEXC_LAYER_IMP(CGFloat, zPosition)
ZZFLEXC_LAYER_IMP(CGPoint, anchorPoint)

- (id (^)(ZZShadowModel *shadow))shadow {
    return ^__kindof _ZZViewChainModel *(ZZShadowModel *shadow) {
        [self.view.layer setShadowOffset:shadow.offset];
        [self.view.layer setShadowRadius:shadow.radius];
        [self.view.layer setShadowColor:shadow.color.CGColor];
        [self.view.layer setShadowOpacity:shadow.opacity];
        return self;
    };
}

- (id (^)(CGSize shadowOffset, CGFloat shadowRadius, UIColor *shadowColor, CGFloat shadowOpacity))shadow4 {
    return ^__kindof _ZZViewChainModel *(CGSize shadowOffset, CGFloat shadowRadius, UIColor *shadowColor, CGFloat shadowOpacity) {
        [self.view.layer setShadowOffset:shadowOffset];
        [self.view.layer setShadowRadius:shadowRadius];
        [self.view.layer setShadowColor:shadowColor.CGColor];
        [self.view.layer setShadowOpacity:shadowOpacity];
        if ([ZZFLEXAppearance appearance].shadowColorAction) {
            [ZZFLEXAppearance appearance].shadowColorAction(self.view, shadowColor);
        }
        return self;
    };
}
- (id (^)(UIColor *shadowColor))shadowColor {
    return ^__kindof _ZZViewChainModel *(UIColor *shadowColor) {
        [self.view.layer setShadowColor:shadowColor.CGColor];
        return self;
    };
}
ZZFLEXC_LAYER_IMP(CGFloat, shadowOpacity)
ZZFLEXC_LAYER_IMP(CGSize, shadowOffset)
ZZFLEXC_LAYER_IMP(CGFloat, shadowRadius)

ZZFLEXC_LAYER_IMP(CATransform3D, transform)

@end

ZZFLEX_EX_IMP(ZZViewChainModel)
