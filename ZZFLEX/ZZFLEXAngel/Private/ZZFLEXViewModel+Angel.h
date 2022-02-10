//
//  ZZFLEXViewModel+Angel.h
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2019/1/20.
//  Copyright © 2019 李伯坤. All rights reserved.
//

#import "ZZFLEXViewModel.h"
#import "ZZFlexibleLayoutViewProtocol.h"
#import <UIKit/UIKit.h>

@class ZZFLEXAngel;
@interface ZZFLEXViewModel (Angel)

/**
 获取实际展示大小
 */
- (CGSize)visableSizeForHostView:(__kindof UIView *)hostView angel:(ZZFLEXAngel *)angel sectionInsets:(UIEdgeInsets)sectionInsets;

/**
 执行配置方法
 */
- (void)excuteConfigActionForHostView:(__kindof UIView *)hostView itemView:(__kindof UIView<ZZFlexibleLayoutViewProtocol> *)itemView sectionCount:(NSInteger)sectionCount indexPath:(NSIndexPath *)indexPath;

/**
 执行选中方法
 */
- (void)excuteSelectedActionForHostView:(__kindof UIView *)hostView;

@end
