//
//  ZZProgressViewChainModel.m
//  ZZFLEX
//
//  Created by libokun on 2021/1/15.
//

#import "ZZProgressViewChainModel.h"

#define     ZZFLEXC_PV_IMP(ZZParamType, methodName)      ZZFLEXC_IMP(ZZProgressViewChainModel, UIProgressView, ZZParamType, methodName)

@implementation ZZProgressViewChainModel

+ (Class)viewClass
{
    return [UIProgressView class];
}

ZZFLEXC_PV_IMP(UIProgressViewStyle, progressViewStyle)
ZZFLEXC_PV_IMP(float, progress)
ZZFLEXC_PV_IMP(UIColor *, progressTintColor)
ZZFLEXC_PV_IMP(UIColor *, trackTintColor)
ZZFLEXC_PV_IMP(UIImage *, progressImage)
ZZFLEXC_PV_IMP(UIImage *, trackImage)

@end

ZZFLEX_EX_IMP(ZZProgressViewChainModel, UIProgressView)
