//
//  ZZFDGoodParamCell.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/12/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFDGoodParamCell.h"
#import "UIView+ZZFLEX.h"
#import "ZZFDGoodListModel.h"

@interface ZZFDGoodParamCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ZZFDGoodParamCell

+ (CGSize)viewSizeByDataModel:(id)dataModel
{
    return CGSizeMake(SCREEN_WIDTH / 2.0, 22);
}

- (void)setViewDataModel:(ZZFDGoodParamModel *)dataModel
{
    [self.titleLabel setText:[NSString stringWithFormat:@"%@：%@", dataModel.key, dataModel.value]];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        self.titleLabel = self.addLabel(1)
        .font([UIFont systemFontOfSize:13])
        .textColor([UIColor lightGrayColor])
        .masonry(^ (MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(5);
            make.right.mas_equalTo(-15);
        })
        .view;
    }
    return self;
}

@end
