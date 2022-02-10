//
//  ZZShadow.m
//  WCUIKit
//
//  Created by libokun on 2021/5/18.
//  Copyright © 2021 WeChat. All rights reserved.
//

#import "ZZShadow.h"

#define ZZFLEX_SHADOW_IMP(ZZParamType, methodName)    \
- (ZZShadowChainModel * (^)(ZZParamType offset))methodName {  \
    return ^(ZZParamType methodName) {  \
        self.object.methodName = methodName;    \
        return self;    \
    };  \
}

@implementation ZZShadowChainModel
@synthesize object = _object;

+ (instancetype)create {
    ZZShadowChainModel *chainModel = [[ZZShadowChainModel alloc] init];
    return chainModel;
}

ZZFLEX_SHADOW_IMP(CGSize, offset)
ZZFLEX_SHADOW_IMP(UIColor *, color)
ZZFLEX_SHADOW_IMP(CGFloat, radius)
ZZFLEX_SHADOW_IMP(CGFloat, opacity)

- (ZZShadowModel *)object {
    if (!_object) {
        _object = [[ZZShadowModel alloc] init];
    }
    return _object;
}

@end

@implementation ZZShadowModel

@end
