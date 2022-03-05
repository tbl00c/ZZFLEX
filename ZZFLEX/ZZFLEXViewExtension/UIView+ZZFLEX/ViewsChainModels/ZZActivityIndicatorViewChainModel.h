//
//  ZZActivityIndicatorViewChainModel.h
//  ZZFLEX
//
//  Created by libokun on 2021/1/15.
//

#import "ZZViewChainModel.h"

@interface _ZZActivityIndicatorViewChainModel<ObjcType> : _ZZViewChainModel <ObjcType>

ZZFLEXC_API(UIActivityIndicatorViewStyle, activityIndicatorViewStyle)
ZZFLEXC_API(BOOL, hidesWhenStopped)
ZZFLEXC_API(UIColor *, color)

@end

ZZFLEX_EX_API(ZZActivityIndicatorViewChainModel, UIActivityIndicatorView)
