//
//  TLContactsItemCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/1/26.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLContactsItemCell.h"

TLContactsItemModel *createContactsItemModel(NSString *path, NSString *url, NSString *title, NSString *subTitle, id userInfo)
{
    return createContactsItemModelWithTag(0, path, url, title, subTitle, userInfo);
}

TLContactsItemModel *createContactsItemModelWithTag(NSInteger tag, NSString *path, NSString *url, NSString *title, NSString *subTitle, id userInfo)
{
    TLContactsItemModel *model = [[TLContactsItemModel alloc] init];
    model.tag = tag;
    model.imagePath = path;
    model.imageUrl = url;
    model.title = title;
    model.subTitle = subTitle;
    model.userInfo = userInfo;
    return model;
}

@interface TLContactsItemCell ()

@property (nonatomic, strong) UIImageView *avatarView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *subTitleLabel;

@property (nonatomic, assign) BOOL showSeperator;

@end

@implementation TLContactsItemCell

+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 56.0f;
}

- (void)setViewDataModel:(id)dataModel
{
    [self setModel:dataModel];
}

- (void)onViewPositionUpdatedWithIndexPath:(NSIndexPath *)indexPath sectionItemCount:(NSInteger)count
{
    self.showSeperator = (indexPath.row != count - 1);
}

#pragma mark - # Cell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_initUI];
    }
    return self;
}

- (void)setModel:(TLContactsItemModel *)model
{
    _model = model;
    
    if (model.imagePath) {
        [self.avatarView setImage:[UIImage imageNamed:model.imagePath]];
    }
    
    [self.nameLabel setText:model.title];
    [self.subTitleLabel setText:model.subTitle];
    
    if (model.subTitle.length > 0) {
        if (self.subTitleLabel.isHidden) {
            [self.subTitleLabel setHidden:NO];
            [self.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.avatarView).mas_offset(-9.5);
            }];
        }
    }
    else if (!self.subTitleLabel.isHidden){
        [self.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.avatarView);
        }];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (!self.showSeperator) {
       self.removeSeparator(ZZSeparatorPositionBottom);
    }
    else {
       self.addSeparator(ZZSeparatorPositionBottom).beginAt(39 + 27);
    }
}

#pragma mark - # Prvate Methods
- (void)p_initUI
{
    // 头像
    self.avatarView = self.contentView.addImageView(1).cornerRadius(4.0f).view;
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(8);
        make.bottom.mas_equalTo(-8);
        make.width.mas_equalTo(self.avatarView.mas_height);
    }];
    
    // 昵称
    self.nameLabel = self.contentView.addLabel(2)
    .font([UIFont systemFontOfSize:17.0f])
    .view;
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarView.mas_right).mas_offset(12);
        make.centerY.mas_equalTo(self.avatarView);
        make.right.mas_lessThanOrEqualTo(-20);
    }];
    
    // 备注
    self.subTitleLabel = self.contentView.addLabel(3)
    .font([UIFont systemFontOfSize:14.0f])
    .textColor([UIColor grayColor])
    .view;
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_offset(2);
        make.right.mas_lessThanOrEqualTo(-20);
    }];
}


@end

@implementation TLContactsItemModel

@end
