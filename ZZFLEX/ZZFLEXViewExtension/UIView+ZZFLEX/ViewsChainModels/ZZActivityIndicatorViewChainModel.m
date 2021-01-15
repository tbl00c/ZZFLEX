//
//  ZZActivityIndicatorViewChainModel.m
//  ZZFLEX
//
//  Created by libokun on 2021/1/15.
//

#import "ZZActivityIndicatorViewChainModel.h"

#define     ZZFLEXC_AIV_IMP(ZZParamType, methodName)      ZZFLEXC_IMP(ZZActivityIndicatorViewChainModel, UIActivityIndicatorView, ZZParamType, methodName)

@implementation ZZActivityIndicatorViewChainModel

+ (Class)viewClass
{
    return [UIActivityIndicatorView class];
}

ZZFLEXC_AIV_IMP(UIActivityIndicatorViewStyle, activityIndicatorViewStyle)
ZZFLEXC_AIV_IMP(BOOL, hidesWhenStopped)
ZZFLEXC_AIV_IMP(UIColor *, color)

@end

ZZFLEX_EX_IMP(ZZActivityIndicatorViewChainModel, UIActivityIndicatorView)
