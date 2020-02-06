//
//  ZZFLEXAngelItemText.h
//  Masonry
//
//  Created by 李伯坤 on 2020/2/4.
//

#import <Foundation/Foundation.h>

@interface ZZFLEXAngelItemTextStyle : NSObject

/// 颜色
@property (nonatomic, strong) UIColor *color;
/// 字体
@property (nonatomic, strong) UIFont *font;

@end

@interface ZZFLEXAngelItemText : NSObject

/// 标题
@property (nonatomic, strong) NSString *text;

/// 富文本标题
@property (nonatomic, strong) NSAttributedString *attrText;

/// 样式
@property (nonatomic, strong) ZZFLEXAngelItemTextStyle *style;

@end

static ZZFLEXAngelItemText *zzflex_createAngelText(NSString *text) {
    ZZFLEXAngelItemText *item = [[ZZFLEXAngelItemText alloc] init];
    item.text = text;
    return item;
}
