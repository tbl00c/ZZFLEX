//
//  ZZCollectionViewChainModel.h
//  zhuanzhuan
//
//  Created by 李伯坤 on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZViewChainModel.h"
#import "ZZScrollViewChainModel.h"

@interface _ZZTableViewChainModel<ObjcType> : _ZZScrollViewChainModel <ObjcType>

ZZFLEXC_API(id<UITableViewDelegate>, delegate)
ZZFLEXC_API(id<UITableViewDataSource>, dataSource)

ZZFLEXC_API(CGFloat, rowHeight)
ZZFLEXC_API(CGFloat, sectionHeaderHeight)
ZZFLEXC_API(CGFloat, sectionFooterHeight)
ZZFLEXC_API(CGFloat, estimatedRowHeight)
ZZFLEXC_API(CGFloat, estimatedSectionHeaderHeight)
ZZFLEXC_API(CGFloat, estimatedSectionFooterHeight)
ZZFLEXC_API(UIEdgeInsets, separatorInset)

ZZFLEXC_API(BOOL, editing)
ZZFLEXC_API(BOOL, allowsSelection)
ZZFLEXC_API(BOOL, allowsMultipleSelection)
ZZFLEXC_API(BOOL, allowsSelectionDuringEditing)
ZZFLEXC_API(BOOL, allowsMultipleSelectionDuringEditing)

ZZFLEXC_API(UITableViewCellSeparatorStyle, separatorStyle)
ZZFLEXC_API(UIColor *, separatorColor)

ZZFLEXC_API(UIView *, tableHeaderView)
ZZFLEXC_API(UIView *, tableFooterView)

ZZFLEXC_API(UIColor *, sectionIndexBackgroundColor)
ZZFLEXC_API(UIColor *, sectionIndexColor)

@end

ZZFLEX_EX_API(ZZTableViewChainModel, UITableView)
@interface UITableView (ZZFLEX_EX_T)
+ (ZZTableViewChainModel *(^)(NSInteger tag, UITableViewStyle style))zz_createWithStyle;
@end
