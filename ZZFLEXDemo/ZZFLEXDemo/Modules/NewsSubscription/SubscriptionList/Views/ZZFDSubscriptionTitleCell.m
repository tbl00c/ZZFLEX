//
//  ZZFDSubscriptionTitleCell.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2018/2/7.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "ZZFDSubscriptionTitleCell.h"
#import "TLMenuItem.h"

#define     WIDTH_ICON_RIGHT        31
#define     EGDE_RIGHT_IMAGE        13
#define     EGDE_SUB_TITLE          8

@interface ZZFDSubscriptionTitleCell ()

/// 左侧icon
@property (nonatomic, strong) UIImageView *iconView;
/// 左侧标题
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ZZFDSubscriptionTitleCell

#pragma mark - # Protocol
+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 45.0f;
}

- (void)setViewDataModel:(id)dataModel
{
    [self setMenuItem:dataModel];
}

- (void)onViewPositionUpdatedWithIndexPath:(NSIndexPath *)indexPath sectionItemCount:(NSInteger)count
{
    self.addSeparator(ZZSeparatorPositionTop);
    self.addSeparator(ZZSeparatorPositionBottom);
}

#pragma mark - # Public Methods
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];

        self.iconView = self.contentView.addImageView(1)
        .masonry(^(UIView *senderView, MASConstraintMaker *make) {
            make.left.mas_equalTo(15.0f);
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(25.0f);
        })
        .view;
        
        self.titleLabel = self.contentView.addLabel(2)
        .masonry(^(UIView *senderView, MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(self.iconView.mas_right).mas_offset(15.0f);
            make.right.mas_lessThanOrEqualTo(self.contentView).mas_offset(15.0f);
        })
        .view;
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
}

@end
