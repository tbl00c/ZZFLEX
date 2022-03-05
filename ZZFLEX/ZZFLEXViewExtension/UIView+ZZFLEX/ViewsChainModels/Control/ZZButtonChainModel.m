//
//  ZZButtonChainModel.m
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZButtonChainModel.h"
#import "UIControl+ZZEvent.h"
#import "UIButton+ZZExtension.h"

#define     ZZFLEXC_IMP_VIEW_TYPE   UIButton

#define     ZZFLEXC_BUTTON_STATE_IMP(methodName, ZZParamType, Code, State)    \
- (id (^)(ZZParamType param))methodName {   \
    return ^id (ZZParamType param) {     \
        [(UIButton *)self.view Code:param forState:State];      \
        return self;        \
    };      \
}

#define     ZZFLEXC_BUTTON_TITLE_IMP(methodName, State)             ZZFLEXC_BUTTON_STATE_IMP(methodName, NSString *, setTitle, State)
#define     ZZFLEXC_BUTTON_TITLECOLOR_IMP(methodName, State)        ZZFLEXC_BUTTON_STATE_IMP(methodName, UIColor *, setTitleColor, State)
#define     ZZFLEXC_BUTTON_SHADOW_IMP(methodName, State)            ZZFLEXC_BUTTON_STATE_IMP(methodName, UIColor *, setTitleShadowColor, State)
#define     ZZFLEXC_BUTTON_IMAGE_IMP(methodName, State)             ZZFLEXC_BUTTON_STATE_IMP(methodName, UIImage *, setImage, State)
#define     ZZFLEXC_BUTTON_BGIMAGE_IMP(methodName, State)           ZZFLEXC_BUTTON_STATE_IMP(methodName, UIImage *, setBackgroundImage, State)
#define     ZZFLEXC_BUTTON_ATTRTITLE_IMP(methodName, State)         ZZFLEXC_BUTTON_STATE_IMP(methodName, NSAttributedString *, setAttributedTitle, State)
#define     ZZFLEXC_BUTTON_BGCOLOR_IMP(methodName, State)           ZZFLEXC_BUTTON_STATE_IMP(methodName, UIColor *, setBackgroundColor, State)

@implementation _ZZButtonChainModel

+ (Class)viewClass {
    return [UIButton class];
}

ZZFLEXC_BUTTON_TITLE_IMP(title, UIControlStateNormal);
ZZFLEXC_BUTTON_TITLE_IMP(titleHL, UIControlStateHighlighted);
ZZFLEXC_BUTTON_TITLE_IMP(titleSelected, UIControlStateSelected);
ZZFLEXC_BUTTON_TITLE_IMP(titleDisabled, UIControlStateDisabled);

ZZFLEXC_BUTTON_TITLECOLOR_IMP(titleColor, UIControlStateNormal);
ZZFLEXC_BUTTON_TITLECOLOR_IMP(titleColorHL, UIControlStateHighlighted);
ZZFLEXC_BUTTON_TITLECOLOR_IMP(titleColorSelected, UIControlStateSelected);
ZZFLEXC_BUTTON_TITLECOLOR_IMP(titleColorDisabled, UIControlStateDisabled);

ZZFLEXC_BUTTON_SHADOW_IMP(titleShadowColor, UIControlStateNormal);
ZZFLEXC_BUTTON_SHADOW_IMP(titleShadowColorHL, UIControlStateHighlighted);
ZZFLEXC_BUTTON_SHADOW_IMP(titleShadowColorSelected, UIControlStateSelected);
ZZFLEXC_BUTTON_SHADOW_IMP(titleShadowColorDisabled, UIControlStateDisabled);

ZZFLEXC_BUTTON_IMAGE_IMP(image, UIControlStateNormal);
ZZFLEXC_BUTTON_IMAGE_IMP(imageHL, UIControlStateHighlighted);
ZZFLEXC_BUTTON_IMAGE_IMP(imageSelected, UIControlStateSelected);
ZZFLEXC_BUTTON_IMAGE_IMP(imageDisabled, UIControlStateDisabled);

ZZFLEXC_BUTTON_BGIMAGE_IMP(backgroundImage, UIControlStateNormal);
ZZFLEXC_BUTTON_BGIMAGE_IMP(backgroundImageHL, UIControlStateHighlighted);
ZZFLEXC_BUTTON_BGIMAGE_IMP(backgroundImageSelected, UIControlStateSelected);
ZZFLEXC_BUTTON_BGIMAGE_IMP(backgroundImageDisabled, UIControlStateDisabled);

ZZFLEXC_BUTTON_ATTRTITLE_IMP(attributedTitle, UIControlStateNormal);
ZZFLEXC_BUTTON_ATTRTITLE_IMP(attributedTitleHL, UIControlStateHighlighted);
ZZFLEXC_BUTTON_ATTRTITLE_IMP(attributedTitleSelected, UIControlStateSelected);
ZZFLEXC_BUTTON_ATTRTITLE_IMP(attributedTitleDisabled, UIControlStateDisabled);

ZZFLEXC_BUTTON_BGCOLOR_IMP(backgroundColorHL, UIControlStateHighlighted);
ZZFLEXC_BUTTON_BGCOLOR_IMP(backgroundColorSelected, UIControlStateSelected);
ZZFLEXC_BUTTON_BGCOLOR_IMP(backgroundColorDisabled, UIControlStateDisabled);

- (id (^)(UIFont *titleFont))titleFont {
    return ^id (UIFont *titleFont) {
        ((UIButton *)self.view).titleLabel.font = titleFont;
        return self;
    };
}

ZZFLEXC_IMP(UIEdgeInsets, contentEdgeInsets);
ZZFLEXC_IMP(UIEdgeInsets, titleEdgeInsets);
ZZFLEXC_IMP(UIEdgeInsets, imageEdgeInsets);

@end

ZZFLEX_EX_IMP(ZZButtonChainModel)
