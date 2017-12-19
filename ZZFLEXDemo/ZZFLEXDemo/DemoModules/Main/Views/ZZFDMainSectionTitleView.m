//
//  ZZFDMainSectionTitleView.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/12/16.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFDMainSectionTitleView.h"
#import "UIView+ZZFLEX.h"

@interface ZZFDMainSectionTitleView ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ZZFDMainSectionTitleView

+ (CGSize)viewSizeByDataModel:(NSString *)dataModel
{
    return CGSizeMake(SCREEN_WIDTH, 35);
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
        .font([UIFont systemFontOfSize:16])
        .textColor([UIColor darkGrayColor])
        .masonry(^ (MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.bottom.mas_equalTo(-5);
        })
        .view;
    }
    return self;
}
@end
