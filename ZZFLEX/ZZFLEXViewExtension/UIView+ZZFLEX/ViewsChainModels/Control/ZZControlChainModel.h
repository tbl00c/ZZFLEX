//
//  ZZControlChainModel.h
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZViewChainModel.h"

typedef void (^ZZChainControlEventBlock)(__kindof UIControl *sender);

@interface _ZZControlChainModel<ObjcType> : _ZZViewChainModel<ObjcType>

ZZFLEXC_API(BOOL, enabled)
ZZFLEXC_API(BOOL, selected)
ZZFLEXC_API(BOOL, highlighted)

ZZFLEXC_PROPERTY ObjcType (^ eventBlock)(UIControlEvents controlEvents, ZZChainControlEventBlock eventBlock);
ZZFLEXC_API(ZZChainControlEventBlock, eventTouchDown)
ZZFLEXC_API(ZZChainControlEventBlock, eventTouchDownRepeat)
ZZFLEXC_API(ZZChainControlEventBlock, eventTouchUpInside)
ZZFLEXC_API(ZZChainControlEventBlock, eventTouchUpOutside)
ZZFLEXC_API(ZZChainControlEventBlock, eventTouchCancel)

ZZFLEXC_API(ZZChainControlEventBlock, eventValueChanged)

ZZFLEXC_API(ZZChainControlEventBlock, eventEditingDidBegin)
ZZFLEXC_API(ZZChainControlEventBlock, eventEditingChanged)
ZZFLEXC_API(ZZChainControlEventBlock, eventEditingDidEnd)
ZZFLEXC_API(ZZChainControlEventBlock, eventEditingDidEndEditingDidEndOnExit)

ZZFLEXC_API(UIControlContentVerticalAlignment, contentVerticalAlignment)
ZZFLEXC_API(UIControlContentHorizontalAlignment, contentHorizontalAlignment)

@end

ZZFLEX_EX_API(ZZControlChainModel, UIControl)
