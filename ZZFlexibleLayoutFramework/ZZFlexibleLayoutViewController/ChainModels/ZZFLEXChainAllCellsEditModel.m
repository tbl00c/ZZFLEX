//
//  ZZFLEXChainAllCellsEditModel.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/12/11.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFLEXChainAllCellsEditModel.h"
#import "ZZFlexibleLayoutSectionModel.h"

@interface ZZFLEXChainAllCellsEditModel ()

@property (nonatomic, strong) NSArray *listData;

@property (nonatomic, assign) ZZFLEXChainAllCellsEditType editType;

@end

@implementation ZZFLEXChainAllCellsEditModel

- (instancetype)initWithType:(ZZFLEXChainAllCellsEditType)type andListData:(NSArray *)listData
{
    if (self = [super init]) {
        self.editType = type;
        self.listData = listData;
    }
    return self;
}

- (BOOL)all
{
    for (ZZFlexibleLayoutSectionModel *sectionModel in self.listData) {
        [sectionModel.itemsArray removeAllObjects];
    }
    return YES;
}

- (BOOL (^)(NSInteger cellTag))byCellTag
{
    return ^(NSInteger cellTag) {
        for (ZZFlexibleLayoutSectionModel *sectionModel in self.listData) {
            NSMutableArray *data = @[].mutableCopy;
            for (ZZFlexibleLayoutViewModel *viewModel in sectionModel.itemsArray) {
                if (viewModel.viewTag == cellTag) {
                    [data addObject:viewModel];
                }
            }
            return [self p_executeWithSectionModel:sectionModel viewModelArray:data];
        }
        return NO;
    };
}

- (BOOL (^)(id dataModel))byModel
{
    return ^(id dataModel) {
        for (ZZFlexibleLayoutSectionModel *sectionModel in self.listData) {
            NSMutableArray *data = @[].mutableCopy;
            for (ZZFlexibleLayoutViewModel *viewModel in sectionModel.itemsArray) {
                if (viewModel.dataModel == dataModel) {
                    [data addObject:viewModel];
                }
            }
            return [self p_executeWithSectionModel:sectionModel viewModelArray:data];
        }
        return NO;
    };
}

- (BOOL (^)(NSString *className))byClassName
{
    return ^(NSString *className) {
        for (ZZFlexibleLayoutSectionModel *sectionModel in self.listData) {
            NSMutableArray *data = @[].mutableCopy;
            for (ZZFlexibleLayoutViewModel *viewModel in sectionModel.itemsArray) {
                if ([viewModel.className isEqualToString:className]) {
                    [data addObject:viewModel];
                }
            }
            return [self p_executeWithSectionModel:sectionModel viewModelArray:data];
        }
        return NO;
    };
}

- (BOOL (^)(NSInteger sectionTag, NSInteger cellTag))bySectionTagAndCellTag
{
    return ^(NSInteger sectionTag, NSInteger cellTag) {
        for (ZZFlexibleLayoutSectionModel *sectionModel in self.listData) {
            if (sectionModel.sectionTag == sectionTag) {
                NSMutableArray *data = @[].mutableCopy;
                for (ZZFlexibleLayoutViewModel *viewModel in sectionModel.itemsArray) {
                    if (viewModel.viewTag == cellTag) {
                        [data addObject:viewModel];
                    }
                }
                return [self p_executeWithSectionModel:sectionModel viewModelArray:data];
            }
        }
        return NO;
    };
}

- (BOOL)p_executeWithSectionModel:(ZZFlexibleLayoutSectionModel *)sectionModel viewModelArray:(NSArray *)viewModelArray
{
    if (self.editType == ZZFLEXChainAllCellsEditTypeDelete) {
        for (ZZFlexibleLayoutViewModel *viewModel in viewModelArray) {
             [sectionModel.itemsArray removeObject:viewModel];
        }
        return YES;
    }
    else if (self.editType == ZZFLEXChainAllCellsEditTypeUpdate) {
        for (ZZFlexibleLayoutViewModel *viewModel in viewModelArray) {
            [viewModel updateViewHeight];
        }
        return YES;
    }
    return NO;
}

@end
