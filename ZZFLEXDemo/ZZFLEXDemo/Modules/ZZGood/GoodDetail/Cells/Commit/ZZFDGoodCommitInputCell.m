//
//  ZZFDGoodCommitInputCell.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/12/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFDGoodCommitInputCell.h"
#import "UIView+ZZFLEX.h"

@interface ZZFDGoodCommitInputCell ()

@property (nonatomic, copy) id (^eventAction)(NSInteger type, id data);

@end

@implementation ZZFDGoodCommitInputCell

+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 56;
}

- (void)setViewEventAction:(id (^)(NSInteger, id))eventAction
{
    self.eventAction = eventAction;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        UIButton *cardView = self.addButton(0)
        .cornerRadius(3)
        .clipsToBounds(YES)
        .masonry(^ (MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
        })
        .eventBlock(UIControlEventTouchUpInside, ^(UIButton *sender) {
            if (self.eventAction) {
                self.eventAction(0, nil);
            }
        })
        .view;
        
        UILabel *label = cardView.addLabel(1)
        .text(@"  有想法就说，看对眼就上~")
        .font([UIFont systemFontOfSize:14])
        .textColor([UIColor grayColor])
        .backgroundColor([UIColor colorGrayBG])
        .masonry(^ (MASConstraintMaker *make) {
            make.top.left.bottom.mas_equalTo(0);
        })
        .view;
        
        cardView.addButton(0)
        .title(@"留言")
        .titleFont([UIFont systemFontOfSize:16])
        .titleColor([UIColor whiteColor])
        .backgroundColor([UIColor redColor])
        .userInteractionEnabled(NO)
        .masonry(^ (MASConstraintMaker *make) {
            make.top.right.bottom.mas_equalTo(0);
            make.width.mas_equalTo(80);
            make.left.mas_equalTo(label.mas_right);
        });
    }
    return self;
}

@end
