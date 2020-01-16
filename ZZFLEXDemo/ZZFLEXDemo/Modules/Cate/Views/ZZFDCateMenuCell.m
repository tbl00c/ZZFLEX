//
//  ZZFDCateMenuCell.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/12/18.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFDCateMenuCell.h"
#import "ZZFDCateModel.h"

@implementation ZZFDCateMenuCell

+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 50;
}

- (void)setViewDataModel:(ZZFDCateModel *)dataModel
{
    [self.textLabel setText:dataModel.cateName];
    if (dataModel.selected) {
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    else {
        [self setBackgroundColor:[UIColor clearColor]];
    }
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.addSeparator(ZZSeparatorPositionBottom).beginAt(15);
}

@end
