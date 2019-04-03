//
//  ZZFDCateSectionItemCell.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/12/19.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFDCateSectionItemCell.h"
#import "UIView+ZZFLEX.h"
#import "ZZFDCateModel.h"
#import "UIColor+ZZFD.h"

@interface ZZFDCateSectionItemCell ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ZZFDCateSectionItemCell

+ (CGSize)viewSizeByDataModel:(id)dataModel
{
    return CGSizeMake(70, 95);
}

- (void)setViewDataModel:(ZZFDCateItemModel *)dataModel
{
    if (dataModel.itemImageName.length > 0) {
        [self.imageView setBackgroundColor:[UIColor clearColor]];
        [self.imageView setImage:[UIImage imageNamed:dataModel.itemImageName]];
    }
    else {
        [self.imageView setImage:nil];
        [self.imageView setBackgroundColor:[UIColor colorGrayBG]];
    }
    [self.titleLabel setText:dataModel.itemName];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.imageView = self.addImageView(0)
        .masonry(^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(5);
            make.size.mas_equalTo(58);
        })
        .view;
        
        self.titleLabel = self.addLabel(1)
        .font([UIFont systemFontOfSize:12])
        .masonry(^ (MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.bottom.mas_equalTo(-10);
        })
        .view;
    }
    return self;
}

@end
