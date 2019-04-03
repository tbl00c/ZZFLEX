//
//  ZZFDCateCell.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2018/2/5.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "ZZFDCateCell.h"
#import "ZZFLEXAngel.h"
#import "UIView+ZZFLEX.h"
#import "ZZFDPlatformItemModel.h"
#import "ZZFLEXEditModel.h"

#define     FDCATE_MAX_COUNT         5

@interface ZZFDCateCell ()

@property (nonatomic, strong) ZZFLEXEditModel *dataModel;

@property (nonatomic, strong) UILabel *maxLabel;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) ZZFLEXAngel *angel;

@end

@implementation ZZFDCateCell

+ (CGFloat)viewHeightByDataModel:(ZZFLEXEditModel *)dataModel
{
    NSInteger count = [dataModel.titleModel count];
    CGFloat height = 50;
    NSInteger line = count / 4 + (count % 4 == 0 ? 0 : 1);
    return height + line * 45;
}

- (void)setViewDataModel:(ZZFLEXEditModel *)dataModel
{
    @weakify(self);
    self.dataModel = dataModel;
    [self resetMaxLabel];
    
    self.angel.clear();
    self.angel.addSection(1).sectionInsets(UIEdgeInsetsMake(10, 15, 20, 15)).minimumLineSpacing(15).minimumInteritemSpacing(15);
    self.angel.addCells(@"ZZFDCateItemCell").toSection(1).withDataModelArray(dataModel.titleModel).selectedAction(^ (ZZFDPlatformItemModel *model) {
        @strongify(self);
        if (!model.selected && [self selectedCount] == FDCATE_MAX_COUNT) {
            [TLUIUtility showAlertWithTitle:@"已达选择上限" message:nil cancelButtonTitle:@"确定"];
        }
        else {
            model.selected = !model.selected;
            [self.collectionView reloadData];
            [self resetMaxLabel];
        }
    });
    
    [self.collectionView reloadData];
}

- (void)resetMaxLabel
{
    NSInteger count = [self selectedCount];
    if (count == 0) {
        [self.maxLabel setText:[NSString stringWithFormat:@"最多选择%d个", FDCATE_MAX_COUNT]];
    }
    else {
        [self.maxLabel setText:[NSString stringWithFormat:@"还能选择%d个", (int)(FDCATE_MAX_COUNT - count)]];
    }
}

- (NSInteger)selectedCount
{
    int count = 0;
    for (ZZFDPlatformItemModel *model in self.dataModel.titleModel) {
        if (model.selected) {
            count ++;
        }
    }
    return count;
}

- (void)viewIndexPath:(NSIndexPath *)indexPath sectionItemCount:(NSInteger)count
{
    self.addSeparator(ZZSeparatorPositionTop);
    self.addSeparator(ZZSeparatorPositionBottom);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        UILabel *titleLabel = self.contentView.addLabel(1)
        .text(@"类别").font([UIFont systemFontOfSize:15])
        .masonry(^ (MASConstraintMaker *make) {
            make.top.mas_equalTo(12);
            make.left.mas_equalTo(15);
            make.width.mas_lessThanOrEqualTo(100);
        })
        .view;
        
        self.maxLabel = self.contentView.addLabel(2)
        .font([UIFont systemFontOfSize:13]).textColor([UIColor lightGrayColor])
        .masonry(^ (MASConstraintMaker *make) {
            make.centerY.mas_equalTo(titleLabel);
            make.right.mas_equalTo(-15);
            make.left.mas_greaterThanOrEqualTo(titleLabel.mas_right);
        })
        .view;
        
        self.collectionView = self.contentView.addCollectionView(3)
        .backgroundColor([UIColor whiteColor])
        .masonry(^ (MASConstraintMaker *make) {
            make.top.mas_equalTo(titleLabel.mas_bottom).mas_offset(5);
            make.left.right.bottom.mas_equalTo(0);
        })
        .view;
        self.angel = [[ZZFLEXAngel alloc] initWithHostView:self.collectionView];
    }
    return self;
}

- (NSArray *)cateArray
{
    return self.dataModel.titleModel;
}

@end

#pragma mark - ## ZZFDCateItemCell
@interface ZZFDCateItemCell : UICollectionViewCell <ZZFlexibleLayoutViewProtocol>

@property (nonatomic, strong) UIButton *titleLabel;

@end

@implementation ZZFDCateItemCell

+ (CGSize)viewSizeByDataModel:(id)dataModel
{
    CGFloat width = (SCREEN_WIDTH - 15 * 5) / 4;
    return CGSizeMake(width, 30);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel = self.contentView.addButton(1001).userInteractionEnabled(NO)
        .cornerRadius(3).titleFont([UIFont systemFontOfSize:14])
        .backgroundColor([UIColor colorGrayBG]).titleColor([UIColor grayColor])
        .backgroundColorSelected([UIColor colorWithHexString:@"#ff5647" alpha:1.0]).titleColorSelected([UIColor whiteColor])
        .masonry(^ (MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        })
        .view;
    }
    return self;
}

- (void)setViewDataModel:(ZZFDPlatformItemModel *)dataModel
{
    self.titleLabel.zz_make.title(dataModel.title).selected(dataModel.selected);
}

@end
