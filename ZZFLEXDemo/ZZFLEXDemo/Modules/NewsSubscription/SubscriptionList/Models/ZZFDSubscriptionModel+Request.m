//
//  ZZFDSubscriptionModel+Request.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2018/2/5.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "ZZFDSubscriptionModel+Request.h"

@implementation ZZFDSubscriptionModel (Request)

static NSMutableArray *__sub_list_data;
+ (void)requestSubListSuccess:(void (^)(NSArray<ZZFDSubscriptionModel *> *data))success
                      failure:(void (^)(NSString *errMsg))failure
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sub_list_data = [[NSMutableArray alloc] init];
        {
            ZZFDSubscriptionModel *model = [[ZZFDSubscriptionModel alloc] init];
            model.subId = @([[NSDate date] timeIntervalSince1970]).stringValue;
            model.platform = ZZFDSubscriptionPlatformIOS;
            model.language = @"Objective-C";
            model.cate = @[@"标签", @"选择器"];
            model.keyword = @"数据驱动、链式API";
            model.maxLevel = @"10";
            model.minLevel = @"5";
            model.noti = YES;
            [__sub_list_data addObject:model];
        }
        {
            ZZFDSubscriptionModel *model = [[ZZFDSubscriptionModel alloc] init];
            model.subId = @([[NSDate date] timeIntervalSince1970]).stringValue;
            model.platform = ZZFDSubscriptionPlatformServer;
            model.language = @"全部";
            model.cate = @[@"分布式"];
            model.keyword = @"Hadoop、docker";
            model.maxLevel = @"10";
            [__sub_list_data addObject:model];
        }
    });
    if (success) {
        success(__sub_list_data);
    }
}

@end
