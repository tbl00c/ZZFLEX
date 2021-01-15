//
//  ZZCollectionViewChainModel.h
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZBaseViewChainModel.h"

#define     ZZFLEXC_CV_API(ZZParamType, methodName)      ZZFLEXC_API(ZZCollectionViewChainModel, ZZParamType, methodName)

@class ZZCollectionViewChainModel;
@interface ZZCollectionViewChainModel : ZZBaseViewChainModel<ZZCollectionViewChainModel *>

ZZFLEXC_CV_API(UICollectionViewLayout *, collectionViewLayout)
ZZFLEXC_CV_API(id<UICollectionViewDelegate>, delegate)
ZZFLEXC_CV_API(id<UICollectionViewDataSource>, dataSource)

ZZFLEXC_CV_API(BOOL, allowsSelection)
ZZFLEXC_CV_API(BOOL, allowsMultipleSelection)

#pragma mark - UIScrollView
ZZFLEXC_CV_API(CGSize, contentSize)
ZZFLEXC_CV_API(CGPoint, contentOffset)
ZZFLEXC_CV_API(UIEdgeInsets, contentInset)

ZZFLEXC_CV_API(BOOL, bounces)
ZZFLEXC_CV_API(BOOL, alwaysBounceVertical)
ZZFLEXC_CV_API(BOOL, alwaysBounceHorizontal)

ZZFLEXC_CV_API(BOOL, pagingEnabled)
ZZFLEXC_CV_API(BOOL, scrollEnabled)

ZZFLEXC_CV_API(BOOL, showsHorizontalScrollIndicator)
ZZFLEXC_CV_API(BOOL, showsVerticalScrollIndicator)

ZZFLEXC_CV_API(BOOL, scrollsToTop)

@end

ZZFLEX_EX_API(ZZCollectionViewChainModel, UICollectionView)
