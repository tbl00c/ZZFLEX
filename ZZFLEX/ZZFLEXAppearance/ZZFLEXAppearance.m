//
//  ZZFLEXAppearance.m
//  ZZFLEX
//
//  Created by 李伯坤 on 2021/7/14.
//

#import "ZZFLEXAppearance.h"

@implementation ZZFLEXAppearance

+ (instancetype)appearance {
    static ZZFLEXAppearance *appearance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appearance = [[ZZFLEXAppearance alloc] init];
    });
    return appearance;
}

- (UIColor *)seperatorColor {
    if (!_seperatorColor) {
        return [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0];
    }
    return _seperatorColor;
}

@end
