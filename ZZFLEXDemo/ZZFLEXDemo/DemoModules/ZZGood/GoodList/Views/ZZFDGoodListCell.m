//
//  ZZFDGoodListCell.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/11/28.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFDGoodListCell.h"
#import "UIView+ZZFLEX.h"
#import "ZZFDGoodListModel.h"

@interface ZZFDGoodListCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *positionLabel;
@property (nonatomic, strong) UILabel *lastLonginLabel;

@property (nonatomic, strong) UILabel *priceLabel;

@end

@implementation ZZFDGoodListCell

#pragma mark - # Protocol
+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 120;
}

- (void)setViewDataModel:(ZZFDGoodListModel *)dataModel
{
    [self setDataModel:dataModel];
}

- (void)setViewEventAction:(id (^)(NSInteger, id))eventAction
{
    self.eventAction = eventAction;
}

#pragma mark - # Cell
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setSelectedBackgrounColor:[UIColor colorGrayLine]];
        
        [self ui_initSubViewsToView:self.contentView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.addSeparator(ZZSeparatorPositionBottom).beginAt(15).endAt(-15);
}

- (void)setDataModel:(ZZFDGoodListModel *)dataModel
{
    _dataModel = dataModel;
    
    [self.imageView setImage:[UIImage imageNamed:dataModel.goodFirstImage]];
    [self.titleLabel setText:dataModel.goodTitle];
    
    [self.positionLabel setText:dataModel.position];
    [self.lastLonginLabel setText:dataModel.lastLoginIn];
    
    [self.priceLabel setAttributedText:dataModel.attrPrice];
}

#pragma mark - # UI
- (void)ui_initSubViewsToView:(UIView *)contentView
{
    @weakify(self);
    
    // 左侧商品图
    self.imageView = contentView.addImageView(1001)
    .contentMode(UIViewContentModeScaleAspectFill)
    .clipsToBounds(YES).cornerRadius(5)
    .masonry(^ (MASConstraintMaker *make) {
        make.left.top.mas_equalTo(15);
        make.bottom.mas_equalTo(-15);
    })
    .view;
    [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.imageView.mas_height);
    }];
    
    // 商品标题
    self.titleLabel = contentView.addLabel(1002)
    .numberOfLines(2).font([UIFont systemFontOfSize:14])
    .masonry(^ (MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageView);
        make.left.mas_equalTo(self.imageView.mas_right).mas_offset(10);
        make.right.mas_lessThanOrEqualTo(-15);
    })
    .view;
    
    // 商品位置
    self.positionLabel = contentView.addLabel(1010)
    .font([UIFont systemFontOfSize:12]).textColor([UIColor grayColor])
    .masonry(^ (MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.bottom.mas_equalTo(self.imageView);
    })
    .view;
    
    // 关闭按钮
    UIButton *closeButton = contentView.addButton(1010)
    .image([UIImage imageNamed:@"close_icon"])
    .masonry(^ (MASConstraintMaker *make) {
        make.right.mas_equalTo(-7);
        make.centerY.mas_equalTo(self.positionLabel);
        make.size.mas_equalTo(CGSizeMake(30, 40));
    })
    .eventBlock(UIControlEventTouchUpInside, ^(UIButton *sender) {
        @strongify(self);
        if (self.eventAction) {
            self.eventAction(ZZFDGoodListCellEventTypeClose, self.dataModel);
        }
    })
    .view;
    
    // 上次登录时间
    self.lastLonginLabel = contentView.addLabel(1011)
    .font([UIFont systemFontOfSize:12])
    .textColor([UIColor grayColor])
    .masonry(^ (MASConstraintMaker *make) {
        make.right.mas_equalTo(closeButton.mas_left);
        make.bottom.mas_equalTo(self.positionLabel);
    })
    .view;
    
    // 商品价格
    self.priceLabel = contentView.addLabel(1012)
    .masonry(^ (MASConstraintMaker *make) {
        make.left.mas_equalTo(self.positionLabel);
        make.bottom.mas_equalTo(self.positionLabel.mas_top).mas_offset(-3);
    })
    .view;
}

@end
