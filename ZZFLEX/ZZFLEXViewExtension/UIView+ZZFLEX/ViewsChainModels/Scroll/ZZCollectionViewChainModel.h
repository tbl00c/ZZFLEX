//
//  ZZCollectionViewChainModel.h
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZScrollViewChainModel.h"

@interface _ZZCollectionViewChainModel<ObjcType> : _ZZScrollViewChainModel<ObjcType>

ZZFLEXC_API(UICollectionViewLayout *, collectionViewLayout)
ZZFLEXC_API(id<UICollectionViewDelegate>, delegate)
ZZFLEXC_API(id<UICollectionViewDataSource>, dataSource)

ZZFLEXC_API(BOOL, allowsSelection)
ZZFLEXC_API(BOOL, allowsMultipleSelection)

@end

ZZFLEX_EX_API(ZZCollectionViewChainModel, UICollectionView)
