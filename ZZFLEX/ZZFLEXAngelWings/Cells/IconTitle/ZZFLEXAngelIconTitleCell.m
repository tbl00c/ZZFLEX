//
//  ZZFLEXAngelIconTitleCell.m
//  Masonry
//
//  Created by 李伯坤 on 2020/2/6.
//

#import "ZZFLEXAngelIconTitleCell.h"

@implementation ZZFLEXAngelIconTitleCell

- (void)setItem:(ZZFLEXAngelItem *)item
{
    [super setItem:item];
    
    ZZFLEXAngeWingAppearance *appearance = [ZZFLEXAngeWingAppearance appearanceForClass:[self class]];
    
    // icon
    [self.iconView setImageModel:item.iconModel defaultStyle:appearance.iconStyle];
    
    // 标题
    CGFloat space = item.style.space ? item.style.space.doubleValue : appearance.itemStyle.space.doubleValue;
    [self.titleLabel setTextModel:item.titleModel defaultStyle:appearance.titleStyle];
    self.titleLabel.zz_setup.updateMasonry(^(__kindof UIView *sender, MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconView.mas_right).mas_offset(item.iconModel.enable ? space : 0);
    });
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self resetTitleCellUI];
    }
    return self;
}

- (void)resetTitleCellUI
{
    {
        _titleView = self.angelView.addView(0)
        .masonry(^ (__kindof UIView *view, MASConstraintMaker *make) {
            make.left.top.bottom.mas_equalTo(0);
        })
        .view;
    }
    
    // 头像
    {
        ZZFLEXAngelCellImageView *imageView = [[ZZFLEXAngelCellImageView alloc] init];
        [self.titleView addSubview:imageView];
        imageView.zz_setup.masonry(^ (__kindof UIView *view, MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.centerY.mas_equalTo(0);
        });
        _iconView = imageView;
    }
    
    // 标题
    {
        ZZFLEXAngelCellLabel *label = [[ZZFLEXAngelCellLabel alloc] init];
        [self.titleView addSubview:label];
        label.zz_setup.masonry(^(__kindof UIView *sender, MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconView.mas_right);
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(0);
        });
        _titleLabel = label;
    }
}


@end
