//
//  ZZFLEXAngelItemStyle.h
//  Masonry
//
//  Created by 李伯坤 on 2020/2/4.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ZZFLEXAngelItemAccessoryType) {
    ZZFLEXAngelItemAccessoryAuto = 0,
    ZZFLEXAngelItemAccessoryNone,
    ZZFLEXAngelItemAccessoryDisclosureIndicator,
//    ZZFLEXAngelItemAccessoryDetailDisclosureButton,
//    ZZFLEXAngelItemAccessoryCheckmark,
//    ZZFLEXAngelItemAccessoryDetailButton,
};

typedef NS_ENUM(NSInteger, ZZFLEXAngelItemSeperatorType) {
    ZZFLEXAngelItemSeperatorAuto = 0,
    ZZFLEXAngelItemSeperatorNone,
    ZZFLEXAngelItemSeperatorSimple,
    ZZFLEXAngelItemSeperatorAll,
};

typedef NS_ENUM(NSInteger, ZZFLEXAngelItemCornorType) {
    ZZFLEXAngelItemCornorAuto = 0,
    ZZFLEXAngelItemCornorNone,
    ZZFLEXAngelItemCornorSimple,
    ZZFLEXAngelItemCornorAll,
};

@interface ZZFLEXAngelItemStyle : NSObject

@property (nonatomic, assign) UIEdgeInsets edgeInsets;
@property (nonatomic, strong) NSNumber *space;

@property (nonatomic, assign) BOOL selected;

@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *backgroundColorHighlight;
@property (nonatomic, assign) BOOL disableHighlight;

@property (nonatomic, assign) ZZFLEXAngelItemAccessoryType accessoryType;

@property (nonatomic, assign) ZZFLEXAngelItemSeperatorType seperatorType;
@property (nonatomic, strong) UIColor *seperatorColor;
@property (nonatomic, strong) NSValue *seperatorInsets;

@property (nonatomic, assign) ZZFLEXAngelItemCornorType cornorType;
@property (nonatomic, strong) NSNumber *cornorRadius;

@end
