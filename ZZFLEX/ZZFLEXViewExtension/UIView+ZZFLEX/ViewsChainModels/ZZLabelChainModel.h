//
//  ZZLabelChainModel.h
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZViewChainModel.h"

@interface _ZZLabelChainModel<ObjcType> : _ZZViewChainModel <ObjcType>

ZZFLEXC_API(NSString *, text)
ZZFLEXC_API(UIFont *, font)
ZZFLEXC_API(UIColor *, textColor)
ZZFLEXC_API(NSAttributedString *, attributedText)

ZZFLEXC_API(NSTextAlignment, textAlignment)
ZZFLEXC_API(NSInteger, numberOfLines)
ZZFLEXC_API(NSLineBreakMode, lineBreakMode)
ZZFLEXC_API(BOOL, adjustsFontSizeToFitWidth)

@end

ZZFLEX_EX_API(ZZLabelChainModel, UILabel)
