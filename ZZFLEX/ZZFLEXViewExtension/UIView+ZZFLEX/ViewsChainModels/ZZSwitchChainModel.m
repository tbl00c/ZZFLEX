//
//  ZZSwitchChainModel.m
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZSwitchChainModel.h"
#import "UIControl+ZZEvent.h"

#define     ZZFLEX_CHAIN_SWITCH_IMPLEMENTATION(methodName, ZZParamType)      ZZFLEX_CHAIN_IMPLEMENTATION(methodName, ZZParamType, ZZSwitchChainModel *, UISwitch)

#define     ZZFLEX_CHAIN_SWITCH_EVENT_IMPLEMENTATION(methodName, eventType) \
- (ZZSwitchChainModel *(^)(void (^eventBlock)(id sender)))methodName     \
{   \
    return ^ZZSwitchChainModel *(void (^eventBlock)(id sender)) {    \
        [(UIControl *)self.view addControlEvents:eventType handler:eventBlock]; \
        return self;    \
    };  \
}

@implementation ZZSwitchChainModel

ZZFLEX_CHAIN_SWITCH_IMPLEMENTATION(on, BOOL);
ZZFLEX_CHAIN_SWITCH_IMPLEMENTATION(onTintColor, UIColor *);
ZZFLEX_CHAIN_SWITCH_IMPLEMENTATION(thumbTintColor, UIColor *);

ZZFLEX_CHAIN_SWITCH_IMPLEMENTATION(onImage, UIImage *);
ZZFLEX_CHAIN_SWITCH_IMPLEMENTATION(offImage, UIImage *);

#pragma mark - # UIControl
ZZFLEX_CHAIN_SWITCH_IMPLEMENTATION(enabled, BOOL);
ZZFLEX_CHAIN_SWITCH_IMPLEMENTATION(selected, BOOL);
ZZFLEX_CHAIN_SWITCH_IMPLEMENTATION(highlighted, BOOL);

- (ZZSwitchChainModel *(^)(UIControlEvents controlEvents, void (^eventBlock)(id sender)))eventBlock
{
    return ^ZZSwitchChainModel *(UIControlEvents controlEvents, void (^eventBlock)(id sender)) {
        [(UIControl *)self.view addControlEvents:controlEvents handler:eventBlock];
        return self;
    };
}

ZZFLEX_CHAIN_SWITCH_EVENT_IMPLEMENTATION(eventValueChanged, UIControlEventValueChanged)

@end

ZZFLEX_EX_IMPLEMENTATION(UISwitch, ZZSwitchChainModel)
