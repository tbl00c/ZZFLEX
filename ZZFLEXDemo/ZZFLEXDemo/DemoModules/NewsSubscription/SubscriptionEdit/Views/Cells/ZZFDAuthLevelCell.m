//
//  ZZFDAuthLevelCell.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2018/2/7.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "ZZFDAuthLevelCell.h"
#import "ZZFLEXEditModel.h"

@interface ZZFDAuthLevelCell ()

@property (nonatomic, strong) UITextField *minTF;
@property (nonatomic, strong) UITextField *maxTF;

@end

@implementation ZZFDAuthLevelCell

- (void)setViewDataModel:(ZZFLEXEditModel *)dataModel
{
    [super setViewDataModel:dataModel];
    
    self.minTF.zz_make.text(dataModel.value).placeholder(dataModel.placeholderModel);
    self.maxTF.zz_make.text(dataModel.value1).placeholder(dataModel.placeholderModel1);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.arrowView setHidden:YES];
        
        @weakify(self);
        self.maxTF = self.contentView.addTextField(1002)
        .borderWidth(BORDER_WIDTH_1PX).borderColor([UIColor colorGrayLine].CGColor).cornerRadius(2.0f)
        .font([UIFont systemFontOfSize:15]).textColor([UIColor grayColor]).textAlignment(NSTextAlignmentCenter)
        .keyboardType(UIKeyboardTypeNumberPad)
        .masonry(^ (MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(8);
            make.bottom.mas_equalTo(-8);
            make.width.mas_equalTo(self.contentView.mas_width).multipliedBy(0.2);
        })
        .eventBlock(UIControlEventEditingChanged, ^(UITextField *sender) {
            @strongify(self);
            [self.editModel setValue1:sender.text];
        })
        .view;
        
        UIView *line = self.contentView.addView(1)
        .backgroundColor([UIColor colorGrayLine])
        .masonry(^ (MASConstraintMaker *make) {
            make.right.mas_equalTo(self.maxTF.mas_left).mas_offset(-10);
            make.centerY.mas_equalTo(0);
            make.height.mas_equalTo(BORDER_WIDTH_1PX * 2);
            make.width.mas_equalTo(20);
        })
        .view;
        
        self.minTF = self.contentView.addTextField(1001)
        .borderWidth(BORDER_WIDTH_1PX).borderColor([UIColor colorGrayLine].CGColor).cornerRadius(2.0f)
        .font([UIFont systemFontOfSize:15]).textColor([UIColor grayColor]).textAlignment(NSTextAlignmentCenter)
        .keyboardType(UIKeyboardTypeNumberPad)
        .masonry(^ (MASConstraintMaker *make) {
            make.right.mas_equalTo(line.mas_left).mas_offset(-10);
            make.centerY.width.height.mas_equalTo(self.maxTF);
        })
        .eventBlock(UIControlEventEditingChanged, ^(UITextField *sender) {
            @strongify(self);
            [self.editModel setValue:sender.text];
        })
        .view;
    }
    return self;
}

@end
