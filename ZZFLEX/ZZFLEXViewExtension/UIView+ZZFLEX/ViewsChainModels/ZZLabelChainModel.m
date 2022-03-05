//
//  ZZLabelChainModel.m
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZLabelChainModel.h"

#define     ZZFLEXC_IMP_VIEW_TYPE   UILabel

@implementation _ZZLabelChainModel

+ (Class)viewClass {
    return [UILabel class];
}

ZZFLEXC_IMP(NSString *, text)
ZZFLEXC_IMP(UIFont *, font)
ZZFLEXC_IMP(UIColor *, textColor)

ZZFLEXC_IMP(NSAttributedString *, attributedText)

ZZFLEXC_IMP(NSTextAlignment, textAlignment)
ZZFLEXC_IMP(NSInteger, numberOfLines)
ZZFLEXC_IMP(NSLineBreakMode, lineBreakMode)
ZZFLEXC_IMP(BOOL, adjustsFontSizeToFitWidth)

@end

ZZFLEX_EX_IMP(ZZLabelChainModel)
