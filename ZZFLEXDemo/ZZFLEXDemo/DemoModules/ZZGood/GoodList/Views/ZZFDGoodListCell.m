//
//  ZZFDGoodListCell.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/11/28.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFDGoodListCell.h"
#import "UIView+ZZFLEX.h"
#import "ZZFDGoodListModel.h"

@interface ZZFDGoodListCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *positionLabel;
@property (nonatomic, strong) UILabel *lastLonginLabel;

@property (nonatomic, strong) UILabel *priceLabel;

@end

@implementation ZZFDGoodListCell

+ (CGSize)viewSizeByDataModel:(id)dataModel
{
    return CGSizeMake(SCREEN_WIDTH, 120);
}

- (void)setViewDataModel:(ZZFDGoodListModel *)dataModel
{
    [self.imageView setImage:[UIImage imageNamed:dataModel.goodFirstImage]];
    [self.titleLabel setText:dataModel.goodTitle];
    
    [self.positionLabel setText:dataModel.position];
    [self.lastLonginLabel setText:dataModel.lastLoginIn];
    
    [self.priceLabel setAttributedText:dataModel.attrPrice];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setSelectedBackgrounColor:[UIColor colorGrayLine]];
        
        self.imageView = self.contentView.addImageView(1001)
        .contentMode(UIViewContentModeScaleAspectFill)
        .clipsToBounds(YES)
        .cornerRadius(5)
        .masonry(^ (MASConstraintMaker *make) {
            make.left.top.mas_equalTo(15);
            make.bottom.mas_equalTo(-15);
        })
        .view;
        [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.imageView.mas_height);
        }];
        
        self.titleLabel = self.contentView.addLabel(1002)
        .numberOfLines(2)
        .font([UIFont systemFontOfSize:14])
        .masonry(^ (MASConstraintMaker *make) {
            make.top.mas_equalTo(self.imageView);
            make.left.mas_equalTo(self.imageView.mas_right).mas_offset(10);
            make.right.mas_lessThanOrEqualTo(-15);
        })
        .view;
        
        self.positionLabel = self.contentView.addLabel(1010)
        .font([UIFont systemFontOfSize:12])
        .textColor([UIColor grayColor])
        .masonry(^ (MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLabel);
            make.bottom.mas_equalTo(self.imageView);
        })
        .view;
        
        self.lastLonginLabel = self.contentView.addLabel(1011)
        .font([UIFont systemFontOfSize:12])
        .textColor([UIColor grayColor])
        .masonry(^ (MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.bottom.mas_equalTo(self.positionLabel);
        })
        .view;
        
        self.priceLabel = self.contentView.addLabel(1011)
        .masonry(^ (MASConstraintMaker *make) {
            make.left.mas_equalTo(self.positionLabel);
            make.bottom.mas_equalTo(self.positionLabel.mas_top).mas_offset(-3);
        })
        .view;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.addSeparator(TLSeparatorPositionBottom).beginAt(15).endAt(-15);
}

@end
