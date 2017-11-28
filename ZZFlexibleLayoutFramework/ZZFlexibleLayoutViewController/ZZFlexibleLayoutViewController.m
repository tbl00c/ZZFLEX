//
//  ZZFlexibleLayoutViewController.m
//  zhuanzhuan
//
//  Created by 李伯坤 on 2016/10/10.
//  Copyright © 2016年 wuba. All rights reserved.
//

#import "ZZFlexibleLayoutViewController.h"
#import "ZZFlexibleLayoutViewController+Kernel.h"
#import "ZZFlexibleLayoutSectionModel.h"
#import "ZZFlexibleLayoutViewProtocol.h"
#import "ZZFlexibleLayoutSeperatorCell.h"
#import "ZZFLEXMacros.h"

@implementation ZZFlexibleLayoutViewController

- (id)init
{
    if (self = [super init]) {
        _data = [[NSMutableArray alloc] init];
        _scrollDirection = UICollectionViewScrollDirectionVertical;
        
        ZZFlexibleLayoutFlowLayout *layout = [[ZZFlexibleLayoutFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self.collectionView setBackgroundColor:[UIColor clearColor]];
        [self.collectionView setDataSource:self];
        [self.collectionView setDelegate:self];
        [self.collectionView setShowsHorizontalScrollIndicator:NO];
        [self.collectionView setAlwaysBounceVertical:YES];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    [self.collectionView setFrame:self.view.bounds];
    [self.view addSubview:self.collectionView];
    RegisterCollectionViewCell(self.collectionView, CELL_SEPEARTOR);        // 注册空白cell
    RegisterCollectionViewReusableView(self.collectionView, UICollectionElementKindSectionHeader, @"ZZFlexibleLayoutEmptyHeaderFooterView");
    RegisterCollectionViewReusableView(self.collectionView, UICollectionElementKindSectionFooter, @"ZZFlexibleLayoutEmptyHeaderFooterView");
}

- (void)dealloc
{
    NSLog(@"dealloc");
}

#pragma mark - # API
- (void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection
{
    _scrollDirection = scrollDirection;
    [(ZZFlexibleLayoutFlowLayout *)self.collectionView.collectionViewLayout setScrollDirection:scrollDirection];
}


#pragma mark 页面刷新
/// 刷新页面
- (void)reloadView
{
    self.isReloading = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
        self.isReloading = NO;
    });
}
#pragma mark 页面重新布局
- (void)updateSectionForTag:(NSInteger)sectionTag
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:sectionTag];
    [sectionModel.headerViewModel updateCellHeight];
    [sectionModel.footerViewModel updateCellHeight];
    for (ZZFlexibleLayoutViewModel *viewModel in sectionModel.itemsArray) {
        [viewModel updateCellHeight];
    }
}

- (void)updateCellsForCellTag:(NSInteger)cellTag
{
    NSArray *indexPaths = [self cellIndexPathForCellTag:cellTag];
    [self updateCellsAtIndexPaths:indexPaths];
}

- (void)updateCellsForSectionTag:(NSInteger)sectionTag cellTag:(NSInteger)cellTag
{
    NSArray *indexPaths = [self cellIndexPathForSectionTag:sectionTag cellTag:cellTag];
    [self updateCellsAtIndexPaths:indexPaths];
}

- (void)updateCellAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath) {
        [self updateCellsAtIndexPaths:@[indexPath]];
    }
}

- (void)updateCellsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
{
    NSArray<ZZFlexibleLayoutViewModel *> *viewModels = [self viewModelsAtIndexPaths:indexPaths];
    for (ZZFlexibleLayoutViewModel *viewModel in viewModels) {
        [viewModel updateCellHeight];
    }
}

#pragma mark 数据操作
- (id)dataModelAtIndexPath:(NSIndexPath *)indexPath
{
    ZZFlexibleLayoutViewModel *viewModel = [self viewModelAtIndexPath:indexPath];
    return viewModel ? viewModel.dataModel : nil;
}

- (id)dataModelForSection:(NSInteger)sectionTag cellTag:(NSInteger)cellTag
{
    NSArray<NSIndexPath *> *indexPaths = [self cellIndexPathForSectionTag:sectionTag cellTag:cellTag];
    if (indexPaths.count > 0) {
        return [self dataModelAtIndexPath:indexPaths[0]];
    }
    return nil;
}

- (id)dataModelForSection:(NSInteger)sectionTag className:(NSString *)className
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:sectionTag];
    for (ZZFlexibleLayoutViewModel *viewModel in sectionModel.itemsArray) {
        if ([viewModel.className isEqualToString:className]) {
            return viewModel.dataModel;
        }
    }
    return nil;
}

- (NSArray *)dataModelArrayForSection:(NSInteger)sectionTag
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:sectionTag];
    NSMutableArray *data = [[NSMutableArray alloc] init];
    for (ZZFlexibleLayoutViewModel *viewModel in sectionModel.itemsArray) {
        [data addObject:viewModel.dataModel];
    }
    return data;
}

- (NSArray *)dataModelArrayForSection:(NSInteger)sectionTag cellTag:(NSInteger)cellTag
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:sectionTag];
    NSMutableArray *data = [[NSMutableArray alloc] init];
    for (ZZFlexibleLayoutViewModel *viewModel in sectionModel.itemsArray) {
        if (viewModel.viewTag == cellTag) {
            [data addObject:viewModel.dataModel];
        }
    }
    return data;
}

- (NSArray *)allDataModelArray
{
    NSMutableArray *data = [[NSMutableArray alloc] init];
    for (ZZFlexibleLayoutSectionModel *sectionModel in self.data) {
        NSMutableArray *sectionData = [[NSMutableArray alloc] init];
        for (ZZFlexibleLayoutViewModel *viewModel in sectionModel.itemsArray) {
            [sectionData addObject:viewModel.dataModel];
        }
        [data addObject:sectionData];
    }
    return data;
}

#pragma mark - # Section操作
- (ZZFLEXChainSectionModel *(^)(NSInteger tag))addSection
{
    @weakify(self);
    return ^(NSInteger tag){
        @strongify(self);
        ZZFlexibleLayoutSectionModel *sectionModel = [[ZZFlexibleLayoutSectionModel alloc] init];
        sectionModel.sectionTag = tag;
        
        [self.data addObject:sectionModel];
        ZZFLEXChainSectionModel *chainSectionModel = [[ZZFLEXChainSectionModel alloc] initWithSectionModel:sectionModel];
        return chainSectionModel;
    };
}

- (ZZFLEXChainSectionModel *(^)(NSInteger tag))sectionForTag
{
    @weakify(self);
    return ^(NSInteger tag){
        @strongify(self);
        ZZFlexibleLayoutSectionModel *sectionModel = nil;
        for (sectionModel in self.data) {
            if (sectionModel.sectionTag == tag) {
                ZZFLEXChainSectionModel *chainSectionModel = [[ZZFLEXChainSectionModel alloc] initWithSectionModel:sectionModel];
                return chainSectionModel;
            }
        }
        return self.addSection(tag);
    };
}

- (NSInteger)insertSectionWithTag:(NSInteger)tag toIndex:(NSInteger)index
{
    return [self insertSectionWithTag:tag toIndex:index minimumInteritemSpacing:0 minimumLineSpacing:0 sectionInsets:UIEdgeInsetsMake(0, 0, 0, 0) backgroundColor:nil];
}

- (NSInteger)insertSectionWithTag:(NSInteger)tag toIndex:(NSInteger)index minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing minimumLineSpacing:(CGFloat)minimumLineSpacing sectionInsets:(UIEdgeInsets)sectionInsets backgroundColor:(UIColor *)backgroundColor
{
    if ([self hasSection:tag]) {
        NSLog(@"!!!!! 重复添加Section：%ld", (long)tag);
    }
    if (index > self.data.count) {
        NSLog(@"!!!!! 插入section：index越界");
        return -1;
    }
    ZZFlexibleLayoutSectionModel *sectionModel = [[ZZFlexibleLayoutSectionModel alloc] init];
    sectionModel.sectionTag = tag;
    sectionModel.minimumInteritemSpacing = minimumInteritemSpacing;
    sectionModel.minimumLineSpacing = minimumLineSpacing;
    sectionModel.sectionInsets = sectionInsets;
    sectionModel.backgroundColor = backgroundColor;
    [self.data insertObject:sectionModel atIndex:index];
    return index;
}

- (BOOL)deleteSection:(NSInteger)tag
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:tag];
    if (sectionModel) {
        [self.data removeObject:sectionModel];
        return YES;
    }
    return NO;
}

- (BOOL)deleteAllItemsForSection:(NSInteger)tag
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:tag];
    if (sectionModel) {
        sectionModel.headerViewModel = nil;
        sectionModel.footerViewModel = nil;
        sectionModel.itemsArray = nil;
        return YES;
    }
    return NO;
}

- (BOOL)deleteAllCellsForSection:(NSInteger)tag {
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:tag];
    if (sectionModel) {
        sectionModel.itemsArray = nil;
        return YES;
    }
    return NO;
}

- (BOOL)deleteAllItems
{
    [self.data removeAllObjects];
    return YES;
}

- (BOOL)hasSection:(NSInteger)tag
{
    return [self sectionModelForTag:tag] != nil;
}

- (BOOL)hasSectionAtIndex:(NSInteger)sectionIndex
{
    return sectionIndex < self.data.count;
}

#pragma mark - # Section View 操作
//MARK: Header
- (ZZFLEXChainViewModel *(^)(NSString *className))setHeader
{
    @weakify(self);
    return ^(NSString *className) {
        @strongify(self);
        ZZFlexibleLayoutViewModel *viewModel = [[ZZFlexibleLayoutViewModel alloc] init];
        viewModel.className = className;
        RegisterCollectionViewReusableView(self.collectionView, UICollectionElementKindSectionHeader, className);
        ZZFLEXChainViewModel *chainViewModel = [[ZZFLEXChainViewModel alloc] initWithListData:self.data viewModel:viewModel andType:ZZFLEXChainViewTypeHeader];
        return chainViewModel;
    };
}

- (id)dataModelForSectionHeader:(NSInteger)sectionTag
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:sectionTag];
    return sectionModel.headerViewModel.dataModel;
}

- (BOOL)deleteSectionHeaderView:(NSInteger)sectionTag
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:sectionTag];
    if (sectionModel) {
        sectionModel.headerViewModel = nil;
        return YES;
    }
    return NO;
}

//MARK: Footer
- (ZZFLEXChainViewModel *(^)(NSString *className))setFooter
{
    @weakify(self);
    return ^(NSString *className) {
        @strongify(self);
        ZZFlexibleLayoutViewModel *viewModel = [[ZZFlexibleLayoutViewModel alloc] init];
        viewModel.className = className;
        RegisterCollectionViewReusableView(self.collectionView, UICollectionElementKindSectionFooter, className);
        ZZFLEXChainViewModel *chainViewModel = [[ZZFLEXChainViewModel alloc] initWithListData:self.data viewModel:viewModel andType:ZZFLEXChainViewTypeFooter];
        return chainViewModel;
    };
}

- (id)dataModelForSectionFooter:(NSInteger)sectionTag
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:sectionTag];
    return sectionModel.footerViewModel.dataModel;
}

- (BOOL)deleteSectionFooterView:(NSInteger)sectionTag
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:sectionTag];
    if (sectionModel) {
        sectionModel.footerViewModel = nil;
        return YES;
    }
    return NO;
}

#pragma mark - # Cell 操作
/// 添加cell
- (ZZFLEXChainViewModel *(^)(NSString *className))addCell
{
    @weakify(self);
    return ^(NSString *className) {
        @strongify(self);
        RegisterCollectionViewCell(self.collectionView, className);
        ZZFlexibleLayoutViewModel *viewModel = [[ZZFlexibleLayoutViewModel alloc] init];
        viewModel.className = className;
        ZZFLEXChainViewModel *chainViewModel = [[ZZFLEXChainViewModel alloc] initWithListData:self.data viewModel:viewModel andType:ZZFLEXChainViewTypeCell];
        return chainViewModel;
    };
}

/// 批量添加cell
- (ZZFLEXChainViewArrayModel *(^)(NSString *className))addCells;
{
    @weakify(self);
    return ^(NSString *className) {
        @strongify(self);
        RegisterCollectionViewCell(self.collectionView, className);
        ZZFLEXChainViewArrayModel *viewModel = [[ZZFLEXChainViewArrayModel alloc] initWithClassName:className listData:self.data];
        return viewModel;
    };
}

/// 添加空白cell
- (ZZFLEXChainViewModel *(^)(CGSize size, UIColor *color))addSeperatorCell;
{
    @weakify(self);
    return ^(CGSize size, UIColor *color) {
        @strongify(self);
        ZZFlexibleLayoutViewModel *viewModel = [[ZZFlexibleLayoutViewModel alloc] init];
        viewModel.className = CELL_SEPEARTOR;
        viewModel.dataModel = [[ZZFlexibleLayoutSeperatorModel alloc] initWithSize:size andColor:color];
        ZZFLEXChainViewModel *chainViewModel = [[ZZFLEXChainViewModel alloc] initWithListData:self.data viewModel:viewModel andType:ZZFLEXChainViewTypeCell];
        return chainViewModel;
    };
}


/// 为指定section插入cell（失败返回nil）
- (NSIndexPath *)insertCellWithModel:(id)model forSection:(NSInteger)sectionTag className:(NSString *)className pos:(NSInteger)pos
{
    return [self insertCellWithModel:model forSection:sectionTag className:className tag:TAG_CELL_NONE pos:pos];
}

- (NSIndexPath *)insertCellWithModel:(id)model forSection:(NSInteger)sectionTag className:(NSString *)className tag:(NSInteger)tag pos:(NSInteger)pos
{
    NSArray *indexPaths = [self insertCellsWithModelArray:@[(model ? model : [NSNull null])] forSection:sectionTag className:className tag:tag pos:pos];
    return indexPaths.count > 0 ? indexPaths[0] : nil;
}

/// 为指定section批量添加
- (NSArray<NSIndexPath *> *)insertCellsWithModelArray:(NSArray *)modelArray forSection:(NSInteger)sectionTag className:(NSString *)className pos:(NSInteger)pos
{
    return [self insertCellsWithModelArray:modelArray forSection:sectionTag className:className tag:TAG_CELL_NONE pos:pos];
}

- (NSArray<NSIndexPath *> *)insertCellsWithModelArray:(NSArray *)modelArray forSection:(NSInteger)sectionTag className:(NSString *)className tag:(NSInteger)tag pos:(NSInteger)pos
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:sectionTag];
    if (sectionModel && pos <= sectionModel.itemsArray.count) {
        return [self p_insertCellsWithModelArray:modelArray forSection:sectionModel className:className tag:tag pos:pos];
    }
    return nil;
}

- (NSArray<NSIndexPath *> *)p_insertCellsWithModelArray:(NSArray *)modelArray forSection:(ZZFlexibleLayoutSectionModel *)sectionModel className:(NSString *)className tag:(NSInteger)tag pos:(NSInteger)pos
{
    RegisterCollectionViewCell(self.collectionView, className);
    if (modelArray.count == 0 || !sectionModel) {
        return nil;
    }
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    NSInteger section = [self.data indexOfObject:sectionModel];
    if (pos <= sectionModel.count) {
        for (id model in modelArray) {
            ZZFlexibleLayoutViewModel *viewModel = [[ZZFlexibleLayoutViewModel alloc] initWithClassName:className andDataModel:model viewTag:tag];
            [sectionModel insertObject:viewModel atIndex:pos];
            [indexPaths addObject:[NSIndexPath indexPathForItem:pos++ inSection:section]];
        }
        return indexPaths.count > 0 ? indexPaths : nil;
    }
    return nil;
}

/// 根据indexPath删除cell
- (BOOL)deleteCellAtIndexPath:(NSIndexPath *)indexPath
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:indexPath.section];
    if (sectionModel && sectionModel.count > indexPath.row) {
        [sectionModel removeObjectAtIndex:indexPath.row];
        return YES;
    }
    return NO;
}

- (BOOL)deleteCellsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
{
    if (indexPaths.count > 0) {
        BOOL ok = NO;
        NSArray *deleteModels = [self viewModelsAtIndexPaths:indexPaths];
        for (ZZFlexibleLayoutSectionModel *sectionModel in self.data) {
            NSArray *items = [sectionModel.itemsArray copy];
            for (ZZFlexibleLayoutViewModel *viewModel in items) {
                if ([deleteModels containsObject:viewModel]) {
                    [sectionModel removeObject:viewModel];
                    ok = YES;
                }
            }
        }
        return ok;
    }
    return NO;
}

/// 根据cellTag删除cell
- (BOOL)deleteCellByCellTag:(NSInteger)tag
{
    NSArray<NSIndexPath *> *indexPaths = [self cellIndexPathForCellTag:tag];
    if (indexPaths.count > 0) {
        return [self deleteCellAtIndexPath:indexPaths[0]];
    }
    return NO;
}

- (BOOL)deleteCellForSection:(NSInteger)sectionTag tag:(NSInteger)tag
{
    NSArray<NSIndexPath *> *indexPaths = [self cellIndexPathForSectionTag:sectionTag cellTag:tag];
    if (indexPaths.count > 0) {
        return [self deleteCellAtIndexPath:indexPaths[0]];
    }
    return NO;
}

/// 根据cellTag批量删除cell
- (BOOL)deleteAllCellsByCellTag:(NSInteger)tag
{
    NSArray *indexPaths = [self cellIndexPathForCellTag:tag];
    return [self deleteCellsAtIndexPaths:indexPaths];
}

- (BOOL)deleteAllCellsForSection:(NSInteger)sectionTag tag:(NSInteger)tag
{
    NSArray *indexPaths = [self cellIndexPathForSectionTag:sectionTag cellTag:tag];
    return [self deleteCellsAtIndexPaths:indexPaths];
}

/// 根据数据源删除cell
- (BOOL)deleteCellByModel:(id)model
{
    BOOL ok = NO;
    for (ZZFlexibleLayoutSectionModel *sectionModel in self.data) {
        if ([self p_deleteCellForSection:sectionModel model:model deleteAll:NO]) {
            return YES;
        }
    }
    return ok;
}

- (BOOL)deleteCellForSection:(NSInteger)sectionTag model:(id)model
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:sectionTag];
    return [self p_deleteCellForSection:sectionModel model:model deleteAll:NO];
}

/// 根据数据源删除找到的所有cell
- (BOOL)deleteAllCellsByModel:(id)model
{
    BOOL ok = NO;
    for (ZZFlexibleLayoutSectionModel *sectionModel in self.data) {
        if ([self p_deleteCellForSection:sectionModel model:model deleteAll:YES]) {
            return YES;
        }
    }
    return ok;
}

- (BOOL)deleteAllCellsForSection:(NSInteger)sectionTag model:(id)model
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:sectionTag];
    return [self p_deleteCellForSection:sectionModel model:model deleteAll:YES];
}

- (BOOL)p_deleteCellForSection:(ZZFlexibleLayoutSectionModel *)sectionModel model:(id)model deleteAll:(BOOL)all
{
    BOOL ok = NO;
    if (sectionModel) {
        NSArray *data = sectionModel.itemsArray.mutableCopy;
        for (ZZFlexibleLayoutViewModel *viewMdoel in data) {
            if (viewMdoel.dataModel == model) {
                [sectionModel removeObject:viewMdoel];
                ok = YES;
                if (!all) {
                    break;
                }
            }
        }
    }
    return ok;
}

/// 根据类名删除cell
- (BOOL)deleteCellsByClassName:(NSString *)className
{
    BOOL ok = NO;
    for (ZZFlexibleLayoutSectionModel *sectionModel in self.data) {
        if ([self p_deleteCellForSection:sectionModel className:className]) {
            ok = YES;
        }
    }
    return ok;
}

- (BOOL)deleteCellsForSection:(NSInteger)sectionTag className:(NSString *)className
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:sectionTag];
    return [self p_deleteCellForSection:sectionModel className:className];
}

- (BOOL)p_deleteCellForSection:(ZZFlexibleLayoutSectionModel *)sectionModel className:(NSString *)className
{
    BOOL ok = NO;
    if (sectionModel) {
        NSArray *data = sectionModel.itemsArray.mutableCopy;
        for (ZZFlexibleLayoutViewModel *viewMdoel in data) {
            if ([viewMdoel.className isEqualToString:className]) {
                [sectionModel removeObject:viewMdoel];
                ok = YES;
            }
        }
    }
    return ok;
}

/// 是否存在cell
- (BOOL)hasCell:(NSInteger)tag
{
    return [self cellIndexPathForCellTag:tag].count > 0;
}

- (BOOL)hasCellWithDataModel:(id)dataModel
{
    for (ZZFlexibleLayoutSectionModel *sectionModel in self.data) {
        for (ZZFlexibleLayoutViewModel *viewModel in sectionModel.itemsArray) {
            if (viewModel == dataModel) {
                return YES;
            }
        }
    }
    return NO;
}

- (BOOL)hasCellAtSection:(NSInteger)sectionTag cellTag:(NSInteger)cellTag
{
    return [self cellIndexPathForSectionTag:sectionTag cellTag:cellTag].count > 0;
}

- (BOOL)hasCellAtIndexPath:(NSIndexPath *)indexPath
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:indexPath.section];
    if (sectionModel && sectionModel.count > indexPath.row) {
        return YES;
    }
    return NO;
}

#pragma mark - # Index获取
- (NSInteger)sectionIndexForTag:(NSInteger)sectionTag
{
    for (int section = 0; section < self.data.count; section++) {
        ZZFlexibleLayoutSectionModel *sectionModel = self.data[section];
        if (sectionModel.sectionTag == sectionTag) {
            return section;
        }
    }
    return 0;
}

- (NSArray<NSIndexPath *> *)cellIndexPathForCellTag:(NSInteger)cellTag
{
    NSMutableArray *data = [[NSMutableArray alloc] init];
    for (int section = 0; section < self.data.count; section++) {
        ZZFlexibleLayoutSectionModel *sectionModel = self.data[section];
        for (int row = 0; row < sectionModel.itemsArray.count; row++) {
            ZZFlexibleLayoutViewModel *viewModel = [sectionModel objectAtIndex:row];
            if (viewModel.viewTag == cellTag) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:row inSection:section];
                [data addObject:indexPath];
            }
        }
    }
    return data.count > 0 ? data : nil;
}

- (NSArray<NSIndexPath *> *)cellIndexPathForSectionTag:(NSInteger)sectionTag cellTag:(NSInteger)cellTag
{
    NSMutableArray *data = [[NSMutableArray alloc] init];
    NSInteger sectionIndex = [self sectionIndexForTag:sectionTag];
    ZZFlexibleLayoutSectionModel *sectionModel = self.data[sectionIndex];
    for (int row = 0; row < sectionModel.itemsArray.count; row++) {
        ZZFlexibleLayoutViewModel *viewModel = [sectionModel objectAtIndex:row];
        if (viewModel.viewTag == cellTag) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:row inSection:sectionIndex];
            [data addObject:indexPath];
        }
    }
    return data.count > 0 ? data : nil;
}

#pragma mark - # 滚动操作
- (void)scrollToTop:(BOOL)animated
{
    [self.collectionView setContentOffset:CGPointZero animated:animated];
}

- (void)scrollToBottom:(BOOL)animated
{
    CGFloat y = self.collectionView.contentSize.height - self.collectionView.frame.size.height;
    [self.collectionView setContentOffset:CGPointMake(0, y) animated:animated];
}

- (void)scrollToSection:(NSInteger)sectionTag position:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated
{
    if (self.isReloading) {
        self.isReloading = NO;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self scrollToSection:sectionTag position:scrollPosition animated:animated];
        });
    }
    else if ([self hasSection:sectionTag]) {
        NSInteger section = [self sectionIndexForTag:sectionTag];
        NSUInteger sectionCount = [self.collectionView numberOfSections];
        if (sectionCount > section) {
            NSUInteger itemCount = [self.collectionView numberOfItemsInSection:section];
            if (itemCount > 0) {
                [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:section] atScrollPosition:scrollPosition animated:animated];
            }
        }
    }
}

- (void)scrollToSection:(NSInteger)sectionTag cell:(NSInteger)cellTag position:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated
{
    NSArray *indexPaths = [self cellIndexPathForSectionTag:sectionTag cellTag:cellTag];
    if (indexPaths.count > 0) {
        NSIndexPath *indexPath = indexPaths[0];
        [self scrollToIndexPath:indexPath position:scrollPosition animated:animated];
    }
}

- (void)scrollToCell:(NSInteger)cellTag position:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated
{
    NSArray *indexPaths = [self cellIndexPathForCellTag:cellTag];
    if (indexPaths.count > 0) {
        NSIndexPath *indexPath = indexPaths[0];
        [self scrollToIndexPath:indexPath position:scrollPosition animated:animated];
    }
}

- (void)scrollToSectionIndex:(NSInteger)sectionIndex position:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated
{
    if ([self hasSectionAtIndex:sectionIndex]) {
        [self scrollToIndexPath:[NSIndexPath indexPathForItem:0 inSection:sectionIndex] position:scrollPosition animated:animated];
    }
}

- (void)scrollToIndexPath:(NSIndexPath *)indexPath position:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated
{
    if (self.isReloading) {
        self.isReloading = NO;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self scrollToIndexPath:indexPath position:scrollPosition animated:animated];
        });
    }
    if ([self hasCellAtIndexPath:indexPath]) {
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:scrollPosition animated:animated];
    }
}

@end
