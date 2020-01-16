//
//  WXUserHeaderCell.m
//  WXUser
//
//  Created by libokun on 2020/1/7.
//

#import "WXUserHeaderCell.h"
#import "TLUser.h"

@interface WXUserHeaderCell ()

@property (nonatomic, strong) UIImageView *avatarImageView;

@property (nonatomic, strong) UILabel *nikenameLabel;

@property (nonatomic, strong) UILabel *wechatIDLabel;

@property (nonatomic, strong) UIImageView *QRImageView;

/// 右箭头
@property (nonatomic, strong) UIImageView *arrowView;

@end

@implementation WXUserHeaderCell

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
        
        [self p_initSubViews];
    }
    return self;
}

- (void)setUser:(TLUser *)user
{
    _user = user;
    [self.avatarImageView setImage:[UIImage imageNamed:user.avatar]];

    [self.nikenameLabel setText:user.username];
    [self.wechatIDLabel setText:[LOCSTR(@"微信号：") stringByAppendingString:user.userID ? user.userID : @"未设置"]];
}

#pragma mark - # Private Methods
- (void)p_initSubViews
{
    self.avatarImageView = self.contentView.addImageView(1).cornerRadius(5.0f).view;
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(32);
        make.height.mas_equalTo(62);
        make.width.mas_equalTo(self.avatarImageView.mas_height);
    }];

    self.nikenameLabel = self.contentView.addLabel(2)
    .text(@"用户昵称").font([UIFont boldSystemFontOfSize:22])
    .view;
    [self.nikenameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarImageView.mas_right).mas_offset(15);
        make.top.mas_equalTo(self.avatarImageView).mas_offset(2.0f);
    }];
    [self.nikenameLabel setContentCompressionResistancePriority:100 forAxis:UILayoutConstraintAxisHorizontal];
    

    self.wechatIDLabel = self.contentView.addLabel(3)
    .text(@"微信号").font([UIFont systemFontOfSize:17]).textColor([UIColor darkGrayColor])
    .view;
    [self.wechatIDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nikenameLabel);
        make.top.mas_equalTo(self.nikenameLabel.mas_bottom).mas_offset(8.0);
    }];
}


@end
