//
//  ZZFDSubscriptionModel+Request.h
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2018/2/5.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "ZZFDSubscriptionModel.h"

@interface ZZFDSubscriptionModel (Request)

+ (void)requestSubListSuccess:(void (^)(NSArray<ZZFDSubscriptionModel *> *data))success
                      failure:(void (^)(NSString *errMsg))failure;

@end
