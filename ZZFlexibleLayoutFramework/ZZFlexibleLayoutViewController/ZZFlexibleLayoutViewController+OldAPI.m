//
//  ZZFlexibleLayoutViewController+OldAPI.m
//  zhuanzhuan
//
//  Created by 李伯坤 on 2017/8/15.
//  Copyright © 2017年 转转. All rights reserved.
//

#import "ZZFlexibleLayoutViewController+OldAPI.h"
#import "ZZFlexibleLayoutViewController+Kernel.h"
#import "ZZFlexibleLayoutSectionModel.h"
#import "ZZFlexibleLayoutSeperatorCell.h"

@implementation ZZFlexibleLayoutViewController (OldAPI)

#pragma mark - # section 操作
- (NSInteger)addSectionWithTag:(NSInteger)tag
{
    return [self addSectionWithTag:tag minimumLineSpacing:0];
}

- (NSInteger)addSectionWithTag:(NSInteger)tag minimumLineSpacing:(CGFloat)minimumLineSpacing
{
    return [self addSectionWithTag:tag minimumInteritemSpacing:0 minimumLineSpacing:minimumLineSpacing sectionInsets:UIEdgeInsetsZero];
}

- (NSInteger)addSectionWithTag:(NSInteger)tag minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing minimumLineSpacing:(CGFloat)minimumLineSpacing
{
    return [self addSectionWithTag:tag minimumInteritemSpacing:minimumLineSpacing minimumLineSpacing:minimumLineSpacing sectionInsets:UIEdgeInsetsZero];
}

- (NSInteger)addSectionWithTag:(NSInteger)tag sectionInsets:(UIEdgeInsets)sectionInsets
{
    return [self addSectionWithTag:tag minimumInteritemSpacing:0 minimumLineSpacing:0 sectionInsets:sectionInsets];
}


- (NSInteger)addSectionWithTag:(NSInteger)tag minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing minimumLineSpacing:(CGFloat)minimumLineSpacing sectionInsets:(UIEdgeInsets)sectionInsets
{
    return [self addSectionWithTag:tag minimumInteritemSpacing:minimumInteritemSpacing minimumLineSpacing:minimumLineSpacing sectionInsets:sectionInsets backgroundColor:nil];
}

- (NSInteger)addSectionWithTag:(NSInteger)tag backgroundColor:(UIColor *)backgroundColor
{
    return [self addSectionWithTag:tag minimumLineSpacing:0 backgroundColor:backgroundColor];
}

- (NSInteger)addSectionWithTag:(NSInteger)tag minimumLineSpacing:(CGFloat)minimumLineSpacing backgroundColor:(UIColor *)backgroundColor
{
    return [self addSectionWithTag:tag minimumInteritemSpacing:0 minimumLineSpacing:minimumLineSpacing backgroundColor:backgroundColor];
}

- (NSInteger)addSectionWithTag:(NSInteger)tag minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing minimumLineSpacing:(CGFloat)minimumLineSpacing backgroundColor:(UIColor *)backgroundColor
{
    return [self addSectionWithTag:tag minimumInteritemSpacing:minimumLineSpacing minimumLineSpacing:minimumLineSpacing sectionInsets:UIEdgeInsetsZero backgroundColor:backgroundColor];
}

- (NSInteger)addSectionWithTag:(NSInteger)tag sectionInsets:(UIEdgeInsets)sectionInsets backgroundColor:(UIColor *)backgroundColor
{
    return [self addSectionWithTag:tag minimumInteritemSpacing:0 minimumLineSpacing:0 sectionInsets:sectionInsets backgroundColor:backgroundColor];
}

- (NSInteger)addSectionWithTag:(NSInteger)tag minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing minimumLineSpacing:(CGFloat)minimumLineSpacing sectionInsets:(UIEdgeInsets)sectionInsets backgroundColor:(UIColor *)backgroundColor
{
    if ([self hasSection:tag]) {
        NSLog(@"!!!!! 重复添加Section：%ld", (long)tag);
    }
    ZZFlexibleLayoutSectionModel *sectionModel = [[ZZFlexibleLayoutSectionModel alloc] init];
    sectionModel.sectionTag = tag;
    sectionModel.minimumInteritemSpacing = minimumInteritemSpacing;
    sectionModel.minimumLineSpacing = minimumLineSpacing;
    sectionModel.sectionInsets = sectionInsets;
    sectionModel.backgroundColor = backgroundColor;
    [self.data addObject:sectionModel];
    return self.data.count - 1;
}

#pragma mark - # Header Footer
- (BOOL)setSectionHeaderViewWithModel:(id)model forSection:(NSInteger)sectionTag className:(NSString *)className
{
    RegisterCollectionViewReusableView(self.collectionView, UICollectionElementKindSectionHeader, className);
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:sectionTag];
    if (sectionModel) {
        ZZFlexibleLayoutViewModel *viewModel = [[ZZFlexibleLayoutViewModel alloc] initWithClassName:className andDataModel:model];
        sectionModel.headerViewModel = viewModel;
        return YES;
    }
    NSLog(@"!!!!! section不存在: %ld", (long)sectionTag);
    return NO;
}

- (BOOL)setSectionFooterViewWithModel:(id)model forSection:(NSInteger)sectionTag className:(NSString *)className
{
    RegisterCollectionViewReusableView(self.collectionView, UICollectionElementKindSectionFooter, className);
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:sectionTag];
    if (sectionModel) {
        ZZFlexibleLayoutViewModel *viewModel = [[ZZFlexibleLayoutViewModel alloc] initWithClassName:className andDataModel:model];
        sectionModel.footerViewModel = viewModel;
        return YES;
    }
    NSLog(@"!!!!! section不存在: %ld", (long)sectionTag);
    return NO;
}

#pragma mark - # Cell 操作
/// 为指定section添加cell
- (NSIndexPath *)addCellWithModel:(id)model forSection:(NSInteger)sectionTag className:(NSString *)className
{
    return [self addCellWithModel:model forSection:sectionTag className:className tag:TAG_CELL_NONE];
}

- (NSIndexPath *)addCellWithModel:(id)model forSection:(NSInteger)sectionTag className:(NSString *)className tag:(NSInteger)tag
{
    NSArray *indexPaths = [self addCellsWithModelArray:@[(model ? model : [NSNull null])] forSection:sectionTag className:className tag:tag];
    return indexPaths.count > 0 ? indexPaths[0] : nil;
}

/// 为指定section批量添加cell
- (NSArray<NSIndexPath *> *)addCellsWithModelArray:(NSArray *)modelArray forSection:(NSInteger)sectionTag className:(NSString *)className
{
    return [self addCellsWithModelArray:modelArray forSection:sectionTag className:className tag:TAG_CELL_NONE];
}

- (NSArray<NSIndexPath *> *)addCellsWithModelArray:(NSArray *)modelArray forSection:(NSInteger)sectionTag className:(NSString *)className tag:(NSInteger)tag
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:sectionTag];
    if (sectionModel) {
        return [self p_addCellsWithModelArray:modelArray forSection:sectionModel className:className tag:tag];
    }
    [self addSectionWithTag:sectionTag];
    return [self addCellsWithModelArray:modelArray forSection:sectionTag className:className tag:tag];
}

- (NSArray<NSIndexPath *> *)p_addCellsWithModelArray:(NSArray *)modelArray forSection:(ZZFlexibleLayoutSectionModel *)sectionModel className:(NSString *)className tag:(NSInteger)tag
{
    RegisterCollectionViewCell(self.collectionView, className);
    if (modelArray.count == 0 || !sectionModel) {
        return nil;
    }
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    NSInteger section = [self.data indexOfObject:sectionModel];
    NSInteger row = sectionModel.itemsArray.count;
    for (id model in modelArray) {
        ZZFlexibleLayoutViewModel *viewModel = [[ZZFlexibleLayoutViewModel alloc] initWithClassName:className andDataModel:model viewTag:tag];
        [sectionModel addObject:viewModel];
        [indexPaths addObject:[NSIndexPath indexPathForItem:row++ inSection:section]];
    }
    return indexPaths.count > 0 ? indexPaths : nil;
}

@end

#pragma mark - ## ZZFlexibleLayoutViewController (OldSeperatorAPI)
@implementation ZZFlexibleLayoutViewController (OldSeperatorAPI)

- (NSIndexPath *)addSeperatorCellForSection:(NSInteger)sectionTag
{
    return [self addSeperatorCellForSection:sectionTag withSize:DEFAULT_SEPERATOR_SIZE];
}

- (NSIndexPath *)addSeperatorCellForSection:(NSInteger)sectionTag withSize:(CGSize)size
{
    return [self addSeperatorCellForSection:sectionTag withSize:size andColor:DEFAULT_SEPERATOR_COLOR];
}

- (NSIndexPath *)addSeperatorCellForSection:(NSInteger)sectionTag withColor:(UIColor *)color
{
    return [self addSeperatorCellForSection:sectionTag withSize:DEFAULT_SEPERATOR_SIZE andColor:color];
}

- (NSIndexPath *)addSeperatorCellForSection:(NSInteger)sectionTag withSize:(CGSize)size andColor:(UIColor *)color
{
    for (ZZFlexibleLayoutSectionModel *sectionModel in self.data) {
        if (sectionModel.sectionTag == sectionTag) {
            return [self p_addSeperatorCellForSection:sectionModel withSize:size andColor:color];
        }
    }
    [self addSectionWithTag:sectionTag];
    return [self addSeperatorCellForSection:sectionTag withSize:size andColor:color];
}

#pragma mark - # Private Methods
- (NSIndexPath *)p_addSeperatorCellForSection:(ZZFlexibleLayoutSectionModel *)section withSize:(CGSize)size andColor:(UIColor *)color
{
    ZZFlexibleLayoutSeperatorModel *model = [[ZZFlexibleLayoutSeperatorModel alloc] initWithSize:size andColor:color];
    NSArray *indexPaths = [self p_addCellsWithModelArray:@[model] forSection:section className:CELL_SEPEARTOR tag:TAG_CELL_SEPERATOR];
    return indexPaths.count > 0 ? indexPaths[0] : nil;
}

@end

