//
//  ZZFDTextFieldCell.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2018/2/4.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "ZZFDTextFieldCell.h"

@interface ZZFDTextFieldCell ()

@property (nonatomic, strong) UITextField *textField;

@end

@implementation ZZFDTextFieldCell

- (void)setViewDataModel:(ZZFLEXEditModel *)dataModel
{
    [super setViewDataModel:dataModel];
    
    [self.textField setPlaceholder:dataModel.placeholderModel];
    [self.textField setText:dataModel.value];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.arrowView setHidden:YES];
        
        @weakify(self);
        self.textField = self.contentView.addTextField(1001)
        .font([UIFont systemFontOfSize:15])
        .textAlignment(NSTextAlignmentRight)
        .masonry(^(UIView *senderView, MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.top.bottom.mas_equalTo(0);
            make.left.mas_equalTo(self.titleLabel.mas_right).mas_offset(20);
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
