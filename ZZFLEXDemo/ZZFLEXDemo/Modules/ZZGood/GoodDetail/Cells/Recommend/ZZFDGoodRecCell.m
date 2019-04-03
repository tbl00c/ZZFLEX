//
//  ZZFDGoodRecCell.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/12/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFDGoodRecCell.h"
#import "UIView+ZZFLEX.h"
#import "ZZFDGoodListModel.h"

@interface ZZFDGoodRecCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *positionLabel;
@property (nonatomic, strong) UILabel *lastLonginLabel;

@property (nonatomic, strong) UILabel *priceLabel;

@end


@implementation ZZFDGoodRecCell

+ (CGSize)viewSizeByDataModel:(id)dataModel
{
    CGFloat width = (SCREEN_WIDTH - 40) / 2;
    return CGSizeMake(width, width + 85);
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
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        [self setSelectedBackgrounColor:[UIColor colorGrayLine]];
        [self.contentView.layer setMasksToBounds:YES];
        [self.contentView.layer setCornerRadius:5.0f];
        
        self.imageView = self.contentView.addImageView(1001)
        .contentMode(UIViewContentModeScaleAspectFill)
        .clipsToBounds(YES)
        .masonry(^ (MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
        })
        .view;
        [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.imageView.mas_height);
        }];
        
        self.titleLabel = self.contentView.addLabel(1002)
        .font([UIFont systemFontOfSize:14])
        .masonry(^ (MASConstraintMaker *make) {
            make.top.mas_equalTo(self.imageView.mas_bottom).mas_offset(10);
            make.left.mas_equalTo(10);
            make.right.mas_lessThanOrEqualTo(-10);
        })
        .view;
        
        self.priceLabel = self.contentView.addLabel(1011)
        .masonry(^ (MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLabel);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(5);
        })
        .view;
        
        self.positionLabel = self.contentView.addLabel(1010)
        .font([UIFont systemFontOfSize:12])
        .textColor([UIColor grayColor])
        .masonry(^ (MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLabel);
            make.top.mas_equalTo(self.priceLabel.mas_bottom).mas_offset(5);
        })
        .view;
        
        self.lastLonginLabel = self.contentView.addLabel(1011)
        .font([UIFont systemFontOfSize:12])
        .textColor([UIColor grayColor])
        .masonry(^ (MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(self.positionLabel);
        })
        .view;
        
        
    }
    return self;
}

@end
