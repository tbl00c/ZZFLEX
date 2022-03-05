//
//  ZZFLEXAngelViewEditChainModel.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/12/11.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFLEXAngelViewEditChainModel.h"
#import "ZZFLEXSectionModel.h"

#pragma mark - ## ZZFLEXAngelViewEditChainModel (单个)
@interface ZZFLEXAngelViewEditChainModel ()

@property (nonatomic, assign) ZZFLEXAngelViewEditType editType;

@property (nonatomic, strong) NSArray *listData;

@end

@implementation ZZFLEXAngelViewEditChainModel

- (instancetype)initWithType:(ZZFLEXAngelViewEditType)type andListData:(NSArray *)listData {
    if (self = [super init]) {
        self.editType = type;
        self.listData = listData;
    }
    return self;
}

- (id (^)(NSInteger viewTag))byViewTag {
    return ^id(NSInteger viewTag) {
        for (ZZFLEXSectionModel *sectionModel in self.listData) {
            for (ZZFLEXViewModel *viewModel in sectionModel.itemsArray) {
                if (viewModel.viewTag == viewTag) {
                    return [self p_executeWithSectionModel:sectionModel viewModel:viewModel];
                }
            }
        }
        return nil;
    };
}

- (id (^)(id dataModel))byDataModel {
    return ^id(id dataModel) {
        for (ZZFLEXSectionModel *sectionModel in self.listData) {
            for (ZZFLEXViewModel *viewModel in sectionModel.itemsArray) {
                if (viewModel.dataModel == dataModel) {
                    return [self p_executeWithSectionModel:sectionModel viewModel:viewModel];
                }
            }
        }
        return nil;
    };
}

- (id (^)(NSString *className))byViewClassName {
    return ^id(NSString *className) {
        for (ZZFLEXSectionModel *sectionModel in self.listData) {
            for (ZZFLEXViewModel *viewModel in sectionModel.itemsArray) {
                if ([NSStringFromClass(viewModel.viewClass) isEqualToString:className]) {
                    return [self p_executeWithSectionModel:sectionModel viewModel:viewModel];
                }
            }
        }
        return nil;
    };
}

- (id (^)(NSIndexPath *indexPath))atIndexPath {
    return ^id(NSIndexPath *indexPath) {
        ZZFLEXSectionModel *sectionModel = (indexPath.section >=0 && indexPath.section < self.listData.count) ? self.listData[indexPath.section] : nil;
        if (sectionModel) {
            ZZFLEXViewModel *viewModel = (indexPath.row >= 0 && indexPath.row < sectionModel.itemsArray.count) ? sectionModel.itemsArray[indexPath.row] : nil;
            if (viewModel) {
                return [self p_executeWithSectionModel:sectionModel viewModel:viewModel];
            }
        }
        return nil;
    };
}

#pragma mark - # Private Methods
- (id)p_executeWithSectionModel:(ZZFLEXSectionModel *)sectionModel viewModel:(ZZFLEXViewModel *)viewModel {
    if (self.editType == ZZFLEXAngelViewEditTypeDelete) {
        [sectionModel.itemsArray removeObject:viewModel];
        return nil;
    }
    else if (self.editType == ZZFLEXAngelViewEditTypeUpdate) {
        [viewModel updateViewSize];
        return nil;
    }
    else if (self.editType == ZZFLEXAngelViewEditTypeDataModel) {
        return viewModel.dataModel;
    }
    else if (self.editType == ZZFLEXAngelViewEditTypeHas) {
        return viewModel.dataModel;
    }
    return nil;
}

@end

#pragma mark - ## ZZFLEXAngelViewBatchEditChainModel (批量)
@interface ZZFLEXAngelViewBatchEditChainModel ()

@property (nonatomic, strong) NSArray *listData;

@property (nonatomic, assign) ZZFLEXAngelViewEditType editType;

@end

@implementation ZZFLEXAngelViewBatchEditChainModel

- (instancetype)initWithType:(ZZFLEXAngelViewEditType)type andListData:(NSArray *)listData {
    if (self = [super init]) {
        self.editType = type;
        self.listData = listData;
    }
    return self;
}

- (NSArray *(^)(void))all {
    return ^NSArray *(void) {
        NSMutableArray *viewModelArray = [[NSMutableArray alloc] init];
        for (ZZFLEXSectionModel *sectionModel in self.listData) {
            if (self.editType == ZZFLEXAngelViewEditTypeDelete) {       // 删除
                [sectionModel.itemsArray removeAllObjects];
            }
            else if (self.editType == ZZFLEXAngelViewEditTypeDataModel) {       // 获取
                [viewModelArray addObjectsFromArray:sectionModel.itemsArray];
            }
        }
        if (self.editType == ZZFLEXAngelViewEditTypeUpdate) {
            [self p_updateViewModelArray:viewModelArray];
        }
        return [self dataModelArrayByViewModelArray:viewModelArray];
    };
}

- (NSArray *(^)(NSInteger viewTag))byViewTag {
    return ^NSArray *(NSInteger viewTag) {
        NSMutableArray *viewModelArray = [[NSMutableArray alloc] init];
        for (ZZFLEXSectionModel *sectionModel in self.listData) {
            NSMutableArray *data = [[NSMutableArray alloc] init];
            for (ZZFLEXViewModel *viewModel in sectionModel.itemsArray) {
                if (viewModel.viewTag == viewTag) {
                    [data addObject:viewModel];
                }
            }
            if (self.editType == ZZFLEXAngelViewEditTypeDelete) {
                [self p_deleteWithSectionModel:sectionModel viewModelArray:data];
            }
            [viewModelArray addObjectsFromArray:data];
        }
        if (self.editType == ZZFLEXAngelViewEditTypeUpdate) {
            [self p_updateViewModelArray:viewModelArray];
        }
        if (self.editType == ZZFLEXAngelViewEditTypeDataModel) {
            return [self dataModelArrayByViewModelArray:viewModelArray];
        }
        return nil;
    };
}

- (NSArray *(^)(id dataModel))byDataModel {
    return ^NSArray *(id dataModel) {
        NSMutableArray *viewModelArray = [[NSMutableArray alloc] init];
        for (ZZFLEXSectionModel *sectionModel in self.listData) {
            NSMutableArray *data = [[NSMutableArray alloc] init];
            for (ZZFLEXViewModel *viewModel in sectionModel.itemsArray) {
                if (viewModel.dataModel == dataModel) {
                    [data addObject:viewModel];
                }
            }
            if (self.editType == ZZFLEXAngelViewEditTypeDelete) {
                [self p_deleteWithSectionModel:sectionModel viewModelArray:data];
            }
            [viewModelArray addObjectsFromArray:data];
        }
        if (self.editType == ZZFLEXAngelViewEditTypeUpdate) {
            [self p_updateViewModelArray:viewModelArray];
        }
        return nil;
    };
}

- (NSArray * (^)(NSString *className))byViewClassName {
    return ^NSArray *(NSString *className) {
        NSMutableArray *viewModelArray = [[NSMutableArray alloc] init];
        for (ZZFLEXSectionModel *sectionModel in self.listData) {
            NSMutableArray *data = [[NSMutableArray alloc] init];
            for (ZZFLEXViewModel *viewModel in sectionModel.itemsArray) {
                if ([NSStringFromClass(viewModel.viewClass) isEqualToString:className]) {
                    [data addObject:viewModel];
                }
            }
            if (self.editType == ZZFLEXAngelViewEditTypeDelete) {
                [self p_deleteWithSectionModel:sectionModel viewModelArray:data];
            }
            [viewModelArray addObjectsFromArray:data];
        }
        if (self.editType == ZZFLEXAngelViewEditTypeUpdate) {
            [self p_updateViewModelArray:viewModelArray];
        }
        if (self.editType == ZZFLEXAngelViewEditTypeDataModel) {
            return [self dataModelArrayByViewModelArray:viewModelArray];
        }
        return nil;
    };
}

- (NSArray *)p_deleteWithSectionModel:(ZZFLEXSectionModel *)sectionModel viewModelArray:(NSArray *)viewModelArray {
    for (ZZFLEXViewModel *viewModel in viewModelArray) {
        if (viewModel == sectionModel.headerViewModel) {
            sectionModel.headerViewModel = nil;
        }
        else if (viewModel == sectionModel.footerViewModel) {
            sectionModel.footerViewModel = nil;
        }
        else {
            [sectionModel.itemsArray removeObject:viewModel];
        }
    }
    return nil;
}

- (void)p_updateViewModelArray:(NSArray *)viewModelArray {
    for (ZZFLEXViewModel *viewModel in viewModelArray) {
        [viewModel updateViewSize];
    }
}

- (NSArray *)dataModelArrayByViewModelArray:(NSArray *)viewModelArray {
    NSMutableArray *data = [[NSMutableArray alloc] initWithCapacity:viewModelArray.count];
    for (ZZFLEXViewModel *viewModel in viewModelArray) {
        if (viewModel.dataModel) {
            [data addObject:viewModel.dataModel];
        }
    }
    return data;
}

@end

