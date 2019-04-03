//
//  ZZFDSubscriptionEditViewController.h
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2018/2/4.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "ZZFlexibleLayoutViewController+EditExtension.h"
#import "ZZFDSubscriptionModel.h"

@interface ZZFDSubscriptionEditViewController : ZZFlexibleLayoutViewController

@property (nonatomic, strong) ZZFDSubscriptionModel *subModel;
@property (nonatomic, copy) void (^completeAction)(ZZFDSubscriptionModel *subModel);

- (instancetype)initWithSubModel:(ZZFDSubscriptionModel *)subModel completeAction:(void (^)(ZZFDSubscriptionModel *subModel))completeAction;
- (instancetype)init NS_UNAVAILABLE;

@end
