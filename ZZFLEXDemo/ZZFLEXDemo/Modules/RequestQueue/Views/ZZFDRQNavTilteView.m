//
//  ZZFDRQNavTilteView.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2018/2/3.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "ZZFDRQNavTilteView.h"

@interface ZZFDRQNavTilteView ()

@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ZZFDRQNavTilteView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:self.activityView];
        [self.activityView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(0);
        }];
        self.titleLabel = self.addLabel(2)
        .font([UIFont boldSystemFontOfSize:16])
        .textAlignment(NSTextAlignmentCenter)
        .masonry(^(UIView *senderView, MASConstraintMaker *make) {
            make.top.bottom.right.mas_equalTo(0);
            make.left.mas_equalTo(self.activityView.mas_right);
        })
        .view;
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    [self.titleLabel setText:title];
}

- (void)setShowActivity:(BOOL)showActivity
{
    _showActivity = showActivity;
    if (showActivity) {
        [self.activityView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(35);
        }];
        [self.activityView startAnimating];
    }
    else {
        [self.activityView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
        }];
        [self.activityView stopAnimating];
    }
}

@end
