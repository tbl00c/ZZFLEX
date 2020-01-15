//
//  ZZFDMainMenuCell.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/11/28.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFDMainMenuCell.h"
#import "UIView+ZZFLEX.h"

@interface ZZFDMainMenuCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ZZFDMainMenuCell

#pragma mark - # ZZFlexibleLayoutViewProtocol
+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 56;
}

- (void)setViewDataModel:(id)dataModel
{
    [self.titleLabel setText:dataModel];
}

#pragma mark - # Cell Init
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setSelectedBackgrounColor:[UIColor colorGrayLine]];
        
        self.titleLabel = self.contentView.addLabel(1)
        .font([UIFont boldSystemFontOfSize:16])
        .textColor([UIColor blackColor])
        .masonry(^ (MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
            make.right.mas_lessThanOrEqualTo(-35);
        })
        .view;
        
        self.contentView.addImageView(2)
        .image([UIImage imageNamed:@"arrow"])
        .masonry(^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(0);
        });
    }
    return self;
}

@end
