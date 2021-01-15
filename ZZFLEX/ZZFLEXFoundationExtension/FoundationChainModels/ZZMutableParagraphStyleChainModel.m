//
//  ZZMutableParagraphStyleChainModel.m
//  Masonry
//
//  Created by 李伯坤 on 2019/8/30.
//

#import "ZZMutableParagraphStyleChainModel.h"

#define     ZZFLEX_FMPS_CHAIN_IMP(methodName, ZZParamType) \
- (ZZMutableParagraphStyleChainModel *(^)(ZZParamType param))methodName {   \
return ^ZZMutableParagraphStyleChainModel *(ZZParamType param) {    \
self.object.methodName = param;   \
return self;    \
};\
}


@implementation ZZMutableParagraphStyleChainModel

- (instancetype)initWithObject:(NSMutableParagraphStyle *)object
{
    if (self = [self init]) {
        _object = object ? object : [[NSMutableParagraphStyle alloc] init];
    }
    return self;
}

ZZFLEX_FMPS_CHAIN_IMP(lineSpacing, CGFloat);
ZZFLEX_FMPS_CHAIN_IMP(paragraphSpacing, CGFloat);
ZZFLEX_FMPS_CHAIN_IMP(alignment, NSTextAlignment);
ZZFLEX_FMPS_CHAIN_IMP(firstLineHeadIndent, CGFloat);
ZZFLEX_FMPS_CHAIN_IMP(headIndent, CGFloat);
ZZFLEX_FMPS_CHAIN_IMP(tailIndent, CGFloat);
ZZFLEX_FMPS_CHAIN_IMP(lineBreakMode, NSLineBreakMode);
ZZFLEX_FMPS_CHAIN_IMP(minimumLineHeight, CGFloat);
ZZFLEX_FMPS_CHAIN_IMP(maximumLineHeight, CGFloat);
ZZFLEX_FMPS_CHAIN_IMP(baseWritingDirection, NSWritingDirection);
ZZFLEX_FMPS_CHAIN_IMP(lineHeightMultiple, CGFloat);
ZZFLEX_FMPS_CHAIN_IMP(paragraphSpacingBefore, CGFloat);
ZZFLEX_FMPS_CHAIN_IMP(hyphenationFactor, float);

@end
