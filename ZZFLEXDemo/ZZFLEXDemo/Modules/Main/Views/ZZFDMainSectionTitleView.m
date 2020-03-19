//
//  ZZFDMainSectionTitleView.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/12/16.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFDMainSectionTitleView.h"

@interface ZZFDMainSectionTitleView ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ZZFDMainSectionTitleView

+ (CGFloat)viewHeightByDataModel:(NSAttributedString *)dataModel
{
    CGFloat height = [dataModel boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 30, MAXFLOAT)
                                             options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                             context:nil].size.height;
    return height + 35;
}

- (void)setViewDataModel:(id)dataModel
{
    [self.titleLabel setAttributedText:dataModel];
}

#pragma mark - # Cell Init
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel = self.addLabel(1).numberOfLines(0)
        .masonry(^(UIView *senderView, MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_lessThanOrEqualTo(-15);
            make.top.mas_equalTo(20);
        })
        .view;
    }
    return self;
}
@end
