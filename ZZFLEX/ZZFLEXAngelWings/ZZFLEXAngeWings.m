//
//  ZZFLEXAngeWings.m
//  Masonry
//
//  Created by 李伯坤 on 2020/2/4.
//

#import "ZZFLEXAngeWings.h"
#import "ZZFLEXAngelNormalCell.h"
#import "ZZFLEXAngelSwitchCell.h"

@implementation ZZFLEXAngelWingsClassEnum

+ (Class)normalClass
{
    return [ZZFLEXAngelNormalCell class];
}

+ (Class)switchClass
{
    return [ZZFLEXAngelSwitchCell class];
}

@end
