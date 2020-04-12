//
//  ZZFLEXAngelItemText.m
//  Masonry
//
//  Created by 李伯坤 on 2020/2/4.
//

#import "ZZFLEXAngelItemText.h"
#import "ZZFLEXFoundationExtension.h"

@implementation ZZFLEXAngelItemTextStyle

@end


@implementation ZZFLEXAngelItemText

- (ZZFLEXAngelItemTextStyle *)style
{
    if (!_style) {
        _style = [[ZZFLEXAngelItemTextStyle alloc] init];
    }
    return _style;
}

@end
