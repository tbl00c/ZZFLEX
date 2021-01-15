//
//  ZZActivityIndicatorViewChainModel.h
//  ZZFLEX
//
//  Created by libokun on 2021/1/15.
//

#import "ZZBaseViewChainModel.h"

#define     ZZFLEXC_AIV_API(ZZParamType, methodName)      ZZFLEXC_API(ZZActivityIndicatorViewChainModel, ZZParamType, methodName)

@class ZZActivityIndicatorViewChainModel;
@interface ZZActivityIndicatorViewChainModel : ZZBaseViewChainModel <ZZActivityIndicatorViewChainModel *>

ZZFLEXC_AIV_API(UIActivityIndicatorViewStyle, activityIndicatorViewStyle)
ZZFLEXC_AIV_API(BOOL, hidesWhenStopped)
ZZFLEXC_AIV_API(UIColor *, color)

@end

ZZFLEX_EX_API(ZZActivityIndicatorViewChainModel, UIActivityIndicatorView)
