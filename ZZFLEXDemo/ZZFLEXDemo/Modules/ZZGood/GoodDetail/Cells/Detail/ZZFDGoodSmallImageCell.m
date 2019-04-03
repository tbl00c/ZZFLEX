//
//  ZZFDGoodSmallImageCell.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/12/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFDGoodSmallImageCell.h"
#import "UIView+ZZFLEX.h"

@interface ZZFDGoodSmallImageCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ZZFDGoodSmallImageCell

+ (CGSize)viewSizeByDataModel:(id)dataModel
{
    CGFloat width = (SCREEN_WIDTH - 40) / 2;
    return CGSizeMake(width, width);
}

- (void)setViewDataModel:(NSString *)dataModel
{
    if (dataModel == nil) {
        [self.imageView setBackgroundColor:[UIColor clearColor]];
        [self.imageView setImage:nil];
    }
    else if (dataModel.length > 0) {
        [self.imageView setBackgroundColor:[UIColor clearColor]];
        [self.imageView setImage:[UIImage imageNamed:dataModel]];
    }
    else {
        [self.imageView setBackgroundColor:[UIColor colorGrayBG]];
        [self.imageView setImage:nil];
    }
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        self.imageView = self.contentView.addImageView(1)
        .cornerRadius(6)
        .contentMode(UIViewContentModeScaleAspectFill)
        .clipsToBounds(YES)
        .masonry(^(MASConstraintMaker *make){
            make.edges.mas_equalTo(0);
        })
        .view;
    }
    return self;
}

@end
