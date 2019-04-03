//
//  ZZFDSubscriptionModel.h
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2018/2/4.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ZZFDSubscriptionPlatform) {
    ZZFDSubscriptionPlatformIOS = 1,
    ZZFDSubscriptionPlatformAndroid,
    ZZFDSubscriptionPlatformWeb,
    ZZFDSubscriptionPlatformServer,
};

@class ZZFDSubscriptionListShowModel;
@interface ZZFDSubscriptionModel : NSObject <NSMutableCopying>

@property (nonatomic, strong) NSString *subId;

/// 平台
@property (nonatomic, assign) ZZFDSubscriptionPlatform platform;
@property (nonatomic, strong, readonly) NSString *platformName;

/// 语言
@property (nonatomic, strong) NSString *language;
@property (nonatomic, strong, readonly) NSArray *languageArray;

/// 分类
@property (nonatomic, strong) NSArray *cate;
@property (nonatomic, strong, readonly) NSString *cateString;
@property (nonatomic, strong, readonly) NSArray *cateArray;

/// 关键词
@property (nonatomic, strong) NSString *keyword;

@property (nonatomic, strong) NSString *minLevel;
@property (nonatomic, strong) NSString *maxLevel;

/// 通知
@property (nonatomic, assign) BOOL noti;

@property (nonatomic, strong, readonly) NSArray<ZZFDSubscriptionListShowModel *> *listShowModelArray;


+ (NSString *)getPlatformNameByType:(ZZFDSubscriptionPlatform)type;

@end

@interface ZZFDSubscriptionListShowModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *detail;

@end

