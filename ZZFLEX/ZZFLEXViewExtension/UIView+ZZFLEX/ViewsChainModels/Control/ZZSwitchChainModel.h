//
//  ZZSwitchChainModel.h
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZControlChainModel.h"

@interface _ZZSwitchChainModel<ObjcType> : _ZZControlChainModel<ObjcType>

ZZFLEXC_API(BOOL, on)

ZZFLEXC_API(UIColor *, onTintColor)
ZZFLEXC_API(UIColor *, thumbTintColor)

ZZFLEXC_API(UIImage *, onImage)
ZZFLEXC_API(UIImage *, offImage)

@end

ZZFLEX_EX_API(ZZSwitchChainModel, UISwitch)
