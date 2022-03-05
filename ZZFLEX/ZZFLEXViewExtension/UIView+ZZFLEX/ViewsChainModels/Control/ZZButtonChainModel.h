//
//  ZZButtonChainModel.h
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZControlChainModel.h"

@interface _ZZButtonChainModel<ObjcType> : _ZZControlChainModel<ObjcType>

ZZFLEXC_API(NSString *, title)
ZZFLEXC_API(NSString *, titleHL)
ZZFLEXC_API(NSString *, titleSelected)
ZZFLEXC_API(NSString *, titleDisabled)

ZZFLEXC_API(UIColor *, titleColor)
ZZFLEXC_API(UIColor *, titleColorHL)
ZZFLEXC_API(UIColor *, titleColorSelected)
ZZFLEXC_API(UIColor *, titleColorDisabled)

ZZFLEXC_API(UIColor *, titleShadowColor)
ZZFLEXC_API(UIColor *, titleShadowColorHL)
ZZFLEXC_API(UIColor *, titleShadowColorSelected)
ZZFLEXC_API(UIColor *, titleShadowColorDisabled)

ZZFLEXC_API(UIImage *, image)
ZZFLEXC_API(UIImage *, imageHL)
ZZFLEXC_API(UIImage *, imageSelected)
ZZFLEXC_API(UIImage *, imageDisabled)

ZZFLEXC_API(UIImage *, backgroundImage)
ZZFLEXC_API(UIImage *, backgroundImageHL)
ZZFLEXC_API(UIImage *, backgroundImageSelected)
ZZFLEXC_API(UIImage *, backgroundImageDisabled)

ZZFLEXC_API(NSAttributedString *, attributedTitle)
ZZFLEXC_API(NSAttributedString *, attributedTitleHL)
ZZFLEXC_API(NSAttributedString *, attributedTitleSelected)
ZZFLEXC_API(NSAttributedString *, attributedTitleDisabled)

ZZFLEXC_API(UIColor *, backgroundColorHL)
ZZFLEXC_API(UIColor *, backgroundColorSelected)
ZZFLEXC_API(UIColor *, backgroundColorDisabled)

ZZFLEXC_API(UIFont *, titleFont)

ZZFLEXC_API(UIEdgeInsets, contentEdgeInsets)
ZZFLEXC_API(UIEdgeInsets, titleEdgeInsets)
ZZFLEXC_API(UIEdgeInsets, imageEdgeInsets)

@end

ZZFLEX_EX_API(ZZButtonChainModel, UIButton)
