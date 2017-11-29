//
//  ZZFDGoodListModel.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/11/28.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFDGoodListModel.h"

@implementation ZZFDGoodListModel

+ (void)requestHomePageDataWithOffset:(NSInteger)offset
                              success:(void (^)(NSArray *data))success
                              failure:(void (^)(NSString *errMsg))failure
{
    ZZFDGoodListModel *model1 = [[ZZFDGoodListModel alloc] init];
    model1.goodId = @"1";
    model1.goodTitle = @"苹果iPhone X，256G黑色全新";
    model1.goodFirstImage = @"https://img14.360buyimg.com/n7/jfs/t13792/147/438463234/77398/6306d199/5a0bc272N2a009210.jpg";
    
    NSMutableArray *data = @[].mutableCopy;
    for (int i = 0; i < 20; i++) {
        [data addObject:model1];
    }
    if (success) {
        success(data);
    }
}

@end
