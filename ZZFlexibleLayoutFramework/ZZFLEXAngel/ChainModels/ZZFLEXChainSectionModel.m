//
//  ZZFLEXChainSectionModel.m
//  zhuanzhuan
//
//  Created by 李伯坤 on 2017/8/15.
//  Copyright © 2017年 转转. All rights reserved.
//

#import "ZZFLEXChainSectionModel.h"
#import "ZZFlexibleLayoutSectionModel.h"

#pragma mark - ## ZZFLEXChainSectionBaseModel (基类)
@interface ZZFLEXChainSectionBaseModel ()

@property (nonatomic, strong) ZZFlexibleLayoutSectionModel *sectionModel;

@end

@implementation ZZFLEXChainSectionBaseModel

- (instancetype)initWithSectionModel:(ZZFlexibleLayoutSectionModel *)sectionModel
{
    if (self = [super init]) {
        self.sectionModel = sectionModel;
    }
    return self;
}

- (id (^)(CGFloat minimumLineSpacing))minimumLineSpacing
{
    return ^(CGFloat minimumLineSpacing) {
        [self.sectionModel setMinimumLineSpacing:minimumLineSpacing];
        return self;
    };
}

- (id (^)(CGFloat minimumInteritemSpacing))minimumInteritemSpacing
{
    return ^(CGFloat minimumInteritemSpacing) {
        [self.sectionModel setMinimumInteritemSpacing:minimumInteritemSpacing];
        return self;
    };
}

- (id (^)(UIEdgeInsets sectionInsets))sectionInsets
{
    return ^(UIEdgeInsets sectionInsets) {
        [self.sectionModel setSectionInsets:sectionInsets];
        return self;
    };
}

- (id (^)(UIColor *backgrounColor))backgrounColor
{
    return ^(UIColor *backgrounColor) {
        [self.sectionModel setBackgroundColor:backgrounColor];
        return self;
    };
}

@end

#pragma mark - ## ZZFLEXChainSectionModel （添加）
@implementation ZZFLEXChainSectionModel

@end


#pragma mark - ## ZZFLEXChainSectionEditModel （编辑）
@implementation ZZFLEXChainSectionEditModel

- (ZZFLEXChainSectionEditModel *(^)(void))clear
{
    return ^(void) {
        self.sectionModel.headerViewModel = nil;
        self.sectionModel.footerViewModel = nil;
        [self.sectionModel.itemsArray removeAllObjects];
        return self;
    };
}

- (ZZFLEXChainSectionEditModel *(^)(void))clearAllCells
{
    return ^(void) {
        [self.sectionModel.itemsArray removeAllObjects];
        return self;
    };
}

- (ZZFLEXChainSectionEditModel *(^)(NSInteger tag))deleteCellForTag
{
    return ^(NSInteger tag) {
        for (ZZFlexibleLayoutViewModel *viewModel in self.sectionModel.itemsArray) {
            if (viewModel.viewTag == tag) {
                [self.sectionModel removeObject:viewModel];
                break;
            }
        }
        return self;
    };
}

- (ZZFLEXChainSectionEditModel *(^)(NSInteger tag))deleteAllCellsForTag
{
    return ^(NSInteger tag) {
        NSMutableArray *deleteData = @[].mutableCopy;
        for (ZZFlexibleLayoutViewModel *viewModel in self.sectionModel.itemsArray) {
            if (viewModel.viewTag == tag) {
                [deleteData addObject:viewModel];
            }
        }
        for (ZZFlexibleLayoutViewModel *viewModel in deleteData) {
            [self.sectionModel removeObject:viewModel];
        }
        return self;
    };
}

- (ZZFLEXChainSectionEditModel *(^)(void))update
{
    return ^(void) {
        [self.sectionModel.headerViewModel updateViewHeight];
        [self.sectionModel.footerViewModel updateViewHeight];
        for (ZZFlexibleLayoutViewModel *viewModel in self.sectionModel.itemsArray) {
            [viewModel updateViewHeight];
        }
        return self;
    };
}

- (ZZFLEXChainSectionEditModel *(^)(void))updateAllCells
{
    return ^(void) {
        for (ZZFlexibleLayoutViewModel *viewModel in self.sectionModel.itemsArray) {
            [viewModel updateViewHeight];
        }
        return self;
    };
}

- (ZZFLEXChainSectionEditModel *(^)(NSInteger tag))updateCellForTag
{
    return ^(NSInteger tag) {
        for (ZZFlexibleLayoutViewModel *viewModel in self.sectionModel.itemsArray) {
            if (viewModel.viewTag == tag) {
                [viewModel updateViewHeight];
                break;
            }
        }
        return self;
    };
}

- (ZZFLEXChainSectionEditModel *(^)(NSInteger tag))updateAllCellsForTag
{
    return ^(NSInteger tag) {
        for (ZZFlexibleLayoutViewModel *viewModel in self.sectionModel.itemsArray) {
            if (viewModel.viewTag == tag) {
                [viewModel updateViewHeight];
            }
        }
        return self;
    };
}

@end

#pragma mark - ## ZZFLEXChainSectionInsertModel （插入）
@interface ZZFLEXChainSectionInsertModel()

@property (nonatomic, strong) NSMutableArray *listData;

@end

@implementation ZZFLEXChainSectionInsertModel

- (instancetype)initWithSectionModel:(ZZFlexibleLayoutSectionModel *)sectionModel listData:(NSMutableArray *)listData
{
    if (self = [super initWithSectionModel:sectionModel]) {
        self.listData = listData;
    }
    return self;
}

- (ZZFLEXChainSectionInsertModel *(^)(NSInteger index))toIndex
{
    return ^(NSInteger index) {
        [self p_insertToListDataAtIndex:index];
        return self;
    };
}

- (ZZFLEXChainSectionInsertModel *(^)(NSInteger sectionTag))beforeSection
{
    return ^(NSInteger sectionTag) {
        for (int i = 0; i < self.listData.count; i++) {
            ZZFlexibleLayoutSectionModel *model = self.listData[i];
            if (model.sectionTag == sectionTag) {
                [self p_insertToListDataAtIndex:i];
                break;
            }
        }
        return self;
    };
}

- (ZZFLEXChainSectionInsertModel *(^)(NSInteger sectionTag))afterSection
{
    return ^(NSInteger sectionTag) {
        for (int i = 0; i < self.listData.count; i++) {
            ZZFlexibleLayoutSectionModel *model = self.listData[i];
            if (model.sectionTag == sectionTag) {
                [self p_insertToListDataAtIndex:i + 1];
                break;
            }
        }
        return self;
    };
}

- (BOOL)p_insertToListDataAtIndex:(NSInteger)index
{
    if (self.listData && index >= 0 && index < self.listData.count) {
        [self.listData insertObject:self.sectionModel atIndex:index];
        self.listData = nil;
        return YES;
    }
    NSLog(@"!!!!! ZZFLEX, section插入失败");
    return NO;
}

@end






