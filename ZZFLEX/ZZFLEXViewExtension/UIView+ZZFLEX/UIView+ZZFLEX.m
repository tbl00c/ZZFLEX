//
//  UIView+ZZFLEX.m
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "UIView+ZZFLEX.h"

#define ZZFLEX_VIEW_CHAIN_IMP(ZZChainModelClass, methodName) \
- (ZZChainModelClass * (^)(NSInteger tag))methodName    \
{   \
    return ^ZZChainModelClass* (NSInteger tag) {      \
        UIView *view = [ZZChainModelClass viewClass].zz_create(tag).view;    \
        [self addSubview:view];     \
        ZZChainModelClass *chainModel = [[ZZChainModelClass alloc] initWithTag:tag andView:view]; \
        return chainModel;      \
    };      \
}

@implementation UIView (ZZFLEX)

ZZFLEX_VIEW_CHAIN_IMP(ZZViewChainModel, addView);
ZZFLEX_VIEW_CHAIN_IMP(ZZLabelChainModel, addLabel);
ZZFLEX_VIEW_CHAIN_IMP(ZZImageViewChainModel, addImageView);
ZZFLEX_VIEW_CHAIN_IMP(ZZActivityIndicatorViewChainModel, addActivityIndicatorView);
ZZFLEX_VIEW_CHAIN_IMP(ZZProgressViewChainModel, addProgressView);

#pragma mark - # 按钮类
ZZFLEX_VIEW_CHAIN_IMP(ZZControlChainModel, addControl);
ZZFLEX_VIEW_CHAIN_IMP(ZZTextFieldChainModel, addTextField);
ZZFLEX_VIEW_CHAIN_IMP(ZZButtonChainModel, addButton);
ZZFLEX_VIEW_CHAIN_IMP(ZZSwitchChainModel, addSwitch);

#pragma mark - # 滚动视图类
ZZFLEX_VIEW_CHAIN_IMP(ZZScrollViewChainModel, addScrollView);
ZZFLEX_VIEW_CHAIN_IMP(ZZTextViewChainModel, addTextView);
ZZFLEX_VIEW_CHAIN_IMP(ZZTableViewChainModel, addTableView);
- (ZZTableViewChainModel * (^)(NSInteger tag, UITableViewStyle style))addTableViewWithStyle
{
    return ^ZZTableViewChainModel* (NSInteger tag, UITableViewStyle style) {
        UITableView *view = [[[ZZTableViewChainModel viewClass] alloc] initWithFrame:CGRectZero style:style];
        [self addSubview:view];
        ZZTableViewChainModel *chainModel = [[ZZTableViewChainModel alloc] initWithTag:tag andView:view];
        return chainModel;
    };
}
ZZFLEX_VIEW_CHAIN_IMP(ZZCollectionViewChainModel, addCollectionView);

@end
