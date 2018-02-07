
//
//  ZZFDPageSelectCell.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2018/2/5.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "ZZFDPageSelectCell.h"

#define     WIDTH_ICON_RIGHT        31
#define     EGDE_RIGHT_IMAGE        13
#define     EGDE_SUB_TITLE          8

@interface ZZFDPageSelectCell ()

@property (nonatomic, strong) UITextField *detailTF;

@end

@implementation ZZFDPageSelectCell

- (void)setViewDataModel:(ZZFLEXEditModel *)dataModel
{
    [super setViewDataModel:dataModel];
    [self.detailTF setPlaceholder:dataModel.placeholderModel];
    [self.detailTF setText:dataModel.value];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setSelectedBackgrounColor:[UIColor colorGrayLine]];

        self.detailTF = self.contentView.addTextField(2002)
        .textAlignment(NSTextAlignmentRight).userInteractionEnabled(NO)
        .font([UIFont systemFontOfSize:15]).textColor([UIColor grayColor])
        .masonry(^ (MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(self.arrowView.mas_left).mas_offset(-7);
            make.left.mas_greaterThanOrEqualTo(self.titleLabel.mas_right);
        })
        .view;
    }
    return self;
}



@end

