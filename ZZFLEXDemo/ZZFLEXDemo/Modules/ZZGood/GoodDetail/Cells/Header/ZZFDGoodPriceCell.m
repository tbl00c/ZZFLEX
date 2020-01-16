//
//  ZZFDGoodPriceCell.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/12/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFDGoodPriceCell.h"
#import "ZZFDGoodListModel.h"

@interface ZZFDGoodPriceCell ()

@property (nonatomic, strong) UILabel *priceLabel;

@end

@implementation ZZFDGoodPriceCell

+ (CGSize)viewSizeByDataModel:(id)dataModel
{
    return CGSizeMake(-0.5, 40);
}

- (void)setViewDataModel:(id)dataModel
{
    [self.priceLabel setAttributedText:dataModel];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        self.priceLabel = self.addLabel(2)
        .masonry(^(UIView *senderView, MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
        })
        .view;
    }
    return self;
}

@end
