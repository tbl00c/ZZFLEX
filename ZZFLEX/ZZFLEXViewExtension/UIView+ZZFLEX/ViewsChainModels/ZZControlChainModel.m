//
//  ZZControlChainModel.m
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZControlChainModel.h"
#import "UIControl+ZZEvent.h"

#define     ZZFLEXC_CONTROL_IMP(ZZParamType, methodName)      ZZFLEXC_IMP(ZZControlChainModel, UIControl, ZZParamType, methodName)

@implementation ZZControlChainModel

+ (Class)viewClass
{
    return [UIControl class];
}

ZZFLEXC_CONTROL_IMP(BOOL, enabled)
ZZFLEXC_CONTROL_IMP(BOOL, selected)
ZZFLEXC_CONTROL_IMP(BOOL, highlighted)

- (ZZControlChainModel *(^)(UIControlEvents controlEvents, void (^eventBlock)(id sender)))eventBlock
{
    return ^ZZControlChainModel *(UIControlEvents controlEvents, void (^eventBlock)(id sender)) {
        [(UIControl *)self.view addControlEvents:controlEvents handler:eventBlock];
        return self;
    };
}

ZZFLEXC_CONTROL_IMP(UIControlContentVerticalAlignment, contentVerticalAlignment)
ZZFLEXC_CONTROL_IMP(UIControlContentHorizontalAlignment, contentHorizontalAlignment)
@end

ZZFLEX_EX_IMP(ZZControlChainModel, UIControl)
