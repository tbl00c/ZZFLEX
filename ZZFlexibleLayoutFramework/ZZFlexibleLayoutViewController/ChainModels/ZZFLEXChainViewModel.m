//
//  ZZFLEXChainViewModel.m
//  zhuanzhuan
//
//  Created by 李伯坤 on 2017/8/15.
//  Copyright © 2017年 转转. All rights reserved.
//

#import "ZZFLEXChainViewModel.h"
#import "ZZFlexibleLayoutSectionModel.h"

@interface ZZFLEXChainViewModel()

@property (nonatomic, strong) NSMutableArray *listData;
@property (nonatomic, strong) ZZFlexibleLayoutViewModel *viewModel;

@end

@implementation ZZFLEXChainViewModel

- (id)initWithListData:(NSMutableArray *)listData viewModel:(ZZFlexibleLayoutViewModel *)viewModel andType:(ZZFLEXChainViewType)type;
{
    if (self = [super init]) {
        _type = type;
        self.listData = listData;
        self.viewModel = viewModel;
    }
    return self;
}

- (ZZFLEXChainViewModel *(^)(NSInteger section))toSection
{
    return ^(NSInteger section) {
        for (ZZFlexibleLayoutSectionModel *sectionModel in self.listData) {
            if (sectionModel.sectionTag == section) {
                if (self.type == ZZFLEXChainViewTypeCell) {
                    [sectionModel addObject:self.viewModel];
                }
                else if (self.type == ZZFLEXChainViewTypeHeader) {
                    [sectionModel setHeaderViewModel:self.viewModel];
                }
                else if (self.type == ZZFLEXChainViewTypeFooter) {
                    [sectionModel setFooterViewModel:self.viewModel];
                }
                break;
            }
        }
        return self;
    };
}

- (ZZFLEXChainViewModel *(^)(id dataModel))withDataModel
{
    return ^(id dataModel) {
        [self.viewModel setDataModel:dataModel];
        return self;
    };
}

- (ZZFLEXChainViewModel *(^)(id delegate))delegate
{
    return ^(id dataModel) {
        [self.viewModel setDelegate:dataModel];
        return self;
    };
}

- (ZZFLEXChainViewModel *(^)(id ((^)(NSInteger actionType, id data))))eventAction
{
    return ^(id ((^eventAction)(NSInteger actionType, id data))) {
        [self.viewModel setEventAction:eventAction];
        return self;
    };
}

- (ZZFLEXChainViewModel *(^)(NSInteger viewTag))viewTag
{
    return ^(NSInteger viewTag) {
        self.viewModel.viewTag = viewTag;
        return self;
    };
}

- (ZZFLEXChainViewModel *(^)(void ((^)(id data))))selectedAction
{
    return ^(void ((^eventAction)(id data))) {
        [self.viewModel setSelectedAction:eventAction];
        return self;
    };
}

@end
