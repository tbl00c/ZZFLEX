//
//  ZZFDSubscriptionCell.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2018/2/4.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "ZZFDSubscriptionCell.h"
#import "UIView+ZZFLEX.h"
#import "ZZFLEXAngel.h"
#import "ZZFDSubscriptionModel.h"

#pragma mark - ## ZZFDSubscriptionItemCell
#define     WIDTH_SUB_ITEM_KEY      100
#define     FONT_SUB_ITEM           [UIFont systemFontOfSize:15]
@interface ZZFDSubscriptionItemCell : UITableViewCell <ZZFlexibleLayoutViewProtocol>

@property (nonatomic, strong) UILabel *keyLabel;
@property (nonatomic, strong) UILabel *valueLabel;

@end

@implementation ZZFDSubscriptionItemCell

+ (CGFloat)viewHeightByDataModel:(ZZFDSubscriptionListShowModel *)dataModel
{
    CGFloat width = SCREEN_WIDTH - 30 - WIDTH_SUB_ITEM_KEY;
    CGFloat hegiht = [TLNoNilString(dataModel.detail) tt_sizeWithFont:FONT_SUB_ITEM constrainedToWidth:width].height;
    return hegiht + 10;
}

- (void)setViewDataModel:(ZZFDSubscriptionListShowModel *)dataModel
{
    [self.keyLabel setText:dataModel.title];
    [self.valueLabel setText:dataModel.detail];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        self.keyLabel = self.contentView.addLabel(1)
        .font(FONT_SUB_ITEM).textColor([UIColor darkGrayColor])
        .masonry(^ (MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(5);
            make.width.mas_equalTo(WIDTH_SUB_ITEM_KEY);
        })
        .view;
        
        self.valueLabel = self.contentView.addLabel(2)
        .font(FONT_SUB_ITEM).textColor([UIColor grayColor])
        .numberOfLines(0)
        .masonry(^ (MASConstraintMaker *make) {
            make.left.mas_equalTo(self.keyLabel.mas_right);
            make.top.mas_equalTo(self.keyLabel);
            make.right.mas_lessThanOrEqualTo(-15);
        })
        .view;
    }
    return self;
}

@end

#pragma mark - ## ZZFDSubscriptionCell
#define     TOP_SPACE_FD_SUB_CELL       10
@interface ZZFDSubscriptionCell ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZZFLEXAngel *angel;

@end

@implementation ZZFDSubscriptionCell

+ (CGFloat)viewHeightByDataModel:(ZZFDSubscriptionModel *)dataModel
{
    CGFloat height = TOP_SPACE_FD_SUB_CELL * 2;
    for (ZZFDSubscriptionListShowModel *model in dataModel.listShowModelArray) {
        height += [ZZFDSubscriptionItemCell viewHeightByDataModel:model];
    }
    return height;
}

- (void)viewIndexPath:(NSIndexPath *)indexPath sectionItemCount:(NSInteger)count
{
    if (indexPath.row == 0) {
        self.addSeparator(ZZSeparatorPositionTop);
    }
    else {
        self.removeSeparator(ZZSeparatorPositionTop);
    }
    if (indexPath.row == count - 1) {
        self.addSeparator(ZZSeparatorPositionBottom);
    }
    else {
        self.addSeparator(ZZSeparatorPositionBottom).beginAt(15);
    }
}

- (void)setViewDataModel:(ZZFDSubscriptionModel *)dataModel
{
    self.angel.clear();
    self.angel.addSection(1);
    self.angel.addCells(@"ZZFDSubscriptionItemCell").toSection(1).withDataModelArray(dataModel.listShowModelArray);
    [self.tableView reloadData];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setBackgroundColor:[UIColor whiteColor]];
   
        self.tableView = self.contentView.addTableView(1)
        .backgroundColor([UIColor clearColor])
        .userInteractionEnabled(NO).scrollsToTop(NO)
        .separatorStyle(UITableViewCellSeparatorStyleNone)
        .masonry(^ (MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(TOP_SPACE_FD_SUB_CELL, 0, TOP_SPACE_FD_SUB_CELL, 0));
        })
        .view;
        self.angel = [[ZZFLEXAngel alloc] initWithHostView:self.tableView];
    }
    return self;
}

@end
