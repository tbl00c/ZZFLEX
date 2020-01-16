//
//  ZZFDSwitchCell.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2018/2/7.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "ZZFDSwitchCell.h"

@interface ZZFDSwitchCell ()

@property (nonatomic, strong) UISwitch *switchControl;

@end

@implementation ZZFDSwitchCell

- (void)setViewDataModel:(ZZFLEXEditModel *)dataModel
{
    [super setViewDataModel:dataModel];
    
    BOOL on = [dataModel.value boolValue];
    [self.switchControl setOn:on];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.arrowView setHidden:YES];
        
        @weakify(self);
        self.switchControl = self.addSwitch(1001)
        .masonry(^(UIView *senderView, MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(0);
        })
        .eventBlock(UIControlEventValueChanged, ^(UISwitch *sender) {
            @strongify(self);
            self.editModel.value = @(sender.on);
        })
        .view;
    }
    
    return self;
}

@end
