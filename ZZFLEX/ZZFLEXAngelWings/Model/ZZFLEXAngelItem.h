//
//  ZZFLEXAngelItem.h
//  ZZFLEX
//
//  Created by 李伯坤 on 2020/1/31.
//

#import <Foundation/Foundation.h>
#import "ZZFLEXAngelItemText.h"
#import "ZZFLEXAngelItemImage.h"
#import "ZZFLEXAngelItemStyle.h"

@interface ZZFLEXAngelItem : NSObject

/// icon
@property (nonatomic, strong) NSString *iconUrl;
@property (nonatomic, strong) NSString *iconName;
@property (nonatomic, strong) ZZFLEXAngelItemImage *iconModel;

/// 主标题
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) ZZFLEXAngelItemText *titleModel;

/// 副标题
@property (nonatomic, strong) NSString *subTitle;
@property (nonatomic, strong) ZZFLEXAngelItemText *subTitleModel;

/// 正文
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) ZZFLEXAngelItemText *messageModel;

/// image
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) ZZFLEXAngelItemImage *imageModel;

/// 样式
@property (nonatomic, strong) ZZFLEXAngelItemStyle *style;

/// 用户自定义
@property (nonatomic, strong) id userInfo;

@end

static inline ZZFLEXAngelItem *zzflex_createAngelItem(NSString *title) {
    ZZFLEXAngelItem *item = [[ZZFLEXAngelItem alloc] init];
    item.title = title;
    return item;
}

static inline ZZFLEXAngelItem *zzflex_createAngelIconItem(NSString *iconName, NSString *title) {
    ZZFLEXAngelItem *item = [[ZZFLEXAngelItem alloc] init];
    item.iconName = iconName;
    item.title = title;
    return item;
}


static inline ZZFLEXAngelItem *zzflex_createAngelWebIconItem(NSString *iconUrl, NSString *title) {
    ZZFLEXAngelItem *item = [[ZZFLEXAngelItem alloc] init];
    item.iconUrl = iconUrl;
    item.title = title;
    return item;
}

#pragma mark - # SubTitle
static inline ZZFLEXAngelItem *zzflex_createAngelItemWithSubTitle(NSString *title, NSString *subTitle) {
    ZZFLEXAngelItem *item = [[ZZFLEXAngelItem alloc] init];
    item.title = title;
    item.subTitle = subTitle;
    return item;
}

static inline ZZFLEXAngelItem *zzflex_createAngelIconItemWithSubTitle(NSString *iconName, NSString *title, NSString *subTitle) {
    ZZFLEXAngelItem *item = [[ZZFLEXAngelItem alloc] init];
    item.iconName = iconName;
    item.title = title;
    item.subTitle = subTitle;
    return item;
}

#pragma mark - # Switch
static ZZFLEXAngelItem *zzflex_createAngelSwitchItem(NSString *title, BOOL on) {
    ZZFLEXAngelItem *item = [[ZZFLEXAngelItem alloc] init];
    item.title = title;
    item.style.selected = on;
    return item;
}

static ZZFLEXAngelItem *zzflex_createAngelSwitchIconItem(NSString *iconName, NSString *title, BOOL on) {
    ZZFLEXAngelItem *item = [[ZZFLEXAngelItem alloc] init];
    item.iconName = iconName;
    item.title = title;
    item.style.selected = on;
    return item;
}

static ZZFLEXAngelItem *zzflex_createAngelSwitchWebIconItem(NSString *iconUrl, NSString *title, BOOL on) {
    ZZFLEXAngelItem *item = [[ZZFLEXAngelItem alloc] init];
    item.iconUrl = iconUrl;
    item.title = title;
    item.style.selected = on;
    return item;
}

