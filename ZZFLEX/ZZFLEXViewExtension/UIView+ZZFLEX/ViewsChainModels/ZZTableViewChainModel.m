//
//  ZZTableViewChainModel.m
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZTableViewChainModel.h"

#define     ZZFLEXC_TV_IMP(ZZParamType, methodName)      ZZFLEXC_IMP(ZZTableViewChainModel, UITableView, ZZParamType, methodName)
#define     ZZFLEXC_SV_IMP(ZZParamType, methodName)      ZZFLEXC_IMP(ZZTableViewChainModel, UITableView, ZZParamType, methodName)

@implementation ZZTableViewChainModel

+ (Class)viewClass
{
    return [UITableView class];
}

ZZFLEXC_TV_IMP(id<UITableViewDelegate>, delegate)
ZZFLEXC_TV_IMP(id<UITableViewDataSource>, dataSource)

ZZFLEXC_TV_IMP(CGFloat, rowHeight)
ZZFLEXC_TV_IMP(CGFloat, sectionHeaderHeight)
ZZFLEXC_TV_IMP(CGFloat, sectionFooterHeight)
ZZFLEXC_TV_IMP(CGFloat, estimatedRowHeight)
ZZFLEXC_TV_IMP(CGFloat, estimatedSectionHeaderHeight)
ZZFLEXC_TV_IMP(CGFloat, estimatedSectionFooterHeight)
ZZFLEXC_TV_IMP(UIEdgeInsets, separatorInset)

ZZFLEXC_TV_IMP(BOOL, editing)
ZZFLEXC_TV_IMP(BOOL, allowsSelection)
ZZFLEXC_TV_IMP(BOOL, allowsMultipleSelection)
ZZFLEXC_TV_IMP(BOOL, allowsSelectionDuringEditing)
ZZFLEXC_TV_IMP(BOOL, allowsMultipleSelectionDuringEditing)

ZZFLEXC_TV_IMP(UITableViewCellSeparatorStyle, separatorStyle)
ZZFLEXC_TV_IMP(UIColor *, separatorColor)

ZZFLEXC_TV_IMP(UIView *, tableHeaderView)
ZZFLEXC_TV_IMP(UIView *, tableFooterView)

ZZFLEXC_TV_IMP(UIColor *, sectionIndexBackgroundColor)
ZZFLEXC_TV_IMP(UIColor *, sectionIndexColor)

#pragma mark - UIScrollView
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

ZZFLEX_EX_IMP(ZZTableViewChainModel, UITableView)
@implementation UITableView (ZZFLEX_EX_T)
+ (ZZTableViewChainModel *(^)(NSInteger tag, UITableViewStyle style))zz_createWithStyle
{
    return ^ZZTableViewChainModel *(NSInteger tag, UITableViewStyle style) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:style];
        return [[ZZTableViewChainModel alloc] initWithTag:tag andView:tableView];
    };
}
@end
