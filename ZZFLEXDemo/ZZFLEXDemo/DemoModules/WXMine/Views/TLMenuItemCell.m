//
//  TLMenuItemCell.m
//  TLChat
//
//  Created by 李伯坤 on 2017/7/17.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLMenuItemCell.h"
#import "UIView+ZZFLEX.h"
#import "TLMenuItem.h"
#import "TLBadge.h"

#define     WIDTH_ICON_RIGHT        31
#define     EGDE_RIGHT_IMAGE        13
#define     EGDE_SUB_TITLE          8

@interface TLMenuItemCell ()

/// 左侧icon
@property (nonatomic, strong) UIImageView *iconView;
/// 左侧标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 红点
@property (nonatomic, strong) TLBadge *badgeView;

/// 右侧副标题
@property (nonatomic, strong) UILabel *detailLabel;
/// 右侧广告图
@property (nonatomic, strong) UIImageView *rightImageView;
/// 右侧广告图红点
@property (nonatomic, strong) TLBadge *rightBadgeView;
/// 右箭头
@property (nonatomic, strong) UIImageView *arrowView;

@end

@implementation TLMenuItemCell

#pragma mark - # Protocol
+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 44.0f;
}

- (void)setViewDataModel:(id)dataModel
{
    [self setMenuItem:dataModel];
}

- (void)viewIndexPath:(NSIndexPath *)indexPath sectionItemCount:(NSInteger)count
{
    if (indexPath.row == 0) {
        self.addSeparator(ZZSeparatorPositionTop);
    }
    else {
        self.removeSeparator(ZZSeparatorPositionTop);
    }
    if (indexPath.row == count - 1) {
        self.addSeparator(ZZSeparatorPositionBottom);
    }
    else {
        self.addSeparator(ZZSeparatorPositionBottom).beginAt(15);
    }
}

#pragma mark - # Public Methods
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setSelectedBackgrounColor:[UIColor colorGrayLine]];
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.badgeView];
        [self.contentView addSubview:self.detailLabel];
        [self.contentView addSubview:self.rightImageView];
        [self.contentView addSubview:self.arrowView];
        
        [self p_addMasonry];
    }
    return self;
}

- (void)setMenuItem:(TLMenuItem *)menuItem
{
    _menuItem = menuItem;
    
    // icon
    [self.iconView setImage:[UIImage imageNamed:menuItem.iconName]];
    
    // 标题
    [self.titleLabel setText:menuItem.title];
    
    // 气泡
    [self.badgeView setHidden:YES];
    if (menuItem.badge) {
        [self.badgeView setHidden:NO];
        [self.badgeView setBadgeValue:menuItem.badge];
        [self.badgeView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(menuItem.badgeSize);
        }];
    }
    else {
        [self.badgeView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(0);
        }];
    }
    
    // 右侧说明
    [self.detailLabel setText:menuItem.subTitle];
}

#pragma mark - # Private Methods
- (void)p_addMasonry
{
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.0f);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(25.0f);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(self.iconView.mas_right).mas_offset(15.0f);
        make.right.mas_lessThanOrEqualTo(self.contentView).mas_offset(15.0f);
    }];
    [self.badgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right).mas_offset(15);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(18);
    }];
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.arrowView.mas_left).mas_offset(-EGDE_RIGHT_IMAGE);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(WIDTH_ICON_RIGHT);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_greaterThanOrEqualTo(self.badgeView.mas_right).mas_offset(15);
        make.right.mas_equalTo(self.arrowView.mas_left).mas_offset(-WIDTH_ICON_RIGHT - EGDE_RIGHT_IMAGE - EGDE_SUB_TITLE);
        make.centerY.mas_equalTo(self.iconView);
    }];
    [self.arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(8, 13));
        make.right.mas_equalTo(-15);
    }];
}

#pragma mark - # Getters
- (UIImageView *)iconView
{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
    }
    return _titleLabel;
}

- (TLBadge *)badgeView
{
    if (!_badgeView) {
        _badgeView = [[TLBadge alloc] initWithFrame:CGRectMake(0, 0, 0, 18)];
    }
    return _badgeView;
}

- (UILabel *)detailLabel
{
    if (_detailLabel == nil) {
        _detailLabel = [[UILabel alloc] init];
        [_detailLabel setTextColor:[UIColor grayColor]];
        [_detailLabel setFont:[UIFont systemFontOfSize:14.0f]];
    }
    return _detailLabel;
}

- (TLBadge *)rightBadgeView
{
    if (!_rightBadgeView) {
        _rightBadgeView = [[TLBadge alloc] initWithFrame:CGRectMake(0, 0, 0, 18)];
        [_rightBadgeView setBadgeValue:@""];
    }
    return _rightBadgeView;
}

- (UIImageView *)arrowView
{
    if (!_arrowView) {
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right_arrow"]];
    }
    return _arrowView;
}

@end
