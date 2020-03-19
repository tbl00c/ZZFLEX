//
//  ZZFLEXSectionModel.h
//  ZZFlexibleLayoutFrameworkDemo
//
//  Created by lbk on 2016/12/27.
//  Copyright © 2016年 lbk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZFLEXViewModel.h"

/**
 * 仅框架内部使用
 *
 * 用于collectionView每个Section的Model
 */

@interface ZZFLEXSectionModel : NSObject

/// section标识
@property (nonatomic, assign) NSInteger sectionTag;

/// section背景色
@property (nonatomic, strong) UIColor *backgroundColor;

#pragma mark - # Section Header
/// section头部视图Model
@property (nonatomic, strong) ZZFLEXViewModel *headerViewModel;
/// section头部视图Size
@property (nonatomic, assign, readonly) CGSize headerViewSize;

#pragma mark - # Section Footer
/// section尾部视图Model
@property (nonatomic, strong) ZZFLEXViewModel *footerViewModel;
/// section尾部视图Size
@property (nonatomic, assign, readonly) CGSize footerViewSize;

#pragma mark - # Section Parameters
/// section最小行距，默认0
@property (nonatomic, assign) CGFloat minimumLineSpacing;
/// section最小间距，默认0
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;
/// section边缘间隔，默认UIEdgeInsetsZero
@property (nonatomic, assign) UIEdgeInsets sectionInsets;

#pragma mark - # Items
/// section元素Model数组
@property (nonatomic, strong, readonly) NSMutableArray<ZZFLEXViewModel *> *itemsArray;
/// section元素个数
@property (nonatomic, assign, readonly) NSUInteger count;

/**
 * 为section添加元素
 */
- (void)addObject:(ZZFLEXViewModel *)object;
- (void)addObjectsFromArray:(NSArray<ZZFLEXViewModel *> *)otherArray;

/**
 * 为section插入元素
 */
- (void)insertObject:(ZZFLEXViewModel *)object atIndex:(NSUInteger)objectIndex;
- (void)insertObjects:(NSArray<ZZFLEXViewModel *> *)objects atIndexes:(NSIndexSet *)indexes;

/*
 * 获取section的第index个元素
 */
- (id)objectAtIndex:(NSUInteger)index;

/**
 * 根据index删除item
 */
- (void)removeObjectAtIndex:(NSUInteger)index;

/**
 * 删除item
 */
- (void)removeObject:(ZZFLEXViewModel *)object;

/*
 * 获取section的第index个元素的dataModel
 */
- (id)dataModelAtIndex:(NSUInteger)index;


@end
