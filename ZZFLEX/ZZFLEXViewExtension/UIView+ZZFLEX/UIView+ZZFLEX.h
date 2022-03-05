//
//  UIView+ZZFLEX.h
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZZViewChainModel.h"
#import "ZZLabelChainModel.h"
#import "ZZImageViewChainModel.h"
#import "ZZActivityIndicatorViewChainModel.h"
#import "ZZProgressViewChainModel.h"

#import "ZZControlChainModel.h"
#import "ZZTextFieldChainModel.h"
#import "ZZButtonChainModel.h"
#import "ZZSwitchChainModel.h"

#import "ZZScrollViewChainModel.h"
#import "ZZTextViewChainModel.h"
#import "ZZTableViewChainModel.h"
#import "ZZCollectionViewChainModel.h"

#define     ZZFLEX_VIEW_CHAIN_PROPERTY                           @property (nonatomic, copy, readonly)
#define     ZZFLEX_VIEW_CHAIN_API(ZZChainType, methodName)       ZZFLEX_VIEW_CHAIN_PROPERTY ZZChainType *(^ methodName)(NSInteger tag)

@interface UIView (ZZFLEX)

/// 添加View
ZZFLEX_VIEW_CHAIN_API(ZZViewChainModel, addView);
/// 添加Label
ZZFLEX_VIEW_CHAIN_API(ZZLabelChainModel, addLabel);
/// 添加ImageView
ZZFLEX_VIEW_CHAIN_API(ZZImageViewChainModel, addImageView);
/// 添加activityIndicatorView
ZZFLEX_VIEW_CHAIN_API(ZZActivityIndicatorViewChainModel, addActivityIndicatorView);
/// 添加progressView
ZZFLEX_VIEW_CHAIN_API(ZZProgressViewChainModel, addProgressView);

#pragma mark - # 按钮类
/// 添加Control
ZZFLEX_VIEW_CHAIN_API(ZZControlChainModel, addControl);
/// 添加TextField
ZZFLEX_VIEW_CHAIN_API(ZZTextFieldChainModel, addTextField);
/// 添加Button
ZZFLEX_VIEW_CHAIN_API(ZZButtonChainModel, addButton);
/// 添加Switch
ZZFLEX_VIEW_CHAIN_API(ZZSwitchChainModel, addSwitch);

#pragma mark - # 滚动视图类
/// 添加ScrollView
ZZFLEX_VIEW_CHAIN_API(ZZScrollViewChainModel, addScrollView);
/// 添加TextView
ZZFLEX_VIEW_CHAIN_API(ZZTextViewChainModel, addTextView);
/// 添加TableView
ZZFLEX_VIEW_CHAIN_API(ZZTableViewChainModel, addTableView);
ZZFLEX_VIEW_CHAIN_PROPERTY ZZTableViewChainModel *(^ addTableViewWithStyle)(NSInteger tag, UITableViewStyle style);
/// 添加CollectionView
ZZFLEX_VIEW_CHAIN_API(ZZCollectionViewChainModel, addCollectionView);

@end
