//
//  ZZFDGoodCommitCell.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/12/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFDGoodCommitCell.h"
#import "ZZFDGoodListModel.h"
#import "UIView+ZZFLEX.h"

#define     GOOD_AVATAR_WIDTH               40
#define     GOOD_FONT_COMMIT_DETAIL         [UIFont systemFontOfSize:14]

@interface ZZFDGoodCommitCell ()
{
    BOOL showSeperator;
}

@property (nonatomic, strong) UIImageView *avatarView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation ZZFDGoodCommitCell

+ (CGFloat)viewHeightByDataModel:(ZZFDGoodCommitModel *)dataModel
{
    CGFloat height = [dataModel.detail tt_sizeWithFont:GOOD_FONT_COMMIT_DETAIL constrainedToSize:CGSizeMake(SCREEN_WIDTH - GOOD_AVATAR_WIDTH - 40, MAXFLOAT)].height;
    height += 50;
    return height;
}

- (void)viewIndexPath:(NSIndexPath *)indexPath sectionItemCount:(NSInteger)count
{
    if (indexPath.row == count - 1) {
        showSeperator = NO;
        self.removeSeparator(ZZSeparatorPositionBottom);
    }
    else {
        showSeperator = YES;
    }
}

- (void)setViewDataModel:(ZZFDGoodCommitModel *)dataModel
{
    [self.avatarView setImage:[UIImage imageNamed:dataModel.avatar]];
    [self.nameLabel setText:dataModel.userName];
    [self.dateLabel setText:dataModel.date];
    [self.contentLabel setText:dataModel.detail];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setSelectedBackgrounColor:[UIColor colorGrayLine]];
        
        self.avatarView = self.contentView.addImageView(1001)
        .contentMode(UIViewContentModeScaleAspectFill)
        .clipsToBounds(YES)
        .cornerRadius(GOOD_AVATAR_WIDTH / 2.0)
        .masonry(^ (MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(10);
            make.size.mas_equalTo(GOOD_AVATAR_WIDTH);
        })
        .view;
        
        self.nameLabel = self.contentView.addLabel(1002)
        .font([UIFont boldSystemFontOfSize:15])
        .masonry(^ (MASConstraintMaker *make) {
            make.top.mas_equalTo(self.avatarView).mas_offset(-1);
            make.left.mas_equalTo(self.avatarView.mas_right).mas_offset(10);
            make.right.mas_lessThanOrEqualTo(-15);
        })
        .view;
        
        self.dateLabel = self.contentView.addLabel(1003)
        .font([UIFont systemFontOfSize:13])
        .textColor([UIColor lightGrayColor])
        .masonry(^ (MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.nameLabel).mas_offset(-1);
            make.left.mas_equalTo(self.nameLabel.mas_right).mas_offset(10);
            make.right.mas_lessThanOrEqualTo(-15);
        })
        .view;
        
        self.contentLabel = self.contentView.addLabel(1004)
        .numberOfLines(0)
        .font(GOOD_FONT_COMMIT_DETAIL)
        .masonry(^ (MASConstraintMaker *make) {
            make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_offset(8);
            make.left.mas_equalTo(self.nameLabel);
            make.right.mas_lessThanOrEqualTo(-15);
        })
        .view;
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (showSeperator) {
        self.addSeparator(ZZSeparatorPositionBottom).beginAt(25 + GOOD_AVATAR_WIDTH).endAt(-15);
    }
    else {
        self.removeSeparator(ZZSeparatorPositionBottom);
    }
}

@end
