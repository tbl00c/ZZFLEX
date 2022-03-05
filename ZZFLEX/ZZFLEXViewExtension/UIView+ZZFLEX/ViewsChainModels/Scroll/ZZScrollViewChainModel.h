//
//  ZZScrollViewChainModel.h
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZViewChainModel.h"

@interface _ZZScrollViewChainModel<ObjcType> : _ZZViewChainModel<ObjcType>

ZZFLEXC_API(id<UIScrollViewDelegate>, delegate)

ZZFLEXC_API(CGSize, contentSize)
ZZFLEXC_API(CGPoint, contentOffset)
ZZFLEXC_API(UIEdgeInsets, contentInset)

ZZFLEXC_API(BOOL, bounces)
ZZFLEXC_API(BOOL, alwaysBounceVertical)
ZZFLEXC_API(BOOL, alwaysBounceHorizontal)

ZZFLEXC_API(CGFloat, zoomScale)
ZZFLEXC_API(CGFloat, minimumZoomScale)
ZZFLEXC_API(CGFloat, maximumZoomScale)

ZZFLEXC_API(BOOL, pagingEnabled)
ZZFLEXC_API(BOOL, scrollEnabled)

ZZFLEXC_API(BOOL, showsHorizontalScrollIndicator)
ZZFLEXC_API(BOOL, showsVerticalScrollIndicator)

ZZFLEXC_API(BOOL, scrollsToTop)

@end

ZZFLEX_EX_API(ZZScrollViewChainModel, UIScrollView)
