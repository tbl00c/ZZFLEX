//
//  ZZImageViewChainModel.h
//  zhuanzhuan
//
//  Created by 李伯坤 on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZBaseViewChainModel.h"

#define     ZZFLEXC_IV_API(ZZParamType, methodName)      ZZFLEXC_API(ZZImageViewChainModel, ZZParamType, methodName)

@class ZZImageViewChainModel;
@interface ZZImageViewChainModel : ZZBaseViewChainModel <ZZImageViewChainModel *>

ZZFLEXC_IV_API(UIImage *, image)
ZZFLEXC_IV_API(UIImage *, highlightedImage)
ZZFLEXC_IV_API(BOOL, highlighted)

@end

ZZFLEX_EX_API(ZZImageViewChainModel, UIImageView)
