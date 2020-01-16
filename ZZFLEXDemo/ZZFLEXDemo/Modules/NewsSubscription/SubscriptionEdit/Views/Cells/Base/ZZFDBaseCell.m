//
//  ZZFDBaseCell.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2018/2/5.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "ZZFDBaseCell.h"

@interface ZZFDBaseCell ()

@end

@implementation ZZFDBaseCell

+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 45.0f;
}

- (void)setViewDataModel:(ZZFLEXEditModel *)dataModel
{
    self.editModel = dataModel;
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
        
        _arrowView = self.addImageView(0).image([UIImage imageNamed:@"right_arrow"])
        .masonry(^(UIView *senderView, MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(8, 13));
            make.right.mas_equalTo(-15);
        }).view;
    }
    return self;
}

@end
