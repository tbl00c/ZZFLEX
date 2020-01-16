//
//  ZZFDCateSectionView.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/12/19.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFDCateSectionView.h"
#import "ZZFDCateModel.h"

@interface ZZFDCateSectionView ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ZZFDCateSectionView

+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 50;
}

- (void)setViewDataModel:(ZZFDCateSectionModel *)dataModel
{
    [self.titleLabel setText:[NSString stringWithFormat:@"——  %@  ——", dataModel.sectionName]];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel = self.addLabel(1)
        .font([UIFont boldSystemFontOfSize:14])
        .masonry(^(UIView *senderView, MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
        })
        .view;
    }
    return self;
}

@end
