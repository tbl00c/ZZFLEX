//
//  ZZFlexibleLayoutViewController+Kernel.h
//  zhuanzhuan
//
//  Created by lbk on 2017/8/15.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZFlexibleLayoutViewController.h"
#import "ZZFlexibleLayoutFlowLayout.h"
#import "ZZFLEXViewModel.h"
#import "ZZFLEXSectionModel.h"

@class ZZFLEXSectionModel;
@interface ZZFlexibleLayoutViewController (Kernel) <
UICollectionViewDataSource,
UICollectionViewDelegate,
ZZFlexibleLayoutFlowLayoutDelegate
>

- (ZZFLEXSectionModel *)sectionModelAtIndex:(NSInteger)section;

/// 根据tag获取sectionModel
- (ZZFLEXSectionModel *)sectionModelForTag:(NSInteger)sectionTag;

- (ZZFLEXViewModel *)viewModelAtIndexPath:(NSIndexPath *)indexPath;

- (NSArray<ZZFLEXViewModel *> *)viewModelsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

@end
