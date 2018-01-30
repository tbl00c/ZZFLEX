//
//  ZZFDRQRequest.h
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2018/1/24.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZFDRQRequest : NSObject

+ (void)requestWithType:(NSInteger)type
                success:(void (^)(id data))success
                failure:(void (^)(id errMsg))failure;

@end
