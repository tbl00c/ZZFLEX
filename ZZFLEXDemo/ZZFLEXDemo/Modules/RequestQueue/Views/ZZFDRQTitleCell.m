//
//  ZZFDRQTitleCell.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2018/1/25.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "ZZFDRQTitleCell.h"

@interface ZZFDRQTitleCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *button;

@end

@implementation ZZFDRQTitleCell

+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 40;
}

- (void)setViewDataModel:(ZZFDRQTitleModel *)dataModel
{
    self.model = dataModel;
    [self.titleLabel setText:dataModel.title];
    [self.button setSelected:dataModel.selected];
    [self.button setUserInteractionEnabled:!dataModel.selected];
}

- (void)setViewEventAction:(id (^)(NSInteger, id))eventAction
{
    self.eventAction = eventAction;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        self.titleLabel = self.contentView.addLabel(1)
        .numberOfLines(0)
        .font([UIFont boldSystemFontOfSize:15])
        .masonry(^(UIView *senderView, MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(15);
        })
        .view;
        
        @weakify(self);
        self.button = self.contentView.addButton(2)
        .title(@"模块刷新").titleColor([UIColor blueColor]).titleFont([UIFont systemFontOfSize:14])
        .titleSelected(@"刷新中...").titleColorSelected([UIColor grayColor])
        .masonry(^(UIView *senderView, MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(self.titleLabel);
        })
        .eventBlock(UIControlEventTouchUpInside, ^(UIButton *sender) {
           @strongify(self);
            self.model.selected = YES;
            if (self.eventAction) {
                self.eventAction(0, self.model);
            }
        })
        .view;
    }
    return self;
}

@end

@implementation ZZFDRQTitleModel

+ (instancetype)createModelWithTitle:(NSString *)title
{
    ZZFDRQTitleModel *model = [[ZZFDRQTitleModel alloc] init];
    model.title = title;
    return model;
}

@end
