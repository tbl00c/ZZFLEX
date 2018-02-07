//
//  TLMineHeaderCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/6.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMineHeaderCell.h"
#import "UIView+ZZFLEX.h"

#define     MINE_SPACE_X        14.0f
#define     MINE_SPACE_Y        12.0f

@interface TLMineHeaderCell ()

@property (nonatomic, strong) UIImageView *avatarImageView;

@property (nonatomic, strong) UILabel *nikenameLabel;

@property (nonatomic, strong) UILabel *wechatIDLabel;

@property (nonatomic, strong) UIImageView *QRImageView;

/// 右箭头
@property (nonatomic, strong) UIImageView *arrowView;

@end

@implementation TLMineHeaderCell

#pragma mark - # Protocol
+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 90;
}

- (void)setViewDataModel:(id)dataModel
{
    [self setUser:dataModel];
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
        
        [self p_initSubViews];
    }
    return self;
}

- (void)setUser:(TLUser *)user
{
    _user = user;
    [self.avatarImageView setImage:[UIImage imageNamed:user.avatar]];

    [self.nikenameLabel setText:user.username];
    [self.wechatIDLabel setText:user.userID ? [LOCSTR(@"微信号：") stringByAppendingString:user.userID] : @""];
}

#pragma mark - # Private Methods
- (void)p_initSubViews
{
    self.avatarImageView = self.contentView.addImageView(1)
    .cornerRadius(5.0f).border(BORDER_WIDTH_1PX, [UIColor lightGrayColor])
    .masonry(^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MINE_SPACE_X);
        make.top.mas_equalTo(MINE_SPACE_Y);
        make.bottom.mas_equalTo(- MINE_SPACE_Y);
        
    })
    .view;
    [self.avatarImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.avatarImageView.mas_height);
    }];

    self.nikenameLabel = self.contentView.addLabel(2)
    .text(@"用户昵称").font([UIFont systemFontOfSize:17])
    .masonry(^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarImageView.mas_right).mas_offset(MINE_SPACE_Y);
        make.bottom.mas_equalTo(self.avatarImageView.mas_centerY).mas_offset(-3.5);
    })
    .view;
    [self.nikenameLabel setContentCompressionResistancePriority:100 forAxis:UILayoutConstraintAxisHorizontal];
    

    self.wechatIDLabel = self.contentView.addLabel(3)
    .text(@"微信号").font([UIFont systemFontOfSize:14])
    .masonry(^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nikenameLabel);
        make.top.mas_equalTo(self.avatarImageView.mas_centerY).mas_offset(5.0);
    })
    .view;
    

    self.arrowView = self.contentView.addImageView(4)
    .image([UIImage imageNamed:@"right_arrow"])
    .masonry(^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(8, 13));
        make.right.mas_equalTo(-15);
    })
    .view;
    
    self.QRImageView = self.contentView.addImageView(5)
    .image([UIImage imageNamed:@"mine_cell_myQR"])
    .masonry(^ (MASConstraintMaker *make) {
        make.centerY.mas_equalTo(-0.5);
        make.right.mas_equalTo(self.arrowView.mas_left).mas_offset(-10);
        make.height.and.width.mas_equalTo(18);
    })
    .view;
}

@end
