//
//  ZZFLEXAngelBaseCell.m
//  Masonry
//
//  Created by 李伯坤 on 2020/2/3.
//

#import "ZZFLEXAngelBaseCell.h"

@implementation ZZFLEXAngelBaseCell

+ (CGSize)viewSizeByDataModel:(id)dataModel
{
    return CGSizeMake(-1, 52);
}

- (void)setViewDataModel:(id)dataModel
{
    [self setItem:dataModel];
}

- (void)onViewPositionUpdatedWithIndexPath:(NSIndexPath *)indexPath sectionItemCount:(NSInteger)count
{
    ZZFLEXAngelItemStyle *itemStyle = self.item.style;
    ZZFLEXAngelItemStyle *style = [ZZFLEXAngeWingAppearance appearance].itemStyle;
    // 分割线
    {
        void (^drawSeperator)(ZZFLEXAngelItemSeperatorType, UIEdgeInsets) = ^(ZZFLEXAngelItemSeperatorType type, UIEdgeInsets seperatorInsets) {
            if (type == ZZFLEXAngelItemSeperatorAuto || type == ZZFLEXAngelItemSeperatorNone) {
                self.removeSeparator(ZZSeparatorPositionTop);
                self.removeSeparator(ZZSeparatorPositionBottom);
            }
            else if (type == ZZFLEXAngelItemSeperatorSimple) {
                self.removeSeparator(ZZSeparatorPositionTop);
                if (indexPath.row < count - 1) {
                    self.addSeparator(ZZSeparatorPositionBottom).beginAt(seperatorInsets.left).endAt(-seperatorInsets.right).offset(-seperatorInsets.bottom);
                }
                else {
                    self.removeSeparator(ZZSeparatorPositionBottom);
                }
            }
            else if (type == ZZFLEXAngelItemSeperatorAll) {
                if (indexPath.row == 0) {
                    self.addSeparator(ZZSeparatorPositionTop);
                }
                else {
                    self.removeSeparator(ZZSeparatorPositionTop);
                }
                if (indexPath.row < count - 1) {
                    self.addSeparator(ZZSeparatorPositionBottom).beginAt(seperatorInsets.left).endAt(-seperatorInsets.right).offset(-seperatorInsets.bottom);
                }
                else {
                    self.addSeparator(ZZSeparatorPositionBottom);
                }
            }
        };
        ZZFLEXAngelItemSeperatorType type = itemStyle.seperatorType != ZZFLEXAngelItemSeperatorAuto ? itemStyle.seperatorType : style.seperatorType;
        UIEdgeInsets seperatorInsets = itemStyle.seperatorInsets ? itemStyle.seperatorInsets.UIEdgeInsetsValue : style.seperatorInsets.UIEdgeInsetsValue;
        drawSeperator(type, seperatorInsets);
    }
    
    // 圆角
    {
        void (^drawCornor)(ZZFLEXAngelItemCornorType, CGFloat) = ^(ZZFLEXAngelItemCornorType type, CGFloat cornorRadius) {
            if (type == ZZFLEXAngelItemCornorAuto || type == ZZFLEXAngelItemCornorNone) {
                self.removeCornor();
            }
            else if (type == ZZFLEXAngelItemCornorSimple) {
                if (indexPath.row == 0 && indexPath.row == count - 1) {
                    self.setCornor(ZZCornerPositionAll).radius(cornorRadius);
                }
                else if (indexPath.row == 0) {
                    self.setCornor(ZZCornerPositionTop).radius(cornorRadius);
                }
                else if (indexPath.row == count - 1) {
                    self.setCornor(ZZCornerPositionBottom).radius(cornorRadius);
                }
                else {
                    self.removeCornor();
                }
            }
            else if (type == ZZFLEXAngelItemCornorAll) {
                self.setCornor(ZZCornerPositionAll).radius(cornorRadius);
            }
        };
        ZZFLEXAngelItemCornorType type = itemStyle.cornorType != ZZFLEXAngelItemCornorAuto ? itemStyle.cornorType : style.cornorType;
        CGFloat cornorRadius = itemStyle.cornorRadius ? itemStyle.cornorRadius.doubleValue : style.cornorRadius.doubleValue;
        drawCornor(type, cornorRadius);
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setSelectedBackgroundView:[UIView new]];
        _angelView = self.contentView.addView(0)
        .masonry(^ (__kindof UIView *view, MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        })
        .view;
    }
    return self;
}

- (void)setItem:(ZZFLEXAngelItem *)item
{
    _item = item;
    
    ZZFLEXAngeWingAppearance *appearance = [ZZFLEXAngeWingAppearance appearanceForClass:[self class]];
    
    // 背景
    [self setBackgroundColor:item.style.backgroundColor ? item.style.backgroundColor : appearance.itemStyle.backgroundColor];
    if (item.style.disableHighlight) {
        [self.selectedBackgroundView setBackgroundColor:[UIColor clearColor]];
    }
    else {
        [self.selectedBackgroundView setBackgroundColor:item.style.backgroundColorHighlight ? item.style.backgroundColorHighlight : appearance.itemStyle.backgroundColorHighlight];
    }
    
    // 容器
    self.angelView.zz_setup.updateMasonry(^(__kindof UIView *sender, MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, item.style.edgeInsets) ? appearance.itemStyle.edgeInsets : item.style.edgeInsets);
    });
}

@end
    
