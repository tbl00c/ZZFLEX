//
//  ZZFDGoodHeadCell.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/12/19.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFDGoodTitleCell.h"
#import "UIView+ZZFLEX.h"
#import "ZZFDGoodListModel.h"

#define     GOOD_TITLE_FONT     [UIFont boldSystemFontOfSize:18]

@interface ZZFDGoodTitleCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UILabel *readLabel;

@end

@implementation ZZFDGoodTitleCell

+ (CGSize)viewSizeByDataModel:(ZZFDGoodListModel *)dataModel
{
    CGFloat height = [dataModel.goodTitle tt_sizeWithFont:GOOD_TITLE_FONT constrainedToWidth:SCREEN_WIDTH - 30].height + 15;
    height += 50;
    return CGSizeMake(SCREEN_WIDTH, height);
}

- (void)setViewDataModel:(ZZFDGoodListModel *)dataModel
{
    [self.titleLabel setText:dataModel.goodTitle];
    [self.priceLabel setAttributedText:dataModel.attrPrice];
    [self.readLabel setText:[NSString stringWithFormat:@"%u次阅读", arc4random() % 1000]];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        self.titleLabel = self.addLabel(1)
        .numberOfLines(0)
        .font(GOOD_TITLE_FONT)
        .masonry(^ (MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(15);
            make.right.mas_equalTo(-15);
        })
        .view;
        
        self.priceLabel = self.addLabel(2)
        .masonry(^ (MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(15);
        })
        .view;
        
        self.readLabel = self.addLabel(3)
        .font([UIFont systemFontOfSize:12])
        .textColor([UIColor lightGrayColor])
        .masonry(^ (MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(self.priceLabel);
        })
        .view;
    }
    return self;
}

@end
