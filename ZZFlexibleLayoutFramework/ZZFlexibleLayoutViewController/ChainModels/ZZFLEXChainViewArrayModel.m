//
//  ZZFLEXChainViewArrayModel.m
//  zhuanzhuan
//
//  Created by 李伯坤 on 2017/8/15.
//  Copyright © 2017年 转转. All rights reserved.
//

#import "ZZFLEXChainViewArrayModel.h"
#import "ZZFlexibleLayoutSectionModel.h"

@interface ZZFLEXChainViewArrayModel()

@property (nonatomic, assign) BOOL hasSectionValue;

@property (nonatomic, strong) NSString *className;
@property (nonatomic, strong) NSMutableArray *listData;
@property (nonatomic, strong) NSMutableArray *viewModelArray;
@property (nonatomic, weak) id itemsDelegate;
@property (nonatomic, copy) id (^itemsEventAction)(NSInteger actionType, id data);
@property (nonatomic, copy) void (^itemsSelectedAction)(id data);
@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, assign) NSInteger section;

@end

@implementation ZZFLEXChainViewArrayModel

- (id)initWithClassName:(NSString *)className listData:(NSMutableArray *)listData
{
    if (self = [super init]) {
        self.viewModelArray = [[NSMutableArray alloc] init];
        self.className = className;
        self.listData = listData;
    }
    return self;
}

- (ZZFLEXChainViewArrayModel *(^)(NSInteger section))toSection
{
    self.hasSectionValue = YES;
    return ^(NSInteger section) {
        self.section = section;
        for (ZZFlexibleLayoutSectionModel *sectionModel in self.listData) {
            if (sectionModel.sectionTag == section) {
                [sectionModel addObjectsFromArray:self.viewModelArray];
                break;
            }
        }
        return self;
    };
}

- (ZZFLEXChainViewArrayModel *(^)(NSArray *dataModelArray))withDataModelArray
{
    return ^(NSArray *dataModelArray) {
        for (id model in dataModelArray) {
            ZZFlexibleLayoutViewModel *viewModel = [[ZZFlexibleLayoutViewModel alloc] init];
            [viewModel setClassName:self.className];
            [viewModel setDataModel:model];
            [viewModel setViewTag:self.tag];
            [viewModel setDelegate:self.itemsDelegate];
            [viewModel setEventAction:self.itemsEventAction];
            [viewModel setSelectedAction:self.itemsSelectedAction];
            [self.viewModelArray addObject:viewModel];
        }
        if (self.hasSectionValue) {
            self.toSection(self.section);
        }
        return self;
    };
}

- (ZZFLEXChainViewArrayModel *(^)(id delegate))delegate
{
    return ^(id delegate) {
        [self setItemsDelegate:delegate];
        return self;
    };
}

- (ZZFLEXChainViewArrayModel *(^)(id ((^)(NSInteger actionType, id data))))eventAction
{
    return ^(id ((^eventAction)(NSInteger actionType, id data))) {
        [self setItemsEventAction:eventAction];
        return self;
    };
}

- (ZZFLEXChainViewArrayModel *(^)(void ((^)(id data))))selectedAction
{
    return ^(void ((^selectedAction)(id data))) {
        [self setItemsSelectedAction:selectedAction];
        return self;
    };
}

- (ZZFLEXChainViewArrayModel *(^)(NSInteger viewTag))viewTag
{
    return ^(NSInteger viewTag) {
        [self setTag:viewTag];
        return self;
    };
}

#pragma mark - # Setters
- (void)setItemsDelegate:(id)itemsDelegate
{
    _itemsDelegate = itemsDelegate;
    for (ZZFlexibleLayoutViewModel *viewModel in self.viewModelArray) {
        [viewModel setDelegate:itemsDelegate];
    }
}

- (void)setItemsEventAction:(id (^)(NSInteger, id))itemsEventAction
{
    _itemsEventAction = itemsEventAction;
    for (ZZFlexibleLayoutViewModel *viewModel in self.viewModelArray) {
        [viewModel setEventAction:itemsEventAction];
    }
}

- (void)setItemsSelectedAction:(void (^)(id))itemsSelectedAction
{
    _itemsSelectedAction = itemsSelectedAction;
    for (ZZFlexibleLayoutViewModel *viewModel in self.viewModelArray) {
        [viewModel setSelectedAction:itemsSelectedAction];
    }
}

- (void)setTag:(NSInteger)tag
{
    _tag = tag;
    for (ZZFlexibleLayoutViewModel *viewModel in self.viewModelArray) {
        [viewModel setViewTag:tag];
    }
}

@end
