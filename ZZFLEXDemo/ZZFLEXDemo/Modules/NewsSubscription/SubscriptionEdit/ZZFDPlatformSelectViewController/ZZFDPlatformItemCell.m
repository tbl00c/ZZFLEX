//
//  ZZFDPlatformItemCell.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2018/2/5.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "ZZFDPlatformItemCell.h"
#import "ZZFDPlatformItemModel.h"

@interface ZZFDPlatformItemCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *selectedView;

@end

@implementation ZZFDPlatformItemCell

+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 50.0f;
}

- (void)setViewDataModel:(ZZFDPlatformItemModel *)dataModel
{
    [self.titleLabel setText:dataModel.title];
    [self.selectedView setHidden:!dataModel.selected];
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

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        self.titleLabel = self.addLabel(1)
        .font([UIFont systemFontOfSize:15])
        .masonry(^(UIView *senderView, MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
            make.width.mas_greaterThanOrEqualTo(100);
        })
        .view;
        
        self.selectedView = self.addImageView(2)
        .image([UIImage imageNamed:@"selected"])
        .hidden(YES)
        .masonry(^(UIView *senderView, MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(0);
        })
        .view;
    }
    return self;
}

@end
