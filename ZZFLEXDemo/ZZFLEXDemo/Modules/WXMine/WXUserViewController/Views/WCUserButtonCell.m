//
//  WCUserButtonCell.m
//  WXUser
//
//  Created by libokun on 2020/1/7.
//

#import "WCUserButtonCell.h"

@interface WCUserButtonCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation WCUserButtonCell

#pragma mark - # Protocol
+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 56.0f;
}

- (void)setViewDataModel:(NSString *)dataModel
{
    [self.titleLabel setText:dataModel];
}

- (void)viewIndexPath:(NSIndexPath *)indexPath sectionItemCount:(NSInteger)count
{
    if (indexPath.row == 0) {
        self.addSeparator(ZZSeparatorPositionTop);
    }
    else {
        self.removeSeparator(ZZSeparatorPositionTop);
    }
    self.addSeparator(ZZSeparatorPositionBottom);
}

#pragma mark - # Public Methods
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setSelectedBackgrounColor:[UIColor colorWithWhite:0.5 alpha:0.3]];
        
        self.titleLabel = self.contentView.addLabel(1)
        .textColor(RGBColor(101, 107, 141)).font([UIFont boldSystemFontOfSize:17])
        .view;
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           make.center.mas_equalTo(0);
           make.width.mas_lessThanOrEqualTo(self.contentView);
        }];
    }
    return self;
}

@end
