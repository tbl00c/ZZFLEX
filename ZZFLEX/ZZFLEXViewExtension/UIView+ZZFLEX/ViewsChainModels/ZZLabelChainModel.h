//
//  ZZLabelChainModel.h
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZBaseViewChainModel.h"

#define     ZZFLEXC_LABEL_API(ZZParamType, methodName)      ZZFLEXC_API(ZZLabelChainModel, ZZParamType, methodName)

@class ZZLabelChainModel;
@interface ZZLabelChainModel : ZZBaseViewChainModel <ZZLabelChainModel *>

ZZFLEXC_LABEL_API(NSString *, text)
ZZFLEXC_LABEL_API(UIFont *, font)
ZZFLEXC_LABEL_API(UIColor *, textColor)
ZZFLEXC_LABEL_API(NSAttributedString *, attributedText)

ZZFLEXC_LABEL_API(NSTextAlignment, textAlignment)
ZZFLEXC_LABEL_API(NSInteger, numberOfLines)
ZZFLEXC_LABEL_API(NSLineBreakMode, lineBreakMode)
ZZFLEXC_LABEL_API(BOOL, adjustsFontSizeToFitWidth)

@end

ZZFLEX_EX_API(ZZLabelChainModel, UILabel)
