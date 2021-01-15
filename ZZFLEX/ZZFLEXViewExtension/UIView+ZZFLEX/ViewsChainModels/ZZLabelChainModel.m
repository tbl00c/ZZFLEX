//
//  ZZLabelChainModel.m
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZLabelChainModel.h"

#define     ZZFLEXC_LABEL_IMP(ZZParamType, methodName)      ZZFLEXC_IMP(ZZLabelChainModel, UILabel, ZZParamType, methodName)

@implementation ZZLabelChainModel

+ (Class)viewClass
{
    return [UILabel class];
}

ZZFLEXC_LABEL_IMP(NSString *, text)
ZZFLEXC_LABEL_IMP(UIFont *, font)
ZZFLEXC_LABEL_IMP(UIColor *, textColor)
ZZFLEXC_LABEL_IMP(NSAttributedString *, attributedText)

ZZFLEXC_LABEL_IMP(NSTextAlignment, textAlignment)
ZZFLEXC_LABEL_IMP(NSInteger, numberOfLines)
ZZFLEXC_LABEL_IMP(NSLineBreakMode, lineBreakMode)
ZZFLEXC_LABEL_IMP(BOOL, adjustsFontSizeToFitWidth)

@end

ZZFLEX_EX_IMP(ZZLabelChainModel, UILabel)
