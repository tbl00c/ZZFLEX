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
@property (nonatomic, weak) NSMutableArray *listData;
@property (nonatomic, strong) NSMutableArray *viewModelArray;
@property (nonatomic, copy) id (^action)(NSInteger actionType, id data);
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
            [viewModel setEventAction:self.action];
            [self.viewModelArray addObject:viewModel];
        }
        if (self.hasSectionValue) {
            self.toSection(self.section);
        }
        return self;
    };
}

- (ZZFLEXChainViewArrayModel *(^)(id ((^)(NSInteger actionType, id data))))eventAction
{
    return ^(id ((^eventAction)(NSInteger actionType, id data))) {
        [self setAction:eventAction];
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
- (void)setAction:(id (^)(NSInteger, id))action
{
    _action = action;
    for (ZZFlexibleLayoutViewModel *viewModel in self.viewModelArray) {
        [viewModel setEventAction:action];
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
