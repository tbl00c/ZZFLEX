//
//  ZZFDRQSuccessCell.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2018/1/24.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "ZZFDRQSuccessCell.h"
#import "UIView+ZZFLEX.h"

@implementation ZZFDRQSuccessCell

+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 180;
}

- (void)setViewDataModel:(UIColor *)dataModel
{
    [self setBackgroundColor:dataModel];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        self.contentView.addLabel(1001)
        .text(@"请求成功").font([UIFont systemFontOfSize:15])
        .masonry(^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
        });
    }
    return self;
}

@end
