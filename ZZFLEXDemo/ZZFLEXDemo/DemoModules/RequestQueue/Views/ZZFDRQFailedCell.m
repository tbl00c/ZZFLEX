//
//  ZZFDRQFailedCell.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2018/1/24.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "ZZFDRQFailedCell.h"
#import "UIView+ZZFLEX.h"

@interface ZZFDRQFailedCell ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end

@implementation ZZFDRQFailedCell

+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 180;
}

- (void)setViewDataModel:(ZZFDRQFailedModel *)dataModel
{
    self.model = dataModel;
    
    [self p_updateUI];
}

- (void)setViewEventAction:(id (^)(NSInteger, id))eventAction
{
    self.eventAction = eventAction;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.indicatorView];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(-22);
            make.centerX.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.imageView.mas_bottom).mas_offset(18);
            make.centerX.mas_equalTo(0);
        }];
        
        [self.indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapView)];
        [self.contentView addGestureRecognizer:tapGR];
    }
    return self;
}

- (void)didTapView
{
    if (!self.model.loading) {
        self.model.loading = YES;
        [self p_updateUI];
        if (self.eventAction) {
            self.eventAction(0, self.model);
        }
    }
}

#pragma mark - # Private Methods
- (void)p_updateUI
{
    if (self.model.loading) {
        [self.imageView setHidden:YES];
        [self.titleLabel setHidden:YES];
        [self.indicatorView startAnimating];
    }
    else {
        [self.imageView setHidden:NO];
        [self.titleLabel setHidden:NO];
        [self.indicatorView stopAnimating];
    }
}

#pragma mark - # Getter
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        [_imageView setImage:[UIImage imageNamed:@"request_failed"]];
    }
    return _imageView;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setText:@"加载失败，请点击重试！"];
        [_titleLabel setTextColor:[UIColor lightGrayColor]];
        [_titleLabel setFont:[UIFont systemFontOfSize:14]];
    }
    return _titleLabel;
}

- (UIActivityIndicatorView *)indicatorView
{
    if (_indicatorView == nil) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _indicatorView;
}

@end


@implementation ZZFDRQFailedModel

+ (instancetype)createModelWithLoading:(BOOL)loading;
{
    ZZFDRQFailedModel *model = [[ZZFDRQFailedModel alloc] init];
    model.loading = loading;
    return model;
}

@end

