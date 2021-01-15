//
//  ZZButtonChainModel.h
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZBaseViewChainModel.h"

#define     ZZFLEXC_BUTTON_API(ZZParamType, methodName)      ZZFLEXC_API(ZZButtonChainModel, ZZParamType, methodName)

typedef void (^ZZChainControlEventBlock)(id sender);

@class ZZButtonChainModel;
@interface ZZButtonChainModel : ZZBaseViewChainModel<ZZButtonChainModel *>

ZZFLEXC_BUTTON_API(NSString *, title)
ZZFLEXC_BUTTON_API(NSString *, titleHL)
ZZFLEXC_BUTTON_API(NSString *, titleSelected)
ZZFLEXC_BUTTON_API(NSString *, titleDisabled)

ZZFLEXC_BUTTON_API(UIColor *, titleColor)
ZZFLEXC_BUTTON_API(UIColor *, titleColorHL)
ZZFLEXC_BUTTON_API(UIColor *, titleColorSelected)
ZZFLEXC_BUTTON_API(UIColor *, titleColorDisabled)

ZZFLEXC_BUTTON_API(UIColor *, titleShadowColor)
ZZFLEXC_BUTTON_API(UIColor *, titleShadowColorHL)
ZZFLEXC_BUTTON_API(UIColor *, titleShadowColorSelected)
ZZFLEXC_BUTTON_API(UIColor *, titleShadowColorDisabled)

ZZFLEXC_BUTTON_API(UIImage *, image)
ZZFLEXC_BUTTON_API(UIImage *, imageHL)
ZZFLEXC_BUTTON_API(UIImage *, imageSelected)
ZZFLEXC_BUTTON_API(UIImage *, imageDisabled)

ZZFLEXC_BUTTON_API(UIImage *, backgroundImage)
ZZFLEXC_BUTTON_API(UIImage *, backgroundImageHL)
ZZFLEXC_BUTTON_API(UIImage *, backgroundImageSelected)
ZZFLEXC_BUTTON_API(UIImage *, backgroundImageDisabled)

ZZFLEXC_BUTTON_API(NSAttributedString *, attributedTitle)
ZZFLEXC_BUTTON_API(NSAttributedString *, attributedTitleHL)
ZZFLEXC_BUTTON_API(NSAttributedString *, attributedTitleSelected)
ZZFLEXC_BUTTON_API(NSAttributedString *, attributedTitleDisabled)

ZZFLEXC_BUTTON_API(UIColor *, backgroundColorHL)
ZZFLEXC_BUTTON_API(UIColor *, backgroundColorSelected)
ZZFLEXC_BUTTON_API(UIColor *, backgroundColorDisabled)

ZZFLEXC_BUTTON_API(UIFont *, titleFont)

ZZFLEXC_BUTTON_API(UIEdgeInsets, contentEdgeInsets)
ZZFLEXC_BUTTON_API(UIEdgeInsets, titleEdgeInsets)
ZZFLEXC_BUTTON_API(UIEdgeInsets, imageEdgeInsets)

#pragma mark - # UIControl
ZZFLEXC_BUTTON_API(BOOL, enabled)
ZZFLEXC_BUTTON_API(BOOL, selected)
ZZFLEXC_BUTTON_API(BOOL, highlighted)

ZZFLEXC_PROPERTY ZZButtonChainModel *(^ eventBlock)(UIControlEvents controlEvents, ZZChainControlEventBlock eventBlock);

ZZFLEXC_BUTTON_API(ZZChainControlEventBlock, eventTouchDown)
ZZFLEXC_BUTTON_API(ZZChainControlEventBlock, eventTouchDownRepeat)
ZZFLEXC_BUTTON_API(ZZChainControlEventBlock, eventTouchUpInside)
ZZFLEXC_BUTTON_API(ZZChainControlEventBlock, eventTouchUpOutside)
ZZFLEXC_BUTTON_API(ZZChainControlEventBlock, eventTouchCancel)

ZZFLEXC_BUTTON_API(UIControlContentVerticalAlignment, contentVerticalAlignment)
ZZFLEXC_BUTTON_API(UIControlContentHorizontalAlignment, contentHorizontalAlignment)

@end

ZZFLEX_EX_API(ZZButtonChainModel, UIButton)
