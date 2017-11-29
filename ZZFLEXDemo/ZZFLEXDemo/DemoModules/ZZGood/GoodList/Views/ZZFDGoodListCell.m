//
//  ZZFDGoodListCell.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/11/28.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFDGoodListCell.h"
#import "UIView+ZZFLEX.h"

@interface ZZFDGoodListCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;




@end

@implementation ZZFDGoodListCell

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        self.imageView = self.contentView.addImageView(1001)
        .masonry(^ (MASConstraintMaker *make) {
            make.left.top.mas_equalTo(15);
            make.bottom.mas_equalTo(-15);
            make.width.mas_equalTo(self.imageView.mas_height);
        })
        .view;
        
        self.titleLabel = self.contentView.addLabel(1002)
        .numberOfLines(2)
        .masonry(^ (MASConstraintMaker *make) {
            make.top.mas_equalTo(self.imageView);
            make.left.mas_equalTo(self.imageView.mas_right).mas_offset(10);
            make.right.mas_lessThanOrEqualTo(-15);
        })
        .view;
        
    }
    return self;
}

@end
