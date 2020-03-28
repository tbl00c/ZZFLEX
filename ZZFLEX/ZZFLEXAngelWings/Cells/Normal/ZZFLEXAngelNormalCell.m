//
//  ZZFLEXAngelNormalCell.m
//  Masonry
//
//  Created by 李伯坤 on 2020/2/3.
//

#import "ZZFLEXAngelNormalCell.h"

@implementation ZZFLEXAngelNormalCell

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
    
    // 副标题
    [self.subTitleLabel setTextModel:item.subTitleModel defaultStyle:appearance.subTitleStyle];
    
    // 更多
    ZZFLEXAngelItemAccessoryType accessoryType = item.style.accessoryType == ZZFLEXAngelItemAccessoryAuto ? appearance.itemStyle.accessoryType : item.style.accessoryType;
    self.arrowView.zz_setup.hidden(accessoryType == ZZFLEXAngelItemAccessoryAuto || accessoryType == ZZFLEXAngelItemAccessoryNone)
    .updateMasonry(^(__kindof UIView *sender, MASConstraintMaker *make) {
        if (accessoryType == ZZFLEXAngelItemAccessoryDisclosureIndicator) {
            make.size.mas_equalTo(CGSizeMake(8, 13));
            make.left.mas_equalTo(self.subTitleLabel.mas_right).mas_offset(space);
        }
        else {
            make.size.mas_equalTo(CGSizeZero);
            make.left.mas_equalTo(self.subTitleLabel.mas_right);
        }
    });
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self resetNormalCellUI];
    }
    return self;
}

- (void)resetNormalCellUI
{
    ZZFLEXAngeWingAppearance *appearance = [ZZFLEXAngeWingAppearance appearanceForClass:[self class]];
    
    // 头像
    {
        ZZFLEXAngelCellImageView *imageView = [[ZZFLEXAngelCellImageView alloc] init];
        [self.angelView addSubview:imageView];
        imageView.zz_setup.masonry(^ (__kindof UIView *view, MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.centerY.mas_equalTo(0);
        });
        _iconView = imageView;
    }
    
    // 标题
    {
        ZZFLEXAngelCellLabel *label = [[ZZFLEXAngelCellLabel alloc] init];
        [self.angelView addSubview:label];
        label.zz_setup.masonry(^(__kindof UIView *sender, MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconView.mas_right);
            make.centerY.mas_equalTo(0);
        });
        _titleLabel = label;
    }
    
    // 副标题
    {
        ZZFLEXAngelCellLabel *label = [[ZZFLEXAngelCellLabel alloc] init];
        label.textLabel.zz_setup.textAlignment(NSTextAlignmentRight);
        [self.angelView addSubview:label];
        label.zz_setup.masonry(^(__kindof UIView *sender, MASConstraintMaker *make) {
           make.left.mas_equalTo(self.titleLabel.mas_right);
           make.centerY.mas_equalTo(0);
        });
        _subTitleLabel = label;
    }
    
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:ZZFLEXImage(@"zzflex_right_arrow")];
        [self.angelView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.size.mas_equalTo(0);
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(self.subTitleLabel.mas_right);
        }];
        _arrowView = imageView;
    }
}

@end
