//
//  ZZImageViewChainModel.m
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZImageViewChainModel.h"

#define     ZZFLEXC_IMP_VIEW_TYPE   UIImageView

@implementation _ZZImageViewChainModel

+ (Class)viewClass {
    return [UIImageView class];
}

ZZFLEXC_IMP(UIImage *, image)
ZZFLEXC_IMP(UIImage *, highlightedImage)
ZZFLEXC_IMP(BOOL, highlighted)

@end

ZZFLEX_EX_IMP(ZZImageViewChainModel)
