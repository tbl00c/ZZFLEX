//
//  ZZProgressViewChainModel.m
//  ZZFLEX
//
//  Created by libokun on 2021/1/15.
//

#import "ZZProgressViewChainModel.h"

#define     ZZFLEXC_IMP_VIEW_TYPE   UIProgressView

@implementation _ZZProgressViewChainModel

+ (Class)viewClass {
    return [UIProgressView class];
}

ZZFLEXC_IMP(UIProgressViewStyle, progressViewStyle)
ZZFLEXC_IMP(float, progress)
ZZFLEXC_IMP(UIColor *, progressTintColor)
ZZFLEXC_IMP(UIColor *, trackTintColor)
ZZFLEXC_IMP(UIImage *, progressImage)
ZZFLEXC_IMP(UIImage *, trackImage)

@end

ZZFLEX_EX_IMP(ZZProgressViewChainModel)
