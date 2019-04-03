//
//  ZZFDSubscriptionAngel.h
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2018/2/7.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "ZZFLEXAngel.h"

typedef NS_ENUM(NSInteger, ZZFDBillListVCSectionType) {
    ZZFDBillListVCSectionTypeAdd = 1,
    ZZFDBillListVCSectionTypeItems,
};

@interface ZZFDSubscriptionAngel : ZZFLEXAngel

- (instancetype)initWithHostView:(__kindof UIScrollView *)hostView pushAction:(void (^)(__kindof UIViewController *vc))pushAction;

- (void)requestData;

@end
