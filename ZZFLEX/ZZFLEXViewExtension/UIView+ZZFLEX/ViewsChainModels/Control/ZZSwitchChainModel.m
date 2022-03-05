//
//  ZZSwitchChainModel.m
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZSwitchChainModel.h"
#import "UIControl+ZZEvent.h"

#define     ZZFLEXC_IMP_VIEW_TYPE   UISwitch

@implementation _ZZSwitchChainModel

+ (Class)viewClass {
    return [UISwitch class];
}

ZZFLEXC_IMP(BOOL, on)

ZZFLEXC_IMP(UIColor *, onTintColor)
ZZFLEXC_IMP(UIColor *, thumbTintColor)

ZZFLEXC_IMP(UIImage *, onImage)
ZZFLEXC_IMP(UIImage *, offImage)

@end

ZZFLEX_EX_IMP(ZZSwitchChainModel)
