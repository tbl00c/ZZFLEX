//
//  ZZFDPlatformSelectViewController.h
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2018/2/5.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "ZZFlexibleLayoutViewController.h"
#import "ZZFDPlatformItemModel.h"
#import "ZZFDSubscriptionModel.h"

@interface ZZFDPlatformSelectViewController : ZZFlexibleLayoutViewController

- (instancetype)initWithSelectPlatform:(ZZFDSubscriptionPlatform)platform selectedAction:(void (^)(ZZFDSubscriptionPlatform platform))selectedAction;

@end
