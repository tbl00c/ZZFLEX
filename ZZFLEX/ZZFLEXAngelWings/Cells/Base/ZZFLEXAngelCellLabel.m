//
//  ZZFLEXAngelCellLabel.m
//  Masonry
//
//  Created by 李伯坤 on 2020/2/3.
//

#import "ZZFLEXAngelCellLabel.h"
#import "ZZFLEXViewExtension.h"
#import <Masonry/Masonry.h>

@implementation ZZFLEXAngelCellLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.textLabel = self.addLabel(0)
        .masonry(^ (__kindof UIView *view, MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        })
        .view;
    }
    return self;
}

- (void)setTextModel:(ZZFLEXAngelItemText *)textModel defaultStyle:(ZZFLEXAngelItemTextStyle *)defaultStyle
{
    _textModel = textModel;
    ZZFLEXAngelItemTextStyle *style = textModel.style;
    if (textModel.attrText) {
        [self.textLabel setAttributedText:textModel.attrText];
    }
    else {
        self.textLabel.zz_setup.text(textModel.text)
        .font(style.font ? style.font : defaultStyle.font)
        .textColor(style.color ? style.color : defaultStyle.color);
    }
}

@end
