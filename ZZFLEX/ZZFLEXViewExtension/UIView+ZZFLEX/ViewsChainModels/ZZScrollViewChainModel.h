//
//  ZZScrollViewChainModel.h
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZBaseViewChainModel.h"

#define     ZZFLEXC_SV_API(ZZParamType, methodName)      ZZFLEXC_API(ZZScrollViewChainModel, ZZParamType, methodName)

@class ZZScrollViewChainModel;
@interface ZZScrollViewChainModel : ZZBaseViewChainModel<ZZScrollViewChainModel *>

ZZFLEXC_SV_API(id<UIScrollViewDelegate>, delegate)

ZZFLEXC_SV_API(CGSize, contentSize)
ZZFLEXC_SV_API(CGPoint, contentOffset)
ZZFLEXC_SV_API(UIEdgeInsets, contentInset)

ZZFLEXC_SV_API(BOOL, bounces)
ZZFLEXC_SV_API(BOOL, alwaysBounceVertical)
ZZFLEXC_SV_API(BOOL, alwaysBounceHorizontal)

ZZFLEXC_SV_API(BOOL, pagingEnabled)
ZZFLEXC_SV_API(BOOL, scrollEnabled)

ZZFLEXC_SV_API(BOOL, showsHorizontalScrollIndicator)
ZZFLEXC_SV_API(BOOL, showsVerticalScrollIndicator)

ZZFLEXC_SV_API(BOOL, scrollsToTop)

@end

ZZFLEX_EX_API(ZZScrollViewChainModel, UIScrollView)
