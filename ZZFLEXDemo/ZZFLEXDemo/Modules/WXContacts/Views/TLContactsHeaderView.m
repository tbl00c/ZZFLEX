//
//  TLContactsHeaderView.m
//  TLChat
//
//  Created by 李伯坤 on 16/1/26.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLContactsHeaderView.h"

@interface TLContactsHeaderView ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation TLContactsHeaderView

+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 30.0f;
}

- (void)setViewDataModel:(id)dataModel
{
    [self setTitle:dataModel];
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        UIView *bgView = [UIView new];
        [bgView setBackgroundColor:RGBAColor(239.0, 239.0, 244.0, 1.0)];
        [self setBackgroundView:bgView];
        
        self.titleLabel = self.contentView.addLabel(1)
        .font([UIFont systemFontOfSize:14])
        .textColor([UIColor grayColor])
        .view;
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
            make.right.mas_lessThanOrEqualTo(-15);
        }];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    [_titleLabel setText:title];
}

@end
