//
//  TLMineHeaderCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/6.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMineHeaderCell.h"

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
    return 132;
}

- (void)setViewDataModel:(id)dataModel
{
    [self setUser:dataModel];
}

- (void)onViewPositionUpdatedWithIndexPath:(NSIndexPath *)indexPath sectionItemCount:(NSInteger)count
{
    self.addSeparator(ZZSeparatorPositionBottom);
}

#pragma mark - # Public Methods
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        
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
    .cornerRadius(5.0f)
    .masonry(^(UIView *senderView, MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(32);
        make.height.mas_equalTo(62);
        make.width.mas_equalTo(senderView.mas_height);
    })
    .view;
    [self.avatarImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.avatarImageView.mas_height);
    }];

    self.nikenameLabel = self.contentView.addLabel(2)
    .text(@"用户昵称").font([UIFont boldSystemFontOfSize:22])
    .masonry(^(UIView *senderView, MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarImageView.mas_right).mas_offset(15);
        make.top.mas_equalTo(self.avatarImageView).mas_offset(2.0f);
    })
    .view;
    [self.nikenameLabel setContentCompressionResistancePriority:100 forAxis:UILayoutConstraintAxisHorizontal];
    

    self.wechatIDLabel = self.contentView.addLabel(3)
    .text(@"微信号").font([UIFont systemFontOfSize:17])
    .masonry(^(UIView *senderView, MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nikenameLabel);
        make.top.mas_equalTo(self.avatarImageView.mas_centerY).mas_offset(8.0);
    })
    .view;
    

    self.arrowView = self.contentView.addImageView(4)
    .image([UIImage imageNamed:@"right_arrow"])
    .masonry(^(UIView *senderView, MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.wechatIDLabel);
        make.size.mas_equalTo(CGSizeMake(8, 13));
        make.right.mas_equalTo(-15);
    })
    .view;
    
    self.QRImageView = self.contentView.addImageView(5)
    .image([UIImage imageNamed:@"mine_cell_myQR"])
    .masonry(^(UIView *senderView, MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.arrowView);
        make.right.mas_equalTo(self.arrowView.mas_left).mas_offset(-10);
        make.height.and.width.mas_equalTo(15);
    })
    .view;
}

@end
