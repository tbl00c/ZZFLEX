//
//  ZZFLEXAngeWingAppearance.m
//  Masonry
//
//  Created by 李伯坤 on 2020/2/3.
//

#import "ZZFLEXAngeWingAppearance.h"

@implementation ZZFLEXAngeWingAppearance

+ (instancetype)appearance
{
    static ZZFLEXAngeWingAppearance *appearance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appearance = [[ZZFLEXAngeWingAppearance alloc] init];
    });
    return appearance;
}

+ (instancetype)appearanceForClass:(Class)class
{
    if (!class) {
        return [self appearance];
    }
    static NSMutableDictionary *map;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        map = [[NSMutableDictionary alloc] init];
    });
    ZZFLEXAngeWingAppearance *appearance = [map objectForKey:class];
    if (!appearance) {
        appearance = [[ZZFLEXAngeWingAppearance alloc] init];
        [map setObject:appearance forKey:class];
    }
    return appearance;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self resetData];
    }
    return self;
}

- (void)resetData
{
    {
        ZZFLEXAngelItemStyle *style = [[ZZFLEXAngelItemStyle alloc] init];
        style.backgroundColor = [UIColor whiteColor];
        style.backgroundColorHighlight = [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0];
        style.edgeInsets = UIEdgeInsetsMake(0, 15, 0, 15);
        style.space = @(10);
        
        // 分割线
        style.seperatorType = ZZFLEXAngelItemSeperatorSimple;
        style.seperatorColor = style.backgroundColorHighlight;
//        style.seperatorInsets = @(UIEdgeInsetsMake(0, 15, 0, 0));
        style.seperatorInsets = [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
        
        // 圆角
        style.cornorType = ZZFLEXAngelItemCornorNone;
        style.cornorRadius = @(10);
        
        style.accessoryType = ZZFLEXAngelItemAccessoryDisclosureIndicator;
        
        _itemStyle = style;
    }
    
    {
        ZZFLEXAngelItemImageStyle *style = [[ZZFLEXAngelItemImageStyle alloc] init];
        style.size = CGSizeMake(26, 26);
        _iconStyle = style;
    }
    
    {
        ZZFLEXAngelItemTextStyle *style = [[ZZFLEXAngelItemTextStyle alloc] init];
        style.font = [UIFont boldSystemFontOfSize:17];
        style.color = [UIColor blackColor];
        _titleStyle = style;
    }

    {
        ZZFLEXAngelItemTextStyle *style = [[ZZFLEXAngelItemTextStyle alloc] init];
        style.font = [UIFont boldSystemFontOfSize:15];
        style.color = [UIColor grayColor];
        _subTitleStyle = style;
    }
    
    {
        ZZFLEXAngelItemTextStyle *style = [[ZZFLEXAngelItemTextStyle alloc] init];
        style.font = [UIFont systemFontOfSize:15];
        style.color = [UIColor grayColor];
        _messageStyle = style;
    }
    
    {
        ZZFLEXAngelItemImageStyle *style = [[ZZFLEXAngelItemImageStyle alloc] init];
        style.size = CGSizeMake(32, 32);
        _imageStyle = style;
    }
}

@end
