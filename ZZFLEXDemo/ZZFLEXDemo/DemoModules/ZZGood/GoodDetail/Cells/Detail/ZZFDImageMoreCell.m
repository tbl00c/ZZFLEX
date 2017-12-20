//
//  ZZFDImageMoreCell.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/12/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFDImageMoreCell.h"
#import "UIView+ZZFLEX.h"

@implementation ZZFDImageMoreCell

+ (CGSize)viewSizeByDataModel:(id)dataModel
{
    return CGSizeMake(SCREEN_WIDTH - 30, 30);
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
      
        self.addLabel(1)
        .text(@"点击查看更多")
        .font([UIFont boldSystemFontOfSize:14])
        .masonry(^ (MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        });
    }
    return self;
}

@end
