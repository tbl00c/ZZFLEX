//
//  ZZFDRQRequest.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2018/1/24.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "ZZFDRQRequest.h"

@implementation ZZFDRQRequest

+ (void)requestWithType:(NSInteger)type success:(void (^)(id data))success failure:(void (^)(id errMsg))failure
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        CGFloat t = (arc4random() % 300) / 100.0f;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(t * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (arc4random() % 3 == 2) {
                if (failure) {
                    failure([NSString stringWithFormat:@"接口%ld请求失败，请点击重试", type]);
                }
            }
            else {
                if (success) {
                    CGFloat r = arc4random() % 256 / 256.0f;
                    CGFloat g = arc4random() % 256 / 256.0f;
                    CGFloat b = arc4random() % 256 / 256.0f;
                    UIColor *color = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
                    success(color);
                }
            }
        });
    });
}

@end
