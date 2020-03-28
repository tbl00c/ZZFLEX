//
//  ZZFLEXAngelSwitchCell.m
//  Masonry
//
//  Created by 李伯坤 on 2020/2/6.
//

#import "ZZFLEXAngelSwitchCell.h"

@implementation ZZFLEXAngelSwitchCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        __weak typeof(self) weakSelf = self;
        self.switchControl = self.angelView.addSwitch(0)
        .masonry(^ (__kindof UIView *view, MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.left.mas_equalTo(self.titleView.mas_right);
            make.centerY.mas_equalTo(0);
        })
        .eventValueChanged(^(UISwitch *sender) {
            weakSelf.item.style.selected = sender.on;
            if (weakSelf.viewEventAction) {
                weakSelf.viewEventAction(0, weakSelf.item);
            }
        })
        .view;
    }
    return self;
}

- (void)setItem:(ZZFLEXAngelItem *)item
{
    [super setItem:item];
    
    [self.selectedBackgroundView setBackgroundColor:[UIColor clearColor]];
    [self.switchControl setOn:item.style.selected];
}

@end
