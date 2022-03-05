//
//  ZZBorder.h
//  WCUIKit
//
//  Created by libokun on 2021/5/18.
//  Copyright © 2021 WeChat. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define ZZBorder ZZBorderChainModel.create

@class ZZBorderModel;
@interface ZZBorderChainModel : NSObject

+ (instancetype)create;

/// 线宽
- (ZZBorderChainModel * (^)(CGFloat width))width;
/// 颜色
- (ZZBorderChainModel * (^)(UIColor *color))color;
/// 圆角
- (ZZBorderChainModel * (^)(CGFloat radius))radius;

@property (nonatomic, strong, readonly) ZZBorderModel *object;

@end

@interface ZZBorderModel : NSObject

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) CGFloat radius;
@end

NS_ASSUME_NONNULL_END
