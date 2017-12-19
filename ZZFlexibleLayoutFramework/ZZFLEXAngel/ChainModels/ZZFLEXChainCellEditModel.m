//
//  ZZFLEXChainCellEditModel.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/12/11.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFLEXChainCellEditModel.h"
#import "ZZFlexibleLayoutSectionModel.h"

@interface ZZFLEXChainCellEditModel ()

@property (nonatomic, assign) ZZFLEXChainCellEditType editType;

@property (nonatomic, strong) NSArray *listData;

@end

@implementation ZZFLEXChainCellEditModel

- (instancetype)initWithType:(ZZFLEXChainCellEditType)type andListData:(NSArray *)listData
{
    if (self = [super init]) {
        self.editType = type;
        self.listData = listData;
    }
    return self;
}

- (BOOL (^)(NSInteger cellTag))byCellTag
{
    return ^(NSInteger cellTag) {
        for (ZZFlexibleLayoutSectionModel *sectionModel in self.listData) {
            for (ZZFlexibleLayoutViewModel *viewModel in sectionModel.itemsArray) {
                if (viewModel.viewTag == cellTag) {
                    return [self p_executeWithSectionModel:sectionModel viewModel:viewModel];
                }
            }
        }
        return NO;
    };
}

- (BOOL (^)(id dataModel))byModel
{
    return ^(id dataModel) {
        for (ZZFlexibleLayoutSectionModel *sectionModel in self.listData) {
            for (ZZFlexibleLayoutViewModel *viewModel in sectionModel.itemsArray) {
                if (viewModel.dataModel == dataModel) {
                    return [self p_executeWithSectionModel:sectionModel viewModel:viewModel];
                }
            }
        }
        return NO;
    };
}

- (BOOL (^)(NSString *className))byClassName
{
    return ^(NSString *className) {
        for (ZZFlexibleLayoutSectionModel *sectionModel in self.listData) {
            for (ZZFlexibleLayoutViewModel *viewModel in sectionModel.itemsArray) {
                if ([viewModel.className isEqualToString:className]) {
                    return [self p_executeWithSectionModel:sectionModel viewModel:viewModel];
                }
            }
        }
        return NO;
    };
}

- (BOOL (^)(NSIndexPath *indexPath))atIndexPath
{
    return ^(NSIndexPath *indexPath) {
        ZZFlexibleLayoutSectionModel *sectionModel = (indexPath.section >=0 && indexPath.section < self.listData.count) ? self.listData[indexPath.section] : nil;
        if (sectionModel) {
            ZZFlexibleLayoutViewModel *viewModel = (indexPath.row >= 0 && indexPath.row < sectionModel.itemsArray.count) ? sectionModel.itemsArray[indexPath.row] : nil;
            if (viewModel) {
                return [self p_executeWithSectionModel:sectionModel viewModel:viewModel];
            }
        }
        return NO;
    };
}

- (BOOL (^)(NSInteger sectionTag, NSInteger cellTag))bySectionTagAndCellTag
{
    return ^(NSInteger sectionTag, NSInteger cellTag) {
        for (ZZFlexibleLayoutSectionModel *sectionModel in self.listData) {
            if (sectionModel.sectionTag == sectionTag) {
                for (ZZFlexibleLayoutViewModel *viewModel in sectionModel.itemsArray) {
                    if (viewModel.viewTag == cellTag) {
                        return [self p_executeWithSectionModel:sectionModel viewModel:viewModel];
                    }
                }
            }
        }
        return NO;
    };
}

#pragma mark - # Private Methods
- (BOOL)p_executeWithSectionModel:(ZZFlexibleLayoutSectionModel *)sectionModel viewModel:(ZZFlexibleLayoutViewModel *)viewModel
{
    if (self.editType == ZZFLEXChainCellEditTypeDelete) {
        [sectionModel.itemsArray removeObject:viewModel];
        return YES;
    }
    else if (self.editType == ZZFLEXChainCellEditTypeUpdate) {
        [viewModel updateViewHeight];
        return YES;
    }
    else if (self.editType == ZZFLEXChainCellEditTypeHas) {
        return YES;
    }
    return NO;
}

@end
