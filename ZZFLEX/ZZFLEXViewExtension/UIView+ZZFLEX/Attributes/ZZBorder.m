//
//  ZZBorder.m
//  WCUIKit
//
//  Created by libokun on 2021/5/18.
//  Copyright © 2021 WeChat. All rights reserved.
//

#import "ZZBorder.h"

#define ZZFLEX_BORDER_IMP(ZZParamType, methodName)    \
- (ZZBorderChainModel * (^)(ZZParamType offset))methodName {  \
    return ^(ZZParamType methodName) {  \
        self.object.methodName = methodName;    \
        return self;    \
    };  \
}

@implementation ZZBorderChainModel
@synthesize object = _object;

+ (instancetype)create {
    ZZBorderChainModel *chainModel = [[ZZBorderChainModel alloc] init];
    return chainModel;
}

ZZFLEX_BORDER_IMP(CGFloat, width)
ZZFLEX_BORDER_IMP(UIColor *, color)
ZZFLEX_BORDER_IMP(CGFloat, radius)

- (ZZBorderModel *)object {
    if (!_object) {
        _object = [[ZZBorderModel alloc] init];
    }
    return _object;
}

@end

@implementation ZZBorderModel

@end

