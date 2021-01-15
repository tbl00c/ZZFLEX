//
//  ZZProgressViewChainModel.h
//  ZZFLEX
//
//  Created by libokun on 2021/1/15.
//

#import "ZZBaseViewChainModel.h"

#define     ZZFLEXC_PV_API(ZZParamType, methodName)      ZZFLEXC_API(ZZProgressViewChainModel, ZZParamType, methodName)

@interface ZZProgressViewChainModel : ZZBaseViewChainModel

ZZFLEXC_PV_API(UIProgressViewStyle, progressViewStyle)
ZZFLEXC_PV_API(float, progress)
ZZFLEXC_PV_API(UIColor *, progressTintColor)
ZZFLEXC_PV_API(UIColor *, trackTintColor)
ZZFLEXC_PV_API(UIImage *, progressImage)
ZZFLEXC_PV_API(UIImage *, trackImage)

@end

ZZFLEX_EX_API(ZZProgressViewChainModel, UIProgressView)
