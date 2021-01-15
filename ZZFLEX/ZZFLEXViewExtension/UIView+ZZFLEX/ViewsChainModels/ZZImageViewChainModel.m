//
//  ZZImageViewChainModel.m
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZImageViewChainModel.h"

#define     ZZFLEXC_IV_IMP(ZZParamType, methodName)      ZZFLEXC_IMP(ZZImageViewChainModel, UIImageView, ZZParamType, methodName)

@implementation ZZImageViewChainModel

+ (Class)viewClass
{
    return [UIImageView class];
}

ZZFLEXC_IV_IMP(UIImage *, image)
ZZFLEXC_IV_IMP(UIImage *, highlightedImage)
ZZFLEXC_IV_IMP(BOOL, highlighted)

@end

ZZFLEX_EX_IMP(ZZImageViewChainModel, UIImageView)
