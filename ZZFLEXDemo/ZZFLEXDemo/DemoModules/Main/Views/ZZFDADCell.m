//
//  ZZFDADCell.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/11/28.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFDADCell.h"
#import "UIView+ZZFLEX.h"

#define     HEIGHT_AD_IMAGE     38

@implementation ZZFDADCell

+ (CGSize)viewSizeByDataModel:(id)dataModel
{
    return CGSizeMake(SCREEN_WIDTH, HEIGHT_AD_IMAGE + 20);
}

- (void)setViewEventAction:(id (^)(NSInteger, id))eventAction
{
    [self setEventAction:eventAction];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        @weakify(self);
        self.contentView.addButton(1001)
        .backgroundImage([UIImage imageNamed:@"zz_icon"])
        .cornerRadius(HEIGHT_AD_IMAGE / 2.0)
        .masonry(^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
            make.size.mas_equalTo(HEIGHT_AD_IMAGE);
        })
        .eventBlock(UIControlEventTouchUpInside, ^(UIButton *sender) {
            @strongify(self);
            if (self.eventAction) {
                self.eventAction(0, nil);
            }
        });
    }
    return self;
}

@end
