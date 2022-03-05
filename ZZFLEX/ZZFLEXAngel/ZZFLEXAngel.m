//
//  ZZFLEXAngel.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/12/14.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFLEXAngel.h"
#import "ZZFLEXAngel+Private.h"
#import "ZZFLEXAngel+UITableView.h"
#import "ZZFLEXAngel+UICollectionView.h"
#import "ZZFlexibleLayoutSeperatorCell.h"
#import "ZZFLEXTableViewEmptyCell.h"
#import "ZZFlexibleLayoutEmptyHeaderFooterView.h"
#import "ZZFLEXTableViewHeaderFooterView.h"
#import "ZZFLEXMacros.h"
#import "ZZFLEXSectionModel.h"

@interface ZZFLEXAngel () <ZZFLEXViewModelDelegate>

@end

@implementation ZZFLEXAngel

- (instancetype)initWithHostView:(__kindof UIScrollView *)hostView {
    if (self = [self init]) {
        [self setHostView:hostView];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        _data = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)setHostView:(__kindof UIScrollView *)hostView {
    _hostView = hostView;
    if ([_hostView isKindOfClass:[UITableView class]]) {
        [(UITableView *)_hostView setDataSource:self];
        [(UITableView *)_hostView setDelegate:self];
        RegisterHostViewCell(_hostView, [ZZFLEXTableViewEmptyCell class], NSStringFromClass([ZZFLEXTableViewEmptyCell class]));
        RegisterHostViewReusableView(_hostView, nil, [ZZFLEXTableViewHeaderFooterView class], NSStringFromClass([ZZFLEXTableViewHeaderFooterView class]));
    } else if ([_hostView isKindOfClass:[UICollectionView class]]) {
        [(UICollectionView *)_hostView setDataSource:self];
        [(UICollectionView *)_hostView setDelegate:self];
        RegisterHostViewCell(_hostView, [ZZFlexibleLayoutSeperatorCell class], NSStringFromClass([ZZFlexibleLayoutSeperatorCell class])); // 注册空白cell
        RegisterHostViewReusableView(_hostView, UICollectionElementKindSectionHeader, [ZZFlexibleLayoutEmptyHeaderFooterView class], NSStringFromClass([ZZFlexibleLayoutEmptyHeaderFooterView class]));
        RegisterHostViewReusableView(_hostView, UICollectionElementKindSectionFooter, [ZZFlexibleLayoutEmptyHeaderFooterView class], NSStringFromClass([ZZFlexibleLayoutEmptyHeaderFooterView class]));
    }
    self.update();
    self.reload();
}

- (void)reloadView {
    [(UITableView *)self.hostView reloadData];
}

#pragma mark - # 整体
- (void (^)(void))reload {
    return ^{
        [(UITableView *)self.hostView reloadData];
    };
}

- (BOOL (^)(void))clear {
    return ^{
        [self.data removeAllObjects];
        return YES;
    };
}

- (BOOL (^)(void))clearAllItems {
    return ^{
        for (ZZFLEXSectionModel *sectionModel in self.data) {
            sectionModel.headerViewModel = nil;
            [sectionModel.itemsArray removeAllObjects];
            sectionModel.footerViewModel = nil;
        }
        return YES;
    };
}

- (BOOL (^)(void))clearAllCells {
    return ^{
        for (ZZFLEXSectionModel *sectionModel in self.data) {
            [sectionModel.itemsArray removeAllObjects];
        }
        return YES;
    };
}

/// 更新所有元素
- (BOOL (^)(void))update {
    return ^{
        for (ZZFLEXSectionModel *sectionModel in self.data) {
            [sectionModel.headerViewModel updateViewSize];
            [sectionModel.footerViewModel updateViewSize];
            for (ZZFLEXViewModel *viewModel in sectionModel.itemsArray) {
                [viewModel updateViewSize];
            }
        }
        return YES;
    };
}

- (BOOL (^)(void))updateAllItems {
    return ^{
        for (ZZFLEXSectionModel *sectionModel in self.data) {
            [sectionModel.headerViewModel updateViewSize];
            for (ZZFLEXViewModel *viewModel in sectionModel.itemsArray) {
                [viewModel updateViewSize];
            }
            [sectionModel.footerViewModel updateViewSize];
        }
        return YES;
    };
}

/// 更新所有Cell
- (BOOL (^)(void))updateAllCells {
    return ^{
        for (ZZFLEXSectionModel *sectionModel in self.data) {
            for (ZZFLEXViewModel *viewModel in sectionModel.itemsArray) {
                [viewModel updateViewSize];
            }
        }
        return YES;
    };
}

- (BOOL (^)(void))isEmpty {
    return ^{
        for (ZZFLEXSectionModel *sectionModel in self.data) {
            if (sectionModel.itemsArray.count > 0) {
                return NO;
            }
        }
        return YES;
    };
}

#pragma mark - # Section操作
/// 添加section
- (ZZFLEXAngelSectionChainModel * (^)(NSInteger tag))addSection {
    return ^(NSInteger tag) {
        if (self.hasSection(tag)) {
            ZZFLEXLog(@"!!!!! 重复添加Section：%ld", (long)tag);
        }

        ZZFLEXSectionModel *sectionModel = [[ZZFLEXSectionModel alloc] init];
        sectionModel.sectionTag = tag;

        [self.data addObject:sectionModel];
        ZZFLEXAngelSectionChainModel *chainSectionModel = [[ZZFLEXAngelSectionChainModel alloc] initWithSectionModel:sectionModel listData:self.data];
        return chainSectionModel;
    };
}

- (ZZFLEXAngelSectionInsertChainModel * (^)(NSInteger tag))insertSection {
    return ^(NSInteger tag) {
        if (self.hasSection(tag)) {
            ZZFLEXLog(@"!!!!! 重复添加Section：%ld", (long)tag);
        }

        ZZFLEXSectionModel *sectionModel = [[ZZFLEXSectionModel alloc] init];
        sectionModel.sectionTag = tag;

        ZZFLEXAngelSectionInsertChainModel *chainSectionModel = [[ZZFLEXAngelSectionInsertChainModel alloc] initWithSectionModel:sectionModel listData:self.data];
        return chainSectionModel;
    };
}

/// 获取section
- (ZZFLEXAngelSectionEditChainModel * (^)(NSInteger tag))sectionForTag {
    return ^(NSInteger tag) {
        ZZFLEXSectionModel *sectionModel = nil;
        for (sectionModel in self.data) {
            if (sectionModel.sectionTag == tag) {
                ZZFLEXAngelSectionEditChainModel *chainSectionModel = [[ZZFLEXAngelSectionEditChainModel alloc] initWithSectionModel:sectionModel listData:self.data];
                return chainSectionModel;
            }
        }
        return [[ZZFLEXAngelSectionEditChainModel alloc] initWithSectionModel:nil listData:self.data];
    };
}

/// 删除section
- (BOOL (^)(NSInteger tag))deleteSection {
    return ^(NSInteger tag) {
        ZZFLEXSectionModel *sectionModel = [self sectionModelForTag:tag];
        if (sectionModel) {
            [self.data removeObject:sectionModel];
            return YES;
        }
        return NO;
    };
}

/// 判断section是否存在
- (BOOL (^)(NSInteger tag))hasSection {
    return ^(NSInteger tag) {
        BOOL hasSection = [self sectionModelForTag:tag] ? YES : NO;
        return hasSection;
    };
}

#pragma mark - # Section View 操作
//MARK: Header
- (ZZFLEXAngelViewChainModel * (^)(Class viewClass))setHeader {
    return ^(Class viewClass) {
        return [self _setHeaderWithViewClass:viewClass xib:NO];
    };
}
- (ZZFLEXAngelViewChainModel * (^)(Class viewClass))setXibHeader {
    return ^(Class viewClass) {
        return [self _setHeaderWithViewClass:viewClass xib:YES];
    };
}
- (ZZFLEXAngelViewChainModel *)_setHeaderWithViewClass:(Class)viewClass xib:(BOOL)xib {
    ZZFLEXViewModel *viewModel = [[ZZFLEXViewModel alloc] initWithViewClass:viewClass vmDelegate:self];
    return [self viewChainViewModelWithViewModel:viewModel type:ZZFLEXAngelViewTypeHeader xib:xib];
}

//MARK: Footer
- (ZZFLEXAngelViewChainModel * (^)(Class viewClass))setFooter {
    return ^(Class viewClass) {
        return [self _setFotterWithViewClass:viewClass xib:NO];
    };
}
- (ZZFLEXAngelViewChainModel * (^)(Class viewClass))setXibFooter {
    return ^(Class viewClass) {
        return [self _setFotterWithViewClass:viewClass xib:YES];
    };
}
- (ZZFLEXAngelViewChainModel *)_setFotterWithViewClass:(Class)viewClass xib:(BOOL)xib {
    ZZFLEXViewModel *viewModel = [[ZZFLEXViewModel alloc] initWithViewClass:viewClass vmDelegate:self];
    return [self viewChainViewModelWithViewModel:viewModel type:ZZFLEXAngelViewTypeFooter xib:xib];
}

- (ZZFLEXAngelViewChainModel *)viewChainViewModelWithViewModel:(ZZFLEXViewModel *)viewModel type:(ZZFLEXAngelViewType)type xib:(BOOL)xib {
    ZZFLEXAngelViewChainModel *chainViewModel = [[ZZFLEXAngelViewChainModel alloc] initWithHostView:self.hostView listData:self.data viewModel:viewModel type:type xib:xib];
    return chainViewModel;
}

#pragma mark - # Cell 操作
/// 添加cell
- (ZZFLEXAngelViewChainModel * (^)(Class viewClass))addCell {
    return ^(Class viewClass) {
        return [self _addCellWithViewClass:viewClass xib:NO];
    };
}
/// 添加Xib Cell
- (ZZFLEXAngelViewChainModel * (^)(Class viewClass))addXibCell {
    return ^(Class viewClass) {
        return [self _addCellWithViewClass:viewClass xib:YES];
    };
}
- (ZZFLEXAngelViewChainModel *)_addCellWithViewClass:(Class)viewClass xib:(BOOL)xib {
    ZZFLEXViewModel *viewModel = [[ZZFLEXViewModel alloc] initWithViewClass:viewClass vmDelegate:self];
    return [self viewChainViewModelWithViewModel:viewModel type:ZZFLEXAngelViewTypeCell xib:xib];
}

/// 批量添加Cell
- (ZZFLEXAngelViewBatchChainModel * (^)(Class viewClass))addCells {
    return ^(Class viewClass) {
        return [self _addCellsWithViewClass:viewClass xib:NO];
    };
}
/// 批量添加Xib Cell
- (ZZFLEXAngelViewBatchChainModel * (^)(Class viewClass))addXibCells {
    return ^(Class viewClass) {
        return [self _addCellsWithViewClass:viewClass xib:YES];
    };
}
- (ZZFLEXAngelViewBatchChainModel *)_addCellsWithViewClass:(Class)viewClass xib:(BOOL)xib {
    ZZFLEXAngelViewBatchChainModel *viewModel = [[ZZFLEXAngelViewBatchChainModel alloc] initWithHostView:self.hostView viewClass:viewClass vmDelegate:self listData:self.data xib:xib];
    return viewModel;
}

/// 添加空白cell
- (ZZFLEXAngelViewChainModel * (^)(CGSize size, UIColor *color))addSeperatorCell;
{
    return ^(CGSize size, UIColor *color) {
        Class viewClass =
        [self.hostView isKindOfClass:[UITableView class]] ? [ZZFLEXTableViewEmptyCell class] : [ZZFlexibleLayoutSeperatorCell class];
        ZZFlexibleLayoutSeperatorModel *dataModel = [[ZZFlexibleLayoutSeperatorModel alloc] initWithSize:size andColor:color];
        ZZFLEXViewModel *viewModel = [[ZZFLEXViewModel alloc] initWithViewClass:viewClass vmDelegate:self dataModel:dataModel];
        return [self viewChainViewModelWithViewModel:viewModel type:ZZFLEXAngelViewTypeCell xib:NO];
    };
}

/// 插入XibCell
- (ZZFLEXAngelViewInsertChainModel * (^)(Class viewClass))insertCell {
    return ^(Class viewClass) {
        return [self _insertCellWithViewClass:viewClass xib:NO];
    };
}
/// 插入XibCell
- (ZZFLEXAngelViewInsertChainModel * (^)(Class viewClass))insertXibCell {
    return ^(Class viewClass) {
        return [self _insertCellWithViewClass:viewClass xib:YES];
    };
}
- (ZZFLEXAngelViewInsertChainModel *)_insertCellWithViewClass:(Class)viewClass xib:(BOOL)xib {
    ZZFLEXViewModel *viewModel = [[ZZFLEXViewModel alloc] initWithViewClass:viewClass vmDelegate:self];
    ZZFLEXAngelViewInsertChainModel *chainViewModel = [[ZZFLEXAngelViewInsertChainModel alloc] initWithHostView:self.hostView listData:self.data viewModel:viewModel type:ZZFLEXAngelViewTypeCell xib:xib];
    return chainViewModel;
}

/// 批量插入cells
- (ZZFLEXAngelViewBatchInsertChainModel * (^)(Class viewClass))insertCells {
    return ^(Class viewClass) {
        return [self _insertCellsWithViewClass:viewClass xib:NO];
    };
}
- (ZZFLEXAngelViewBatchInsertChainModel * (^)(Class viewClass))insertXibCells {
    return ^(Class viewClass) {
        return [self _insertCellsWithViewClass:viewClass xib:YES];
    };
}
- (ZZFLEXAngelViewBatchInsertChainModel *)_insertCellsWithViewClass:(Class)viewClass xib:(BOOL)xib {
    ZZFLEXAngelViewBatchInsertChainModel *viewModel = [[ZZFLEXAngelViewBatchInsertChainModel alloc] initWithHostView:self.hostView
                                                                                                           viewClass:viewClass
                                                                                                          vmDelegate:self
                                                                                                            listData:self.data
                                                                                                                 xib:xib];
    return viewModel;
}

/// 删除cell
- (ZZFLEXAngelViewEditChainModel *)deleteCell {
    ZZFLEXAngelViewEditChainModel *deleteModel = [[ZZFLEXAngelViewEditChainModel alloc] initWithType:ZZFLEXAngelViewEditTypeDelete andListData:self.data];
    return deleteModel;
}

/// 批量删除cell
- (ZZFLEXAngelViewBatchEditChainModel *)deleteCells {
    ZZFLEXAngelViewBatchEditChainModel *deleteModel = [[ZZFLEXAngelViewBatchEditChainModel alloc] initWithType:ZZFLEXAngelViewEditTypeDelete andListData:self.data];
    return deleteModel;
}

/// 更新cell
- (ZZFLEXAngelViewEditChainModel *)updateCell {
    ZZFLEXAngelViewEditChainModel *deleteModel = [[ZZFLEXAngelViewEditChainModel alloc] initWithType:ZZFLEXAngelViewEditTypeUpdate andListData:self.data];
    return deleteModel;
}

/// 批量更新cell
- (ZZFLEXAngelViewBatchEditChainModel *)updateCells {
    ZZFLEXAngelViewBatchEditChainModel *deleteModel = [[ZZFLEXAngelViewBatchEditChainModel alloc] initWithType:ZZFLEXAngelViewEditTypeUpdate andListData:self.data];
    return deleteModel;
}

/// 包含cell
- (ZZFLEXAngelViewEditChainModel *)hasCell {
    ZZFLEXAngelViewEditChainModel *deleteModel = [[ZZFLEXAngelViewEditChainModel alloc] initWithType:ZZFLEXAngelViewEditTypeHas andListData:self.data];
    return deleteModel;
}

#pragma mark - # DataModel 数据源获取
/// 数据源获取
- (ZZFLEXAngelViewEditChainModel *)dataModel {
    ZZFLEXAngelViewEditChainModel *dataModel = [[ZZFLEXAngelViewEditChainModel alloc] initWithType:ZZFLEXAngelViewEditTypeDataModel andListData:self.data];
    return dataModel;
}

/// 批量获取数据源
- (ZZFLEXAngelViewBatchEditChainModel *)dataModelArray {
    ZZFLEXAngelViewBatchEditChainModel *dataModel = [[ZZFLEXAngelViewBatchEditChainModel alloc] initWithType:ZZFLEXAngelViewEditTypeDataModel andListData:self.data];
    return dataModel;
}

#pragma mark - # IndexPath
- (ZZFLEXAngelIndexPathChainModel *)indexPath {
    ZZFLEXAngelIndexPathChainModel *indexPath = [[ZZFLEXAngelIndexPathChainModel alloc] initWithListData:self.data];
    return indexPath;
}
@end
