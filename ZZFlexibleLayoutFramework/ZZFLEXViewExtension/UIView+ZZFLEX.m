//
//  UIView+ZZFLEX.m
//  zhuanzhuan
//
//  Created by 李伯坤 on 2017/10/24.
//  Copyright © 2017年 转转. All rights reserved.
//

#import "UIView+ZZFLEX.h"

#define ZZFLEX_VE_API(methodName, ZZChainModelClass, UIViewClass) \
- (ZZChainModelClass * (^)(NSInteger tag))methodName    \
{   \
    return ^ZZChainModelClass* (NSInteger tag) {      \
        UIViewClass *view = [[UIViewClass alloc] init];       \
        [self addSubview:view];                            \
        ZZChainModelClass *chainModel = [[ZZChainModelClass alloc] initWithTag:tag andView:view]; \
        return chainModel;      \
    };      \
}

@implementation UIView (ZZFLEX)

ZZFLEX_VE_API(addView, ZZCustomViewChainModel, UIView);
ZZFLEX_VE_API(addLabel, ZZLabelChainModel, UILabel);
ZZFLEX_VE_API(addImageView, ZZImageViewChainModel, UIImageView);

#pragma mark - # 按钮类
ZZFLEX_VE_API(addControl, ZZControlChainModel, UIControl);
ZZFLEX_VE_API(addButton, ZZButtonChainModel, UIButton);
ZZFLEX_VE_API(addSwitch, ZZSwitchChainModel, UISwitch);

#pragma mark - # 滚动视图类
ZZFLEX_VE_API(addScrollView, ZZScrollViewChainModel, UIScrollView);
ZZFLEX_VE_API(addTableView, ZZTableViewChainModel, UITableView);
ZZFLEX_VE_API(addCollectionView, ZZCollectionViewChainModel, UICollectionView);

@end
