//
//  ZZFDGoodSectionTitleCell.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/12/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFDGoodSectionTitleCell.h"

@interface ZZFDGoodSectionTitleCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ZZFDGoodSectionTitleCell

+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 40;
}

- (void)setViewDataModel:(NSString *)dataModel
{
    [self.titleLabel setText:dataModel];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        self.titleLabel = self.addLabel(1).numberOfLines(0)
        .font([UIFont boldSystemFontOfSize:15])
        .masonry(^(UIView *senderView, MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(15);
            make.right.mas_equalTo(-15);
        })
        .view;
    }
    return self;
}

@end

