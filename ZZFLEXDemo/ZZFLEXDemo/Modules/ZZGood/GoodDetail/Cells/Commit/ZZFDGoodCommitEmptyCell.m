
//
//  ZZFDGoodCommitEmptyCell.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/12/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFDGoodCommitEmptyCell.h"

@interface ZZFDGoodCommitEmptyCell ()

@property (nonatomic, strong) UIButton *button;

@property (nonatomic, copy) id (^eventAction)(NSInteger type, id data);

@end

@implementation ZZFDGoodCommitEmptyCell

+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 180;
}

- (void)setViewEventAction:(id (^)(NSInteger, id))eventAction
{
    self.eventAction = eventAction;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        UILabel *label = self.addLabel(1)
        .text(@"暂无互动信息哦~")
        .font([UIFont systemFontOfSize:15])
        .masonry(^(UIView *senderView, MASConstraintMaker *make) {
            make.top.mas_equalTo(45);
            make.centerX.mas_equalTo(0);
        })
        .view;
        
        self.button = self.contentView.addButton(0)
        .title(@"点击问一问")
        .titleFont([UIFont systemFontOfSize:16])
        .titleColor([UIColor whiteColor])
        .backgroundColor([UIColor redColor])
        .cornerRadius(3)
        .masonry(^(UIView *senderView, MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(label.mas_bottom).mas_offset(20);
            make.size.mas_equalTo(CGSizeMake(120, 35));
        })
        .eventBlock(UIControlEventTouchUpInside, ^(UIButton *sender) {
            if (self.eventAction) {
                self.eventAction(0, nil);
            }
        })
        .view;
    }
    return self;
}

@end
