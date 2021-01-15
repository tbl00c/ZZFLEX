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

ZZFLEX_VIEW_CHAIN_API(ZZViewChainModel, addView);
ZZFLEX_VIEW_CHAIN_API(ZZLabelChainModel, addLabel);
ZZFLEX_VIEW_CHAIN_API(ZZImageViewChainModel, addImageView);
ZZFLEX_VIEW_CHAIN_API(ZZActivityIndicatorViewChainModel, addActivityIndicatorView);
ZZFLEX_VIEW_CHAIN_API(ZZProgressViewChainModel, addProgressView);

#pragma mark - # 按钮类
ZZFLEX_VIEW_CHAIN_API(ZZControlChainModel, addControl);
ZZFLEX_VIEW_CHAIN_API(ZZTextFieldChainModel, addTextField);
ZZFLEX_VIEW_CHAIN_API(ZZButtonChainModel, addButton);
ZZFLEX_VIEW_CHAIN_API(ZZSwitchChainModel, addSwitch);

#pragma mark - # 滚动视图类
ZZFLEX_VIEW_CHAIN_API(ZZScrollViewChainModel, addScrollView);
ZZFLEX_VIEW_CHAIN_API(ZZTextViewChainModel, addTextView);
ZZFLEX_VIEW_CHAIN_API(ZZTableViewChainModel, addTableView);
ZZFLEX_VIEW_CHAIN_PROPERTY ZZTableViewChainModel *(^ addTableViewWithStyle)(NSInteger tag, UITableViewStyle style);
ZZFLEX_VIEW_CHAIN_API(ZZCollectionViewChainModel, addCollectionView);

@end
