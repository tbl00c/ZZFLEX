//
//  ZZScrollViewChainModel.m
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZScrollViewChainModel.h"

#define     ZZFLEXC_IMP_VIEW_TYPE   UIScrollView

@implementation _ZZScrollViewChainModel

+ (Class)viewClass {
    return [UIScrollView class];
}

ZZFLEXC_IMP(id<UIScrollViewDelegate>, delegate)

ZZFLEXC_IMP(CGSize, contentSize)
ZZFLEXC_IMP(CGPoint, contentOffset)
ZZFLEXC_IMP(UIEdgeInsets, contentInset)

ZZFLEXC_IMP(BOOL, bounces)
ZZFLEXC_IMP(BOOL, alwaysBounceVertical)
ZZFLEXC_IMP(BOOL, alwaysBounceHorizontal)

ZZFLEXC_IMP(CGFloat, zoomScale)
ZZFLEXC_IMP(CGFloat, minimumZoomScale)
ZZFLEXC_IMP(CGFloat, maximumZoomScale)

ZZFLEXC_IMP(BOOL, pagingEnabled)
ZZFLEXC_IMP(BOOL, scrollEnabled)

ZZFLEXC_IMP(BOOL, showsHorizontalScrollIndicator)
ZZFLEXC_IMP(BOOL, showsVerticalScrollIndicator)

ZZFLEXC_IMP(BOOL, scrollsToTop)

@end

ZZFLEX_EX_IMP(ZZScrollViewChainModel)
