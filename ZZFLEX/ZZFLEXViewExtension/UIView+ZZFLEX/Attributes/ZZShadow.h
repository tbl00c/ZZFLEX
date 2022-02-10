//
//  ZZShadow.h
//  WCUIKit
//
//  Created by libokun on 2021/5/18.
//  Copyright © 2021 WeChat. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define ZZShadow ZZShadowChainModel.create

@class ZZShadowModel;
@interface ZZShadowChainModel : NSObject

+ (instancetype)create;

/// 偏移量
- (ZZShadowChainModel * (^)(CGSize offset))offset;
/// 颜色
- (ZZShadowChainModel * (^)(UIColor *color))color;
/// 圆角
- (ZZShadowChainModel * (^)(CGFloat radius))radius;
/// 不透明度
- (ZZShadowChainModel * (^)(CGFloat opacity))opacity;

@property (nonatomic, strong, readonly) ZZShadowModel *object;

@end

@interface ZZShadowModel : NSObject

@property (nonatomic, assign) CGSize offset;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGFloat opacity;

@end

NS_ASSUME_NONNULL_END
