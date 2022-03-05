//
//  ZZTableViewChainModel.m
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZTableViewChainModel.h"

#define     ZZFLEXC_IMP_VIEW_TYPE   UITableView

@implementation _ZZTableViewChainModel

+ (Class)viewClass {
    return [UITableView class];
}

ZZFLEXC_IMP(id<UITableViewDelegate>, delegate)
ZZFLEXC_IMP(id<UITableViewDataSource>, dataSource)

ZZFLEXC_IMP(CGFloat, rowHeight)
ZZFLEXC_IMP(CGFloat, sectionHeaderHeight)
ZZFLEXC_IMP(CGFloat, sectionFooterHeight)
ZZFLEXC_IMP(CGFloat, estimatedRowHeight)
ZZFLEXC_IMP(CGFloat, estimatedSectionHeaderHeight)
ZZFLEXC_IMP(CGFloat, estimatedSectionFooterHeight)
ZZFLEXC_IMP(UIEdgeInsets, separatorInset)

ZZFLEXC_IMP(BOOL, editing)
ZZFLEXC_IMP(BOOL, allowsSelection)
ZZFLEXC_IMP(BOOL, allowsMultipleSelection)
ZZFLEXC_IMP(BOOL, allowsSelectionDuringEditing)
ZZFLEXC_IMP(BOOL, allowsMultipleSelectionDuringEditing)

ZZFLEXC_IMP(UITableViewCellSeparatorStyle, separatorStyle)
ZZFLEXC_IMP(UIColor *, separatorColor)

ZZFLEXC_IMP(UIView *, tableHeaderView)
ZZFLEXC_IMP(UIView *, tableFooterView)

ZZFLEXC_IMP(UIColor *, sectionIndexBackgroundColor)
ZZFLEXC_IMP(UIColor *, sectionIndexColor)

@end

ZZFLEX_EX_IMP(ZZTableViewChainModel)
@implementation UITableView (ZZFLEX_EX_T)
+ (ZZTableViewChainModel *(^)(NSInteger tag, UITableViewStyle style))zz_createWithStyle {
    return ^ZZTableViewChainModel *(NSInteger tag, UITableViewStyle style) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:style];
        return [[ZZTableViewChainModel alloc] initWithTag:tag andView:tableView];
    };
}
@end
