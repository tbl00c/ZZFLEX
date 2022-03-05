//
//  ZZFLEXChainModelMacros.h
//  ZZFLEX
//
//  Created by libokun on 2022/2/11.
//

#ifndef ZZFLEXChainModelMacros_h
#define ZZFLEXChainModelMacros_h

/// 链式API声明
#define     ZZFLEXC_PROPERTY              @property (nonatomic, copy, readonly)

// 普通API
#define     ZZFLEXC_API(ZZParamType, methodName)   ZZFLEXC_PROPERTY ObjcType (^ methodName)(ZZParamType methodName);
// 普通API实现
#define     ZZFLEXC_IMP(ZZParamType, methodName) \
- (id (^)(ZZParamType param))methodName {   \
    return ^id (ZZParamType param) {    \
        ((ZZFLEXC_IMP_VIEW_TYPE *)self.view).methodName = param;   \
        return self;    \
    };\
}

/// UIKit拓展声明
#define     ZZFLEX_EX_API(ZZViewChainModelClass, ZZView)   \
@class ZZViewChainModelClass;  \
@interface ZZViewChainModelClass : _##ZZViewChainModelClass<ZZViewChainModelClass *>   \
@end    \
@interface ZZView (ZZFLEX_EX)   \
ZZFLEXC_PROPERTY ZZViewChainModelClass *zz_setup;    \
+ (ZZViewChainModelClass *(^)(NSInteger tag))zz_create;   \
@end
/// UIKit拓展实现
#define     ZZFLEX_EX_IMP(ZZViewChainModelClass) \
@implementation ZZViewChainModelClass  \
@end    \
@implementation ZZFLEXC_IMP_VIEW_TYPE (ZZFLEX_EX)  \
+ (ZZViewChainModelClass *(^)(NSInteger tag))zz_create {\
    return ^ZZViewChainModelClass *(NSInteger tag){    \
    ZZFLEXC_IMP_VIEW_TYPE *view = [[ZZFLEXC_IMP_VIEW_TYPE alloc] init];   \
        return [[ZZViewChainModelClass alloc] initWithTag:tag andView:view];    \
    };\
}\
- (ZZViewChainModelClass *)zz_setup {   \
    return [[ZZViewChainModelClass alloc] initWithTag:self.tag andView:self];    \
}   \
@end

#endif /* ZZFLEXChainModelMacros_h */
