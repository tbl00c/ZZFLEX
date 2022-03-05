//
//  ZZFLEXAngelIndexPathChainModel.h
//  WCUIKit
//
//  Created by libokun on 2021/11/30.
//  Copyright © 2021 WeChat. All rights reserved.
//

#import <objc/NSObject.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZZFLEXAngelIndexPathChainModel : NSObject

/// 根据cellTag
- (nullable NSIndexPath * (^)(NSInteger viewTag))byViewTag;

/// 根据sectionTag和cellTag
- (nullable NSIndexPath * (^)(NSInteger sectionTag, NSInteger viewTag))bySectionTagAndViewTag;

/// 根据数据源
- (nullable NSIndexPath * (^)(id dataModel))byDataModel;

/// 根据sectionTag和数据源
- (nullable NSIndexPath * (^)(NSInteger sectionTag, id dataModel))bySectionTagAndDataModel;

/// 框架内部使用
- (instancetype)initWithListData:(NSArray *)listData;

@end

NS_ASSUME_NONNULL_END
