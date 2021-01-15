//
//  ZZControlChainModel.h
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZBaseViewChainModel.h"

#define     ZZFLEXC_CONTROL_API(ZZParamType, methodName)      ZZFLEXC_API(ZZControlChainModel, ZZParamType, methodName)

@class ZZControlChainModel;
@interface ZZControlChainModel : ZZBaseViewChainModel<ZZControlChainModel *>

ZZFLEXC_CONTROL_API(BOOL, enabled)
ZZFLEXC_CONTROL_API(BOOL, selected)
ZZFLEXC_CONTROL_API(BOOL, highlighted)

ZZFLEXC_PROPERTY ZZControlChainModel *(^ eventBlock)(UIControlEvents controlEvents, void (^eventBlock)(id sender));

ZZFLEXC_CONTROL_API(UIControlContentVerticalAlignment, contentVerticalAlignment)
ZZFLEXC_CONTROL_API(UIControlContentHorizontalAlignment, contentHorizontalAlignment)

@end

ZZFLEX_EX_API(ZZControlChainModel, UIControl)
