//
//  ZZSwitchChainModel.h
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZBaseViewChainModel.h"

#define     ZZFLEXC_SWITCH_API(ZZParamType, methodName)      ZZFLEXC_API(ZZSwitchChainModel, ZZParamType, methodName)

typedef void (^ZZChainSwitchEventBlock)(id sender);

@class ZZSwitchChainModel;
@interface ZZSwitchChainModel : ZZBaseViewChainModel<ZZSwitchChainModel *>

ZZFLEXC_SWITCH_API(BOOL, on)

ZZFLEXC_SWITCH_API(UIColor *, onTintColor)
ZZFLEXC_SWITCH_API(UIColor *, thumbTintColor)

ZZFLEXC_SWITCH_API(UIImage *, onImage)
ZZFLEXC_SWITCH_API(UIImage *, offImage)

#pragma mark - # UIControl
ZZFLEXC_SWITCH_API(BOOL, enabled)
ZZFLEXC_SWITCH_API(BOOL, selected)
ZZFLEXC_SWITCH_API(BOOL, highlighted)

ZZFLEXC_PROPERTY ZZSwitchChainModel *(^ eventBlock)(UIControlEvents controlEvents, ZZChainSwitchEventBlock eventBlock);
ZZFLEXC_SWITCH_API(ZZChainSwitchEventBlock, eventValueChanged)

@end

ZZFLEX_EX_API(ZZSwitchChainModel, UISwitch)
