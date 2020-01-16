//
//  ZZFDMainMenuCell.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/11/28.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFDMainMenuCell.h"

@interface ZZFDMainMenuCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ZZFDMainMenuCell

#pragma mark - # ZZFlexibleLayoutViewProtocol
+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 56;
}

- (void)setViewDataModel:(id)dataModel
{
    [self.titleLabel setText:dataModel];
}

- (void)onViewPositionUpdatedWithIndexPath:(NSIndexPath *)indexPath sectionItemCount:(NSInteger)count
{
    if (indexPath.row < count - 1) {
        self.addSeparator(ZZSeparatorPositionBottom).beginAt(15).endAt(-15);
    }
    else {
        self.removeSeparator(ZZSeparatorPositionBottom);
    }
    
    CGFloat cornorRadius = 6.0f;
    if (indexPath.row == 0 && indexPath.row == count - 1) {
        self.setCornor(ZZCornerPositionAll).radius(cornorRadius);
    }
    else if (indexPath.row == 0) {
        self.setCornor(ZZCornerPositionTop).radius(cornorRadius);
    }
    else if (indexPath.row == count - 1) {
        self.setCornor(ZZCornerPositionBottom).radius(cornorRadius);
    }
    else {
        self.removeCornor();
    }
}

#pragma mark - # Cell Init
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setSelectedBackgrounColor:[UIColor colorGrayLine]];
        
        self.titleLabel = self.contentView.addLabel(1)
        .font([UIFont boldSystemFontOfSize:16])
        .textColor([UIColor blackColor])
        .masonry(^(UIView *senderView, MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
            make.right.mas_lessThanOrEqualTo(-35);
        })
        .view;
        
        self.contentView.addImageView(2)
        .image([UIImage imageNamed:@"arrow"])
        .masonry(^(UIView *senderView, MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(0);
        });
    }
    return self;
}

@end
