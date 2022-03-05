//
//  ZZFLEXAngelViewBatchChainModel.m
//  zhuanzhuan
//
//  Created by lbk on 2017/8/15.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZFLEXAngelViewBatchChainModel.h"
#import "ZZFLEXSectionModel.h"
#import "ZZFLEXMacros.h"

#pragma mark - ## ZZFLEXAngelViewBaseBatchChainModel （批量，基类）
@interface ZZFLEXAngelViewBaseBatchChainModel()

@property (nonatomic, weak, readonly) __kindof UIScrollView *hostView;
@property (nonatomic, assign, readonly) BOOL xib;

@property (nonatomic, assign) Class viewClass;
@property (nonatomic, strong) NSMutableArray *listData;

@property (nonatomic, strong) NSMutableArray<ZZFLEXViewModel *> *viewModelArray;
@property (nonatomic, strong) ZZFLEXSectionModel *sectionModel;
@property (nonatomic, weak) id itemsDelegate;
@property (nonatomic, strong) NSString *itemReuseIdentifier;
@property (nonatomic, copy) id (^itemsEventAction)(NSInteger actionType, id data);
@property (nonatomic, copy) void (^itemsSelectedAction)(id data);
@property (nonatomic, copy) void (^itemsConfigAction)(__kindof UIView *itemView, id data);
@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, assign) CGSize itemViewSize;

@end

@implementation ZZFLEXAngelViewBaseBatchChainModel

- (instancetype)initWithHostView:(__kindof UIScrollView *)hostView viewClass:(Class)viewClass vmDelegate:(id<ZZFLEXViewModelDelegate>)vmDelegate listData:(NSMutableArray *)listData xib:(BOOL)xib {
    if (self = [super init]) {
        _hostView = hostView;
        _xib = xib;
        _viewModelArray = [[NSMutableArray alloc] init];
        _viewClass = viewClass;
        _vmDelegate = vmDelegate;
        _listData = listData;
        [self registerCellIfNeed];
    }
    return self;
}

- (id (^)(NSInteger section))toSection {
    return ^(NSInteger section) {
        for (ZZFLEXSectionModel *sectionModel in self.listData) {
            if (sectionModel.sectionTag == section) {
                self.sectionModel = sectionModel;
                if (self.viewModelArray.count > 0) {
                    [sectionModel addObjectsFromArray:self.viewModelArray];
                }
                break;
            }
        }
        return self;
    };
}

- (id (^)(NSArray *dataModelArray))withDataModelArray {
    return ^(NSArray *dataModelArray) {
        for (id model in dataModelArray) {
            ZZFLEXViewModel *viewModel = [[ZZFLEXViewModel alloc] initWithViewClass:self.viewClass reuseIdentifier:self.itemReuseIdentifier vmDelegate:self.vmDelegate dataModel:model viewSize:self.itemViewSize viewTag:self.tag];
            [viewModel setDelegate:self.itemsDelegate];
            [viewModel setEventAction:self.itemsEventAction];
            [viewModel setSelectedAction:self.itemsSelectedAction];
            [viewModel setConfigAction:self.itemsConfigAction];
            [self.viewModelArray addObject:viewModel];
        }
        if (self.sectionModel) {
            [self.sectionModel addObjectsFromArray:self.viewModelArray];
        }
        return self;
    };
}

- (id (^)(NSString *reuseIdentifier))reuseIdentifier {
    return ^(NSString *reuseIdentifier) {
        [self setItemReuseIdentifier:reuseIdentifier];
        [self registerCellIfNeed];
        return self;
    };
}

- (id (^)(id delegate))delegate {
    return ^(id delegate) {
        [self setItemsDelegate:delegate];
        return self;
    };
}

- (id (^)(id ((^)(NSInteger actionType, id data))))eventAction {
    return ^(id ((^eventAction)(NSInteger actionType, id data))) {
        [self setItemsEventAction:eventAction];
        return self;
    };
}

- (id (^)(void ((^)(id data))))selectedAction {
    return ^(void ((^selectedAction)(id data))) {
        [self setItemsSelectedAction:selectedAction];
        return self;
    };
}

- (id (^)(void ((^)(__kindof UIView *itemView, id dataModel))))configAction {
    return ^(void ((^configAction)(__kindof UIView *itemView, id dataModel))) {
        [self setItemConfigAction:configAction];
        return self;
    };
}

- (id (^)(NSInteger viewTag))viewTag {
    return ^(NSInteger viewTag) {
        [self setTag:viewTag];
        return self;
    };
}

- (id (^)(CGSize size))viewSize {
    return ^(CGSize size) {
        [self setItemViewSize:size];
        return self;
    };
}

- (id (^)(CGFloat height))viewHeight {
    return ^(CGFloat height) {
        [self setItemViewSize:CGSizeMake(-1, height)];
        return self;
    };
}

- (void)registerCellIfNeed {
    if (!self.viewClass) {
        return;
    }
    NSString *reuseIdentifier = self.itemReuseIdentifier ? self.itemReuseIdentifier : NSStringFromClass(self.viewClass);
    self.xib ? RegisterHostViewXibCell(self.hostView, self.viewClass, reuseIdentifier) :
               RegisterHostViewCell(self.hostView, self.viewClass, reuseIdentifier);
}

#pragma mark - # Setters
- (void)setItemReuseIdentifier:(NSString *)itemReuseIdentifier {
    _itemReuseIdentifier = itemReuseIdentifier;
    for (ZZFLEXViewModel *viewModel in self.viewModelArray) {
        [viewModel setReuseIdentifier:itemReuseIdentifier];
    }
}

- (void)setItemsDelegate:(id)itemsDelegate {
    _itemsDelegate = itemsDelegate;
    for (ZZFLEXViewModel *viewModel in self.viewModelArray) {
        [viewModel setDelegate:itemsDelegate];
    }
}

- (void)setItemsEventAction:(id (^)(NSInteger, id))itemsEventAction {
    _itemsEventAction = itemsEventAction;
    for (ZZFLEXViewModel *viewModel in self.viewModelArray) {
        [viewModel setEventAction:itemsEventAction];
    }
}

- (void)setItemsSelectedAction:(void (^)(id))itemsSelectedAction {
    _itemsSelectedAction = itemsSelectedAction;
    for (ZZFLEXViewModel *viewModel in self.viewModelArray) {
        [viewModel setSelectedAction:itemsSelectedAction];
    }
}

- (void)setItemConfigAction:(void (^)(__kindof UIView *view, id dataModel))itemConfigAction {
    _itemsConfigAction = itemConfigAction;
    for (ZZFLEXViewModel *viewModel in self.viewModelArray) {
        [viewModel setConfigAction:itemConfigAction];
    }
}

- (void)setTag:(NSInteger)tag {
    _tag = tag;
    for (ZZFLEXViewModel *viewModel in self.viewModelArray) {
        [viewModel setViewTag:tag];
    }
}

- (void)setItemViewSize:(CGSize)itemViewSize {
    _itemViewSize = itemViewSize;
    for (ZZFLEXViewModel *viewModel in self.viewModelArray) {
        [viewModel setViewSize:itemViewSize];
    }
}

@end

#pragma mark - ## ZZFLEXAngelViewBatchChainModel （批量，添加）
@implementation ZZFLEXAngelViewBatchChainModel

@end

#pragma mark - ## ZZFLEXAngelViewBatchInsertChainModel （批量，插入）
typedef NS_OPTIONS(NSInteger, ZZFLEXInsertArrayDataStatus) {
    ZZFLEXInsertArrayDataStatusIndex = 1 << 0,
    ZZFLEXInsertArrayDataStatusBefore = 1 << 1,
    ZZFLEXInsertArrayDataStatusAfter = 1 << 2,
};

@interface ZZFLEXAngelViewBatchInsertChainModel ()

@property (nonatomic, assign) ZZFLEXInsertArrayDataStatus status;

@property (nonatomic, assign) NSInteger insertTag;

@end

@implementation ZZFLEXAngelViewBatchInsertChainModel

- (id (^)(NSArray *dataModelArray))withDataModelArray {
    return ^(NSArray *dataModelArray) {
        for (id model in dataModelArray) {
            ZZFLEXViewModel *viewModel = [[ZZFLEXViewModel alloc] initWithViewClass:self.viewClass vmDelegate:self.vmDelegate dataModel:model];
            [viewModel setViewTag:self.tag];
            [viewModel setDelegate:self.itemsDelegate];
            [viewModel setEventAction:self.itemsEventAction];
            [viewModel setSelectedAction:self.itemsSelectedAction];
            [self.viewModelArray addObject:viewModel];
        }
        
        [self p_tryInsertCells];
        return self;
    };
}

- (id (^)(NSInteger section))toSection {
    return ^(NSInteger section) {
        for (ZZFLEXSectionModel *sectionModel in self.listData) {
            if (sectionModel.sectionTag == section) {
                self.sectionModel = sectionModel;
                break;
            }
        }
        
        [self p_tryInsertCells];
        return self;
    };
}


- (ZZFLEXAngelViewBatchInsertChainModel *(^)(NSInteger index))toIndex {
    return ^(NSInteger index) {
        self.status |= ZZFLEXInsertArrayDataStatusIndex;
        self.insertTag = index;
        
        [self p_tryInsertCells];
        return self;
    };
}

- (ZZFLEXAngelViewBatchInsertChainModel *(^)(NSInteger sectionTag))beforeCell {
    return ^(NSInteger sectionTag) {
        self.status |= ZZFLEXInsertArrayDataStatusBefore;
        self.insertTag = sectionTag;
        
        [self p_tryInsertCells];
        return self;
    };
}

- (ZZFLEXAngelViewBatchInsertChainModel *(^)(NSInteger sectionTag))afterCell {
    return ^(NSInteger sectionTag) {
        self.status |= ZZFLEXInsertArrayDataStatusAfter;
        self.insertTag = sectionTag;
        
        [self p_tryInsertCells];
        return self;
    };
}

- (void)p_tryInsertCells {
    if (!self.sectionModel || self.viewModelArray.count == 0) {
        return;
    }
    NSInteger index = -1;
    if (self.status & ZZFLEXInsertArrayDataStatusIndex) {
        index = self.insertTag;
    }
    else if ((self.status & ZZFLEXInsertArrayDataStatusBefore)|| (self.status & ZZFLEXInsertArrayDataStatusAfter)) {
        for (NSInteger i = 0; i < self.sectionModel.itemsArray.count; i++) {
            ZZFLEXViewModel *viewModel = [self.sectionModel objectAtIndex:i];
            if (viewModel.viewTag == self.insertTag) {
                index = (self.status & ZZFLEXInsertArrayDataStatusBefore) ? i : i + 1;
                break;
            }
        }
    }
    
    if (index >= 0 && index <= self.sectionModel.count) {
        NSRange range = NSMakeRange(index, [self.viewModelArray count]);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.sectionModel insertObjects:self.viewModelArray atIndexes:indexSet];
        self.status = 0;
    }
}

@end

