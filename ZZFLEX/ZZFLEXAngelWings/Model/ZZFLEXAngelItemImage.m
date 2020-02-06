//
//  ZZFLEXAngelItemImage.m
//  Masonry
//
//  Created by 李伯坤 on 2020/2/4.
//

#import "ZZFLEXAngelItemImage.h"

@implementation ZZFLEXAngelItemImageStyle

@end

@implementation ZZFLEXAngelItemImage

- (BOOL)enable
{
    if (_image || _imageName.length > 0 || _imageUrl.length > 0) {
        return YES;
    }
    return NO;
}

- (ZZFLEXAngelItemImageStyle *)style
{
    if (!_style) {
        _style = [[ZZFLEXAngelItemImageStyle alloc] init];
    }
    return _style;
}

@end
