//
//  ZZFDGoodDetailCell.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/12/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFDGoodDetailCell.h"
#import "UIView+ZZFLEX.h"

@interface ZZFDGoodDetailCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ZZFDGoodDetailCell

+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    CGFloat height = [dataModel boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 30, MAXFLOAT)
                                             options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin
                                             context:nil].size.height + 15;
    return height;
}

- (void)setViewDataModel:(NSAttributedString *)dataModel
{
    [self.titleLabel setAttributedText:dataModel];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        self.titleLabel = self.addLabel(1)
        .numberOfLines(0)
        .masonry(^ (MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(5);
            make.right.mas_equalTo(-15);
            make.bottom.mas_equalTo(0);
        })
        .view;
    }
    return self;
}

@end

