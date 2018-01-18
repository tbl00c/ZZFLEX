//
//  ZZFLEXChainViewEditModel.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/12/11.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFLEXChainViewEditModel.h"
#import "ZZFlexibleLayoutSectionModel.h"

#pragma mark - ## ZZFLEXChainViewEditModel (单个)
@interface ZZFLEXChainViewEditModel ()

@property (nonatomic, assign) ZZFLEXChainViewEditType editType;

@property (nonatomic, strong) NSArray *listData;

@end

@implementation ZZFLEXChainViewEditModel

- (instancetype)initWithType:(ZZFLEXChainViewEditType)type andListData:(NSArray *)listData
{
    if (self = [super init]) {
        self.editType = type;
        self.listData = listData;
    }
    return self;
}

- (id (^)(NSInteger viewTag))byViewTag
{
    return ^id(NSInteger viewTag) {
        for (ZZFlexibleLayoutSectionModel *sectionModel in self.listData) {
            for (ZZFlexibleLayoutViewModel *viewModel in sectionModel.itemsArray) {
                if (viewModel.viewTag == viewTag) {
                    return [self p_executeWithSectionModel:sectionModel viewModel:viewModel];
                }
            }
        }
        return nil;
    };
}

- (id (^)(id dataModel))byDataModel
{
    return ^id(id dataModel) {
        for (ZZFlexibleLayoutSectionModel *sectionModel in self.listData) {
            for (ZZFlexibleLayoutViewModel *viewModel in sectionModel.itemsArray) {
                if (viewModel.dataModel == dataModel) {
                    return [self p_executeWithSectionModel:sectionModel viewModel:viewModel];
                }
            }
        }
        return nil;
    };
}

- (id (^)(NSString *className))byViewClassName
{
    return ^id(NSString *className) {
        for (ZZFlexibleLayoutSectionModel *sectionModel in self.listData) {
            for (ZZFlexibleLayoutViewModel *viewModel in sectionModel.itemsArray) {
                if ([viewModel.className isEqualToString:className]) {
                    return [self p_executeWithSectionModel:sectionModel viewModel:viewModel];
                }
            }
        }
        return nil;
    };
}

- (id (^)(NSIndexPath *indexPath))atIndexPath
{
    return ^id(NSIndexPath *indexPath) {
        ZZFlexibleLayoutSectionModel *sectionModel = (indexPath.section >=0 && indexPath.section < self.listData.count) ? self.listData[indexPath.section] : nil;
        if (sectionModel) {
            ZZFlexibleLayoutViewModel *viewModel = (indexPath.row >= 0 && indexPath.row < sectionModel.itemsArray.count) ? sectionModel.itemsArray[indexPath.row] : nil;
            if (viewModel) {
                return [self p_executeWithSectionModel:sectionModel viewModel:viewModel];
            }
        }
        return nil;
    };
}

- (id (^)(NSInteger sectionTag, NSInteger viewTag))bySectionTagAndViewTag
{
    return ^id(NSInteger sectionTag, NSInteger viewTag) {
        for (ZZFlexibleLayoutSectionModel *sectionModel in self.listData) {
            if (sectionModel.sectionTag == sectionTag) {
                for (ZZFlexibleLayoutViewModel *viewModel in sectionModel.itemsArray) {
                    if (viewModel.viewTag == viewTag) {
                        return [self p_executeWithSectionModel:sectionModel viewModel:viewModel];
                    }
                }
            }
        }
        return nil;
    };
}

#pragma mark - # Private Methods
- (id)p_executeWithSectionModel:(ZZFlexibleLayoutSectionModel *)sectionModel viewModel:(ZZFlexibleLayoutViewModel *)viewModel
{
    if (self.editType == ZZFLEXChainViewEditTypeDelete) {
        [sectionModel.itemsArray removeObject:viewModel];
        return nil;
    }
    else if (self.editType == ZZFLEXChainViewEditTypeUpdate) {
        [viewModel updateViewHeight];
        return nil;
    }
    else if (self.editType == ZZFLEXChainViewEditTypeDataModel) {
        return viewModel.dataModel;
    }
    else if (self.editType == ZZFLEXChainViewEditTypeHas) {
        return nil;
    }
    return nil;
}

@end

#pragma mark - ## ZZFLEXChainViewBatchEditModel (批量)
@interface ZZFLEXChainViewBatchEditModel ()

@property (nonatomic, strong) NSArray *listData;

@property (nonatomic, assign) ZZFLEXChainViewEditType editType;

@end

@implementation ZZFLEXChainViewBatchEditModel

- (instancetype)initWithType:(ZZFLEXChainViewEditType)type andListData:(NSArray *)listData
{
    if (self = [super init]) {
        self.editType = type;
        self.listData = listData;
    }
    return self;
}

- (NSArray *(^)(void))all
{
    return ^NSArray *(void) {
        for (ZZFlexibleLayoutSectionModel *sectionModel in self.listData) {
            if (sectionModel.itemsArray.count > 0) {
                [self p_executeWithSectionModel:sectionModel viewModelArray:sectionModel.itemsArray];
            }
        }
        return nil;
    };
}

- (NSArray *(^)(NSInteger viewTag))byViewTag
{
    return ^NSArray *(NSInteger viewTag) {
        for (ZZFlexibleLayoutSectionModel *sectionModel in self.listData) {
            NSMutableArray *data = @[].mutableCopy;
            for (ZZFlexibleLayoutViewModel *viewModel in sectionModel.itemsArray) {
                if (viewModel.viewTag == viewTag) {
                    [data addObject:viewModel];
                }
            }
            return [self p_executeWithSectionModel:sectionModel viewModelArray:data];
        }
        return nil;
    };
}

- (NSArray *(^)(id dataModel))byDataModel
{
    return ^NSArray *(id dataModel) {
        for (ZZFlexibleLayoutSectionModel *sectionModel in self.listData) {
            NSMutableArray *data = @[].mutableCopy;
            for (ZZFlexibleLayoutViewModel *viewModel in sectionModel.itemsArray) {
                if (viewModel.dataModel == dataModel) {
                    [data addObject:viewModel];
                }
            }
            return [self p_executeWithSectionModel:sectionModel viewModelArray:data];
        }
        return nil;
    };
}

- (NSArray *(^)(NSString *className))byViewClassName
{
    return ^NSArray *(NSString *className) {
        for (ZZFlexibleLayoutSectionModel *sectionModel in self.listData) {
            NSMutableArray *data = @[].mutableCopy;
            for (ZZFlexibleLayoutViewModel *viewModel in sectionModel.itemsArray) {
                if ([viewModel.className isEqualToString:className]) {
                    [data addObject:viewModel];
                }
            }
            return [self p_executeWithSectionModel:sectionModel viewModelArray:data];
        }
        return nil;
    };
}

- (NSArray *(^)(NSInteger sectionTag, NSInteger viewTag))bySectionTagAndViewTag
{
    return ^NSArray *(NSInteger sectionTag, NSInteger viewTag) {
        for (ZZFlexibleLayoutSectionModel *sectionModel in self.listData) {
            if (sectionModel.sectionTag == sectionTag) {
                NSMutableArray *data = @[].mutableCopy;
                for (ZZFlexibleLayoutViewModel *viewModel in sectionModel.itemsArray) {
                    if (viewModel.viewTag == viewTag) {
                        [data addObject:viewModel];
                    }
                }
                return [self p_executeWithSectionModel:sectionModel viewModelArray:data];
            }
        }
        return nil;
    };
}

- (NSArray *)p_executeWithSectionModel:(ZZFlexibleLayoutSectionModel *)sectionModel viewModelArray:(NSArray *)viewModelArray
{
    if (self.editType == ZZFLEXChainViewEditTypeDelete) {
        for (ZZFlexibleLayoutViewModel *viewModel in viewModelArray) {
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
    else if (self.editType == ZZFLEXChainViewEditTypeDataModel) {
        NSMutableArray *data = [[NSMutableArray alloc] init];
        for (ZZFlexibleLayoutViewModel *viewModel in viewModelArray) {
            if (![viewModel.dataModel isKindOfClass:[NSNull class]]) {
                [data addObject:viewModel.dataModel];
            }
        }
        return data;
    }
    else if (self.editType == ZZFLEXChainViewEditTypeUpdate) {
        for (ZZFlexibleLayoutViewModel *viewModel in viewModelArray) {
            [viewModel updateViewHeight];
        }
        return nil;
    }
    return nil;
}

@end

