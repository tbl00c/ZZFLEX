//
//  ZZCustomViewChainModel.h
//  ZZFlexibleLayoutFramework
//
//  Created by 李伯坤 on 2017/11/12.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZViewChainModel.h"

@class ZZCustomViewChainModel;
@interface ZZCustomViewChainModel : ZZViewChainModel <ZZCustomViewChainModel *>

@end

ZZFLEX_EX_INTERFACE(UIView, ZZViewChainModel)
