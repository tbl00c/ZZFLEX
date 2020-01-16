//
//  ZZFDGoodTitleView.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/12/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFDGoodTitleView.h"

@interface ZZFDGoodTitleView ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ZZFDGoodTitleView

+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 50;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel = self.addLabel(1)
        .text(@"——  商品推荐  ——")
        .numberOfLines(0)
        .font([UIFont systemFontOfSize:16])
        .masonry(^(UIView *senderView, MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.bottom.mas_equalTo(-10);
        })
        .view;
    }
    return self;
}

@end

