//
//  ZZFDMainTitleView.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/12/16.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFDMainTitleView.h"

@interface ZZFDMainTitleView ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ZZFDMainTitleView

#pragma mark - # ZZFlexibleLayoutViewProtocol
+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 55;
}

- (void)setViewDataModel:(id)dataModel
{
    if ([dataModel isKindOfClass:[NSString class]]) {
        [self.titleLabel setText:dataModel];
    }
    else {
        [self.titleLabel setText:@""];
    }
}

#pragma mark - # Cell Init
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel = self.addLabel(1)
        .font([UIFont systemFontOfSize:18])
        .textColor([UIColor darkGrayColor])
        .masonry(^(UIView *senderView, MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.bottom.mas_equalTo(-7);
        })
        .view;
    }
    return self;
}

@end
