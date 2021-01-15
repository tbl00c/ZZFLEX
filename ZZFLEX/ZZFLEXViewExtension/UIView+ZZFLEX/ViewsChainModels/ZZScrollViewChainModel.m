//
//  ZZScrollViewChainModel.m
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZScrollViewChainModel.h"

#define     ZZFLEXC_SV_IMP(ZZParamType, methodName)      ZZFLEXC_IMP(ZZScrollViewChainModel, UIScrollView, ZZParamType, methodName)

@implementation ZZScrollViewChainModel

+ (Class)viewClass
{
    return [UIScrollView class];
}

ZZFLEXC_SV_IMP(id<UIScrollViewDelegate>, delegate)

ZZFLEXC_SV_IMP(CGSize, contentSize)
ZZFLEXC_SV_IMP(CGPoint, contentOffset)
ZZFLEXC_SV_IMP(UIEdgeInsets, contentInset)

ZZFLEXC_SV_IMP(BOOL, bounces)
ZZFLEXC_SV_IMP(BOOL, alwaysBounceVertical)
ZZFLEXC_SV_IMP(BOOL, alwaysBounceHorizontal)

ZZFLEXC_SV_IMP(BOOL, pagingEnabled)
ZZFLEXC_SV_IMP(BOOL, scrollEnabled)

ZZFLEXC_SV_IMP(BOOL, showsHorizontalScrollIndicator)
ZZFLEXC_SV_IMP(BOOL, showsVerticalScrollIndicator)

ZZFLEXC_SV_IMP(BOOL, scrollsToTop)

@end

ZZFLEX_EX_IMP(ZZScrollViewChainModel, UIScrollView)
