//
//  ZZImageViewChainModel.h
//  zhuanzhuan
//
//  Created by 李伯坤 on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZViewChainModel.h"

@interface _ZZImageViewChainModel<ObjcType> : _ZZViewChainModel <ObjcType>

ZZFLEXC_API(UIImage *, image)
ZZFLEXC_API(UIImage *, highlightedImage)
ZZFLEXC_API(BOOL, highlighted)

@end

ZZFLEX_EX_API(ZZImageViewChainModel, UIImageView)
