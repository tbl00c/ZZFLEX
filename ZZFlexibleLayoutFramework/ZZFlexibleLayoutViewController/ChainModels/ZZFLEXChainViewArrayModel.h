//
//  ZZFLEXChainViewArrayModel.h
//  zhuanzhuan
//
//  Created by 李伯坤 on 2017/8/15.
//  Copyright © 2017年 转转. All rights reserved.
//

/**
 *  向section中批量添加cells
 */

#import <Foundation/Foundation.h>

@interface ZZFLEXChainViewArrayModel : NSObject

/// 将cells添加到某个section
- (ZZFLEXChainViewArrayModel *(^)(NSInteger section))toSection;

/// cells的数据源
- (ZZFLEXChainViewArrayModel *(^)(NSArray *dataModelArray))withDataModelArray;

/// cells内部事件deledate，与blcok二选一即可
- (ZZFLEXChainViewArrayModel *(^)(id delegate))delegate;
/// cells内部事件block，与deledate二选一即可
- (ZZFLEXChainViewArrayModel *(^)(id ((^)(NSInteger actionType, id data))))eventAction;

/// cells selected事件
- (ZZFLEXChainViewArrayModel *(^)(void ((^)(id data))))selectedAction;

/// cells tag
- (ZZFLEXChainViewArrayModel *(^)(NSInteger viewTag))viewTag;

#pragma mark - 框架内部使用
- (id)initWithClassName:(NSString *)className listData:(NSMutableArray *)listData;

@end
