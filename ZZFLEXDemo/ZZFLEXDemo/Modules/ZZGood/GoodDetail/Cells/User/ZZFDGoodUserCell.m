
//
//  ZZFDGoodUserCell.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/12/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFDGoodUserCell.h"
#import "UIView+ZZFLEX.h"
#import "ZZFDGoodListModel.h"

@interface ZZFDGoodUserCell ()

@property (nonatomic, strong) UIView *cardView;

@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UILabel *usernameLabel;
@property (nonatomic, strong) UILabel *lastComeLabel;

@property (nonatomic, strong) UILabel *goodLabel;
@property (nonatomic, strong) UILabel *tradeLabel;
@property (nonatomic, strong) UILabel *commitLabel;
@property (nonatomic, strong) UILabel *otherLabel;

@end


@implementation ZZFDGoodUserCell

+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 180;
}

- (void)setViewDataModel:(ZZFDGoodListModel *)dataModel
{
    [self.avatarView setImage:[UIImage imageNamed:dataModel.avatar]];
    [self.usernameLabel setText:dataModel.username];
    [self.lastComeLabel setText:dataModel.lastLoginIn];
    
    NSAttributedString *(^createAttrStr)(NSString *, NSString *) = ^NSAttributedString *(NSString *a, NSString *b) {
        NSAttributedString *attrA = [[NSMutableAttributedString alloc] initWithString:[a stringByAppendingString:@"\n"]
                                                                           attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:25],
                                                                                        NSForegroundColorAttributeName : [UIColor blackColor]
                                                                                        }];
        
        NSAttributedString *attrB = [[NSMutableAttributedString alloc] initWithString:b
                                                                           attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12],
                                                                                        NSForegroundColorAttributeName : [UIColor grayColor]

                                                                                        }];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:attrA];
        [attributedString appendAttributedString:attrB];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:2];
        [paragraphStyle setAlignment:NSTextAlignmentCenter];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedString.string.length)];
        return attributedString;
    };
    if (!dataModel.attrGood) {
        dataModel.attrGood = createAttrStr(@(dataModel.goodCount).stringValue, @"在售宝贝");
        dataModel.attrTrade = createAttrStr(@(dataModel.tradeCount).stringValue, @"累计交易");
        dataModel.attrCommit = createAttrStr(dataModel.commitCount > 0 ? @(dataModel.commitCount).stringValue : @"-", @"回复率");
        dataModel.attrZhima = createAttrStr(dataModel.zhimaCount > 0 ? @(dataModel.zhimaCount).stringValue : @"-", @"芝麻信用");
    }
    [self.goodLabel setAttributedText:dataModel.attrGood];
    [self.tradeLabel setAttributedText:dataModel.attrTrade];
    [self.commitLabel setAttributedText:dataModel.attrTrade];
    [self.otherLabel setAttributedText:dataModel.attrZhima];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor colorGrayBG]];
        
        self.cardView = self.contentView.addView(1)
        .backgroundColor([UIColor whiteColor])
        .cornerRadius(3)
        .masonry(^ (MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(15, 15, 15, 15));
        })
        .view;
     
        self.avatarView = self.cardView.addImageView(2)
        .cornerRadius(21)
        .masonry(^ (MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(18);
            make.size.mas_equalTo(42);
        })
        .view;
        
        self.cardView.addImageView(1111)
        .image([UIImage imageNamed:@"arrow"])
        .masonry(^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(self.avatarView);
        });
        
        self.usernameLabel = self.cardView.addLabel(3)
        .font([UIFont boldSystemFontOfSize:15])
        .masonry(^ (MASConstraintMaker *make) {
            make.left.mas_equalTo(self.avatarView.mas_right).mas_offset(12);
            make.top.mas_equalTo(self.avatarView).mas_offset(0.5);
            make.right.mas_lessThanOrEqualTo(-15);
        })
        .view;
        
        self.lastComeLabel = self.cardView.addLabel(4)
        .font([UIFont systemFontOfSize:13])
        .textColor([UIColor grayColor])
        .masonry(^ (MASConstraintMaker *make) {
            make.left.mas_equalTo(self.usernameLabel);
            make.bottom.mas_equalTo(self.avatarView).mas_offset(-1);
            make.right.mas_lessThanOrEqualTo(-15);
        })
        .view;
        
        self.goodLabel = self.cardView.addLabel(5)
        .numberOfLines(2)
        .masonry(^ (MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-15);
            make.left.mas_equalTo(0);
            make.height.mas_equalTo(60);
        })
        .view;
        
        self.tradeLabel = self.cardView.addLabel(6)
        .numberOfLines(2)
        .masonry(^ (MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.goodLabel);
            make.left.mas_equalTo(self.goodLabel.mas_right);
            make.size.mas_equalTo(self.goodLabel);
        })
        .view;
        
        self.commitLabel = self.cardView.addLabel(7)
        .numberOfLines(2)
        .masonry(^ (MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.goodLabel);
            make.left.mas_equalTo(self.tradeLabel.mas_right);
            make.size.mas_equalTo(self.tradeLabel);
        })
        .view;
        
        self.otherLabel = self.cardView.addLabel(8)
        .numberOfLines(2)
        .masonry(^ (MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.goodLabel);
            make.left.mas_equalTo(self.commitLabel.mas_right);
            make.right.mas_equalTo(0);
            make.size.mas_equalTo(self.commitLabel);
        })
        .view;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.cardView.addSeparator(ZZSeparatorPositionTop).offset(70).beginAt(15).length(SCREEN_WIDTH - 60);
}

@end
