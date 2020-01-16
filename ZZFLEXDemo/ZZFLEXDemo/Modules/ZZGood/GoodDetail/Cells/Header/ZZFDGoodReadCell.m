//
//  ZZFDGoodReadCell.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/12/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFDGoodReadCell.h"

@interface ZZFDGoodReadCell ()

@property (nonatomic, strong) UILabel *readLabel;

@end

@implementation ZZFDGoodReadCell

+ (CGSize)viewSizeByDataModel:(NSString *)dataModel
{
    return CGSizeMake(-0.5, 40);
}

- (void)setViewDataModel:(NSString *)dataModel
{
    [self.readLabel setText:dataModel];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        self.readLabel = self.addLabel(3)
        .font([UIFont systemFontOfSize:12])
        .textColor([UIColor lightGrayColor])
        .masonry(^(UIView *senderView, MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(0);
        })
        .view;
    }
    return self;
}

@end
