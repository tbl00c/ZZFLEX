//
//  ZZSwitchChainModel.m
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZSwitchChainModel.h"
#import "UIControl+ZZEvent.h"

#define     ZZFLEXC_SWITCH_IMP(ZZParamType, methodName)      ZZFLEXC_IMP(ZZSwitchChainModel, UISwitch, ZZParamType, methodName)

#define     ZZFLEXC_BUTTON_EVENT_IMP(methodName, eventType) \
- (ZZSwitchChainModel *(^)(void (^eventBlock)(id sender)))methodName     \
{   \
    return ^ZZSwitchChainModel *(void (^eventBlock)(id sender)) {    \
        [(UIControl *)self.view addControlEvents:eventType handler:eventBlock]; \
        return self;    \
    };  \
}

@implementation ZZSwitchChainModel

+ (Class)viewClass
{
    return [UISwitch class];
}

ZZFLEXC_SWITCH_IMP(BOOL, on)

ZZFLEXC_SWITCH_IMP(UIColor *, onTintColor)
ZZFLEXC_SWITCH_IMP(UIColor *, thumbTintColor)

ZZFLEXC_SWITCH_IMP(UIImage *, onImage)
ZZFLEXC_SWITCH_IMP(UIImage *, offImage)

#pragma mark - # UIControl
ZZFLEXC_SWITCH_IMP(BOOL, enabled)
ZZFLEXC_SWITCH_IMP(BOOL, selected)
ZZFLEXC_SWITCH_IMP(BOOL, highlighted)

- (ZZSwitchChainModel *(^)(UIControlEvents controlEvents, void (^eventBlock)(id sender)))eventBlock
{
    return ^ZZSwitchChainModel *(UIControlEvents controlEvents, void (^eventBlock)(id sender)) {
        [(UIControl *)self.view addControlEvents:controlEvents handler:eventBlock];
        return self;
    };
}

ZZFLEXC_BUTTON_EVENT_IMP(eventValueChanged, UIControlEventValueChanged);

@end

ZZFLEX_EX_IMP(ZZSwitchChainModel, UISwitch)
