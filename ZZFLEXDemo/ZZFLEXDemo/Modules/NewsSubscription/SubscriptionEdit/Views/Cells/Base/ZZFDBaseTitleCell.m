//
//  ZZFDBaseTitleCell.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2018/2/5.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "ZZFDBaseTitleCell.h"

@implementation ZZFDBaseTitleCell

- (void)setViewDataModel:(ZZFLEXEditModel *)dataModel
{
    [super setViewDataModel:dataModel];
    
    [self.titleLabel setText:dataModel.titleModel];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel = self.addLabel(1)
        .font([UIFont systemFontOfSize:15])
        .masonry(^(UIView *senderView, MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
            make.width.mas_equalTo(100);
        })
        .view;
    }
    return self;
}


@end
