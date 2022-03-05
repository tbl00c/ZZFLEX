//
//  ZZFLEXAngelIndexPathChainModel.m
//  WCUIKit
//
//  Created by libokun on 2021/11/30.
//  Copyright © 2021 WeChat. All rights reserved.
//

#import "ZZFLEXAngelIndexPathChainModel.h"
#import "ZZFLEXSectionModel.h"
#import "ZZFLEXViewModel.h"
#import <UIKit/NSIndexPath+UIKitAdditions.h>

@interface ZZFLEXAngelIndexPathChainModel ()

@property (nonatomic, strong) NSArray *listData;

@end

@implementation ZZFLEXAngelIndexPathChainModel

- (instancetype)initWithListData:(NSArray *)listData {
    if (self = [self init]) {
        self.listData = listData;
    }
    return self;
}

- (nullable NSIndexPath * (^)(NSInteger viewTag))byViewTag {
    return ^NSIndexPath *(NSInteger viewTag) {
        NSInteger section = 0;
        for (ZZFLEXSectionModel *sectionModel in self.listData) {
            NSInteger index = 0;
            for (ZZFLEXViewModel *viewModel in sectionModel.itemsArray) {
                if (viewModel.viewTag == viewTag) {
                    return [NSIndexPath indexPathForRow:index inSection:section];
                }
                index++;
            }
            section++;
        }
        return nil;
    };
}

- (nullable NSIndexPath * (^)(NSInteger sectionTag, NSInteger viewTag))bySectionTagAndViewTag {
    return ^NSIndexPath *(NSInteger sectionTag, NSInteger viewTag) {
        NSInteger section = 0;
        for (ZZFLEXSectionModel *sectionModel in self.listData) {
            if (sectionModel.sectionTag == sectionTag) {
                NSInteger index = 0;
                for (ZZFLEXViewModel *viewModel in sectionModel.itemsArray) {
                    if (viewModel.viewTag == viewTag) {
                        return [NSIndexPath indexPathForRow:index inSection:section];
                    }
                    index++;
                }
                return nil;
            }
            section++;
        }
        return nil;
    };
}

- (nullable NSIndexPath * (^)(id dataModel))byDataModel {
    return ^NSIndexPath *(id dataModel) {
        NSInteger section = 0;
        for (ZZFLEXSectionModel *sectionModel in self.listData) {
            NSInteger index = 0;
            for (ZZFLEXViewModel *viewModel in sectionModel.itemsArray) {
                if (viewModel.dataModel == dataModel) {
                    return [NSIndexPath indexPathForRow:index inSection:section];
                }
                index++;
            }
            section++;
        }
        return nil;
    };
}

- (nullable NSIndexPath * (^)(NSInteger sectionTag, id dataModel))bySectionTagAndDataModel {
    return ^NSIndexPath *(NSInteger sectionTag, id dataModel) {
        NSInteger section = 0;
        for (ZZFLEXSectionModel *sectionModel in self.listData) {
            if (sectionModel.sectionTag == sectionTag) {
                NSInteger index = 0;
                for (ZZFLEXViewModel *viewModel in sectionModel.itemsArray) {
                    if (viewModel.dataModel == dataModel) {
                        return [NSIndexPath indexPathForRow:index inSection:section];
                    }
                    index++;
                }
                return nil;
            }
            section++;
        }
        return nil;
    };
}

@end
