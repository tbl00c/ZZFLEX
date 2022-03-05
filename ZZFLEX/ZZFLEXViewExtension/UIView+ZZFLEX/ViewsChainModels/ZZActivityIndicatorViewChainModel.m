//
//  ZZActivityIndicatorViewChainModel.m
//  ZZFLEX
//
//  Created by libokun on 2021/1/15.
//

#import "ZZActivityIndicatorViewChainModel.h"

#define     ZZFLEXC_IMP_VIEW_TYPE   UIActivityIndicatorView

@implementation _ZZActivityIndicatorViewChainModel

+ (Class)viewClass {
    return [UIActivityIndicatorView class];
}

ZZFLEXC_IMP(UIActivityIndicatorViewStyle, activityIndicatorViewStyle)
ZZFLEXC_IMP(BOOL, hidesWhenStopped)
ZZFLEXC_IMP(UIColor *, color)

@end

ZZFLEX_EX_IMP(ZZActivityIndicatorViewChainModel)
