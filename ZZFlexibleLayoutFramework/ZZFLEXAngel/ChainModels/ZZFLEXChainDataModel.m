//
//  ZZFLEXChainDataModel.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/12/11.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFLEXChainDataModel.h"
#import "ZZFlexibleLayoutSectionModel.h"

@interface ZZFLEXChainDataModel ()

@property (nonatomic, strong) NSArray *listData;

@end

@implementation ZZFLEXChainDataModel

- (instancetype)initWithListData:(NSArray *)listData
{
    if (self = [super init]) {
        self.listData = listData;
    }
    return self;
}


- (id (^)(NSInteger cellTag))cellModelByCellTag
{
    return ^id (NSInteger cellTag) {
        for (ZZFlexibleLayoutSectionModel *sectionModel in self.listData) {
            for (ZZFlexibleLayoutViewModel *viewModel in sectionModel.itemsArray) {
                if (viewModel.viewTag == cellTag) {
                    return [viewModel.dataModel isKindOfClass:[NSNull class]] ? nil : viewModel.dataModel;
                }
            }
        }
        return nil;
    };
}


- (id (^)(NSInteger sectionTag, NSInteger cellTag))cellModelBySectionTagAndCellTag
{
    return ^id (NSInteger sectionTag, NSInteger cellTag) {
        for (ZZFlexibleLayoutSectionModel *sectionModel in self.listData) {
            if (sectionModel.sectionTag == sectionTag) {
                for (ZZFlexibleLayoutViewModel *viewModel in sectionModel.itemsArray) {
                    if (viewModel.viewTag == cellTag) {
                        return [viewModel.dataModel isKindOfClass:[NSNull class]] ? nil : viewModel.dataModel;
                    }
                }
            }
        }
        return nil;
    };
}

- (id (^)(NSIndexPath *indexPath))cellModelByIndexPath
{
    return ^id (NSIndexPath *indexPath) {
        if (indexPath.section >= 0 && indexPath.section < self.listData.count) {
            ZZFlexibleLayoutSectionModel *sectionModel = self.listData[indexPath.section];
            if (indexPath.row >= 0 && indexPath.row > sectionModel.itemsArray.count) {
                ZZFlexibleLayoutViewModel *viewModel = [sectionModel objectAtIndex:indexPath.row];
                return viewModel;
            }
        }
        return nil;
    };
}

- (NSArray *(^)(NSInteger cellTag))cellsModelArrayByCellTag
{
    return ^(NSInteger cellTag) {
        NSMutableArray *data = @[].mutableCopy;
        for (ZZFlexibleLayoutSectionModel *sectionModel in self.listData) {
            for (ZZFlexibleLayoutViewModel *viewModel in sectionModel.itemsArray) {
                if (viewModel.viewTag == cellTag) {
                    [data addObject:viewModel.dataModel];
                }
            }
        }
        return data;
    };
}

- (NSArray *(^)(NSInteger sectionTag, NSInteger cellTag))cellsModelArrayBySectionTagAndCellTag
{
    return ^(NSInteger sectionTag, NSInteger cellTag) {
        NSMutableArray *data = @[].mutableCopy;
        for (ZZFlexibleLayoutSectionModel *sectionModel in self.listData) {
            if (sectionModel.sectionTag == sectionTag) {
                for (ZZFlexibleLayoutViewModel *viewModel in sectionModel.itemsArray) {
                    if (viewModel.viewTag == cellTag) {
                        [data addObject:viewModel.dataModel];
                    }
                }
            }
        }
        return data;
    };
}

- (NSArray *(^)(NSArray<NSIndexPath *> *indexPathArray))cellModelArrayByIndexPaths
{
    return ^(NSArray<NSIndexPath *> *indexPathArray) {
        NSMutableArray *data = @[].mutableCopy;
        for (NSIndexPath *indexPath in indexPathArray) {
            if (indexPath.section >= 0 && indexPath.section < self.listData.count) {
                ZZFlexibleLayoutSectionModel *sectionModel = self.listData[indexPath.section];
                if (indexPath.row >= 0 && indexPath.row > sectionModel.itemsArray.count) {
                    ZZFlexibleLayoutViewModel *viewModel = [sectionModel objectAtIndex:indexPath.row];
                    [data addObject:viewModel];
                }
            }
        }
        return data;
    };
}

- (id (^)(NSInteger setionTag))sectionHeaderModelByTag
{
    return ^id (NSInteger setionTag) {
        for (ZZFlexibleLayoutSectionModel *sectionModel in self.listData) {
            if (sectionModel.sectionTag == setionTag) {
                return sectionModel.headerViewModel;
            }
        }
        return nil;
    };
}
- (id (^)(NSInteger setionTag))sectionFotterModelByTag
{
    return ^id (NSInteger setionTag) {
        for (ZZFlexibleLayoutSectionModel *sectionModel in self.listData) {
            if (sectionModel.sectionTag == setionTag) {
                return sectionModel.footerViewModel;
            }
        }
        return nil;
    };
}

- (NSArray *(^)(NSInteger sectionTag))cellsModelArrayForSection
{
    return ^(NSInteger setionTag) {
        NSMutableArray *data = @[].mutableCopy;
        for (ZZFlexibleLayoutSectionModel *sectionModel in self.listData) {
            if (sectionModel.sectionTag == setionTag) {
                for (ZZFlexibleLayoutViewModel *viewModel in sectionModel.itemsArray) {
                    [data addObject:viewModel.dataModel];
                }
            }
        }
        return data;
    };
}

- (NSArray *)allCellsModelArray
{
    NSMutableArray *data = @[].mutableCopy;
    for (ZZFlexibleLayoutSectionModel *sectionModel in self.listData) {
        for (ZZFlexibleLayoutViewModel *viewModel in sectionModel.itemsArray) {
            [data addObject:viewModel.dataModel];
        }
    }
    return data;
}

@end
