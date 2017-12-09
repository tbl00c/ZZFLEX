//
//  ZZFLEXChainViewModel.h
//  zhuanzhuan
//
//  Created by 李伯坤 on 2017/8/15.
//  Copyright © 2017年 转转. All rights reserved.
//

/**
 *  向section中添加视图(cell/header/footer)
 */

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ZZFLEXChainViewType) {
    ZZFLEXChainViewTypeCell,
    ZZFLEXChainViewTypeHeader,
    ZZFLEXChainViewTypeFooter,
};

@class ZZFlexibleLayoutViewModel;
@interface ZZFLEXChainViewModel : NSObject

/// 将cell添加到某个section
- (ZZFLEXChainViewModel *(^)(NSInteger section))toSection;

/// cell的数据源
- (ZZFLEXChainViewModel *(^)(id dataModel))withDataModel;

/// cell内部事件deledate，与blcok二选一即可
- (ZZFLEXChainViewModel *(^)(id delegate))delegate;
/// cell内部事件block，与deledate二选一即可
- (ZZFLEXChainViewModel *(^)(id ((^)(NSInteger actionType, id data))))eventAction;

/// cell selected事件
- (ZZFLEXChainViewModel *(^)(void ((^)(id data))))selectedAction;

/// cell tag
- (ZZFLEXChainViewModel *(^)(NSInteger viewTag))viewTag;

#pragma mark - 框架内部使用
@property (nonatomic, assign, readonly) ZZFLEXChainViewType type;
- (id)initWithListData:(NSMutableArray *)listData viewModel:(ZZFlexibleLayoutViewModel *)viewModel andType:(ZZFLEXChainViewType)type;

@end
