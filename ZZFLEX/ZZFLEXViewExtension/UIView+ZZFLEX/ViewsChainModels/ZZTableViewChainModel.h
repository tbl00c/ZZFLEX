//
//  ZZCollectionViewChainModel.h
//  zhuanzhuan
//
//  Created by 李伯坤 on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZBaseViewChainModel.h"

#define     ZZFLEXC_TV_API(ZZParamType, methodName)      ZZFLEXC_API(ZZTableViewChainModel, ZZParamType, methodName)

@class ZZTableViewChainModel;
@interface ZZTableViewChainModel : ZZBaseViewChainModel<ZZTableViewChainModel *>

ZZFLEXC_TV_API(id<UITableViewDelegate>, delegate)
ZZFLEXC_TV_API(id<UITableViewDataSource>, dataSource)

ZZFLEXC_TV_API(CGFloat, rowHeight)
ZZFLEXC_TV_API(CGFloat, sectionHeaderHeight)
ZZFLEXC_TV_API(CGFloat, sectionFooterHeight)
ZZFLEXC_TV_API(CGFloat, estimatedRowHeight)
ZZFLEXC_TV_API(CGFloat, estimatedSectionHeaderHeight)
ZZFLEXC_TV_API(CGFloat, estimatedSectionFooterHeight)
ZZFLEXC_TV_API(UIEdgeInsets, separatorInset)

ZZFLEXC_TV_API(BOOL, editing)
ZZFLEXC_TV_API(BOOL, allowsSelection)
ZZFLEXC_TV_API(BOOL, allowsMultipleSelection)
ZZFLEXC_TV_API(BOOL, allowsSelectionDuringEditing)
ZZFLEXC_TV_API(BOOL, allowsMultipleSelectionDuringEditing)

ZZFLEXC_TV_API(UITableViewCellSeparatorStyle, separatorStyle)
ZZFLEXC_TV_API(UIColor *, separatorColor)

ZZFLEXC_TV_API(UIView *, tableHeaderView)
ZZFLEXC_TV_API(UIView *, tableFooterView)

ZZFLEXC_TV_API(UIColor *, sectionIndexBackgroundColor)
ZZFLEXC_TV_API(UIColor *, sectionIndexColor)

#pragma mark - UIScrollView
ZZFLEXC_TV_API(CGSize, contentSize)
ZZFLEXC_TV_API(CGPoint, contentOffset)
ZZFLEXC_TV_API(UIEdgeInsets, contentInset)

ZZFLEXC_TV_API(BOOL, bounces)
ZZFLEXC_TV_API(BOOL, alwaysBounceVertical)
ZZFLEXC_TV_API(BOOL, alwaysBounceHorizontal)

ZZFLEXC_TV_API(BOOL, pagingEnabled)
ZZFLEXC_TV_API(BOOL, scrollEnabled)

ZZFLEXC_TV_API(BOOL, showsHorizontalScrollIndicator)
ZZFLEXC_TV_API(BOOL, showsVerticalScrollIndicator)

ZZFLEXC_TV_API(BOOL, scrollsToTop)

@end

ZZFLEX_EX_API(ZZTableViewChainModel, UITableView)
@interface UITableView (ZZFLEX_EX_T)
+ (ZZTableViewChainModel *(^)(NSInteger tag, UITableViewStyle style))zz_createWithStyle;
@end
