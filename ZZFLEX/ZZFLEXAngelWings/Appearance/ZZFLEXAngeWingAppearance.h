//
//  ZZFLEXAngeWingAppearance.h
//  Masonry
//
//  Created by 李伯坤 on 2020/2/3.
//

#import <Foundation/Foundation.h>
#import "ZZFLEXAngelItemText.h"
#import "ZZFLEXAngelItemImage.h"
#import "ZZFLEXAngelItemStyle.h"

@interface ZZFLEXAngeWingAppearance : NSObject

@property (nonatomic, strong) ZZFLEXAngelItemStyle *itemStyle;

@property (nonatomic, strong) ZZFLEXAngelItemImage *iconStyle;

@property (nonatomic, strong) ZZFLEXAngelItemTextStyle *titleStyle;

@property (nonatomic, strong) ZZFLEXAngelItemTextStyle *subTitleStyle;

@property (nonatomic, strong) ZZFLEXAngelItemTextStyle *messageStyle;

@property (nonatomic, strong) ZZFLEXAngelItemImage *imageStyle;


+ (instancetype)appearance;

+ (instancetype)appearanceForClass:(Class)class;

@end
