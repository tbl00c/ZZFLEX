//
//  ZZProgressViewChainModel.h
//  ZZFLEX
//
//  Created by libokun on 2021/1/15.
//

#import "ZZViewChainModel.h"

@interface _ZZProgressViewChainModel<ObjcType> : _ZZViewChainModel <ObjcType>

ZZFLEXC_API(UIProgressViewStyle, progressViewStyle)
ZZFLEXC_API(float, progress)
ZZFLEXC_API(UIColor *, progressTintColor)
ZZFLEXC_API(UIColor *, trackTintColor)
ZZFLEXC_API(UIImage *, progressImage)
ZZFLEXC_API(UIImage *, trackImage)

@end

ZZFLEX_EX_API(ZZProgressViewChainModel, UIProgressView)
