//
//  ZZFlexibleLayoutViewController.h
//  zhuanzhuan
//
//  Created by 李伯坤 on 2016/10/10.
//  Copyright © 2016年 wuba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZFLEXChainSectionModel.h"
#import "ZZFLEXChainViewModel.h"
#import "ZZFLEXChainViewArrayModel.h"

/**
 *  动态布局页面框架类 2.0
 *
 *  对UICollectionView的二次封装
 *
 *  注意：
 *  1、sectionTag是Section的表示，建议设置（如果涉及UI的刷新则必须设置），同时建议SectionTag唯一
 *  2、cellTag为cell的表示，需要时设置，能够结合SectionTag取到DataModel，可以不唯一
 *
 *  2.0更新：
 *  1、优化框架代码结构，此类只保留核心代码，将API、OldAPI拆分到分类中；
 *  2、主要API改为链式，使用更加灵活，原API已经移动到OldAPI分类中
 *  3、Cell模块化支持，使用eventAction代替delegate
 */

#define     TAG_CELL_NONE                   0                                               // 默认cell Tag，在未指定时使用
#define     TAG_CELL_SEPERATOR              -1                                              // 空白分割cell Tag
#define     DEFAULT_SEPERATOR_SIZE          CGSizeMake(self.view.frame.size.width, 10.0f)   // 默认分割cell大小
#define     DEFAULT_SEPERATOR_COLOR         [UIColor clearColor]                            // 默认分割cell颜色

#define     ZZFLEX_CHAINAPI_TYPE            @property (nonatomic, copy, readonly)

#pragma mark - ## ZZFlexibleLayoutViewControllerProtocol
@protocol ZZFlexibleLayoutViewControllerProtocol <NSObject>
@optional;
/**
 *  collectionView Cell 点击事件
 */
- (void)collectionViewDidSelectItem:(id)itemModel
                         sectionTag:(NSInteger)sectionTag
                            cellTag:(NSInteger)cellTag
                          className:(NSString *)className
                          indexPath:(NSIndexPath *)indexPath;
@end


#pragma mark - ## ZZFlexibleLayoutViewController
@class ZZFlexibleLayoutSectionModel;
@interface ZZFlexibleLayoutViewController : UIViewController <
ZZFlexibleLayoutViewControllerProtocol
>

/// 瀑布流列表
@property (nonatomic, strong, readonly) UICollectionView *collectionView;

/// 数据源
@property (nonatomic, strong, readonly) NSMutableArray *data;


/// 滚动方向，默认垂直
@property (nonatomic, assign) UICollectionViewScrollDirection scrollDirection;

/// header悬浮，默认NO
@property (nonatomic, assign) BOOL sectionHeadersPinToVisibleBounds;
/// footer悬浮，默认NO
@property (nonatomic, assign) BOOL sectionFootersPinToVisibleBounds;

@end

#pragma mark - ## ZZFlexibleLayoutViewController (API)
@interface ZZFlexibleLayoutViewController (API)

#pragma mark # 页面刷新
/// 刷新页面
- (void)reloadView;

/// 删除所有元素
- (BOOL)deleteAllItems;

#pragma mark - # 页面重新布局
/// 更新section信息
- (void)updateSectionForTag:(NSInteger)sectionTag;
/// 更新cell信息，将重新计算高度，但不会reload
- (void)updateCellsForCellTag:(NSInteger)cellTag;
- (void)updateCellsForSectionTag:(NSInteger)sectionTag cellTag:(NSInteger)cellTag;
- (void)updateCellAtIndexPath:(NSIndexPath *)indexPath;
- (void)updateCellsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

#pragma mark - # 数据获取操作
/// 获取指定单个数据源
- (id)dataModelAtIndexPath:(NSIndexPath *)indexPath;
- (id)dataModelForSection:(NSInteger)sectionTag cellTag:(NSInteger)cellTag;
- (id)dataModelForSection:(NSInteger)sectionTag className:(NSString *)className;
- (NSArray *)dataModelArrayForSection:(NSInteger)sectionTag;
- (NSArray *)dataModelArrayForSection:(NSInteger)sectionTag cellTag:(NSInteger)cellTag;
/// 列表所有的数据源（如添加cell时未指定或传nil，则表现为[NSNull null]）
- (NSArray *)allDataModelArray;

#pragma mark - # Section操作
/// 添加section
ZZFLEX_CHAINAPI_TYPE ZZFLEXChainSectionModel *(^addSection)(NSInteger tag);

/// 编辑section属性，若section不存在将自动创建
ZZFLEX_CHAINAPI_TYPE ZZFLEXChainSectionModel *(^sectionForTag)(NSInteger tag);

/// 插入section
- (NSInteger)insertSectionWithTag:(NSInteger)tag toIndex:(NSInteger)index;
- (NSInteger)insertSectionWithTag:(NSInteger)tag toIndex:(NSInteger)index minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing minimumLineSpacing:(CGFloat)minimumLineSpacing sectionInsets:(UIEdgeInsets)sectionInsets backgroundColor:(UIColor *)backgroundColor;

/// 删除section
- (BOOL)deleteSection:(NSInteger)tag;
/// 删除section的所有元素（cell,header,footer）
- (BOOL)deleteAllItemsForSection:(NSInteger)tag;
/// 删除section的所有cell（不包括header,footer）
- (BOOL)deleteAllCellsForSection:(NSInteger)tag;

/// 判断section是否存在
- (BOOL)hasSection:(NSInteger)tag;
/// 判断section index是否存在
- (BOOL)hasSectionAtIndex:(NSInteger)sectionIndex;

#pragma mark - # Section View 操作
/// 为section添加headerView
- (ZZFLEXChainViewModel *(^)(NSString *className))setHeader;
- (id)dataModelForSectionHeader:(NSInteger)sectionTag;
- (BOOL)deleteSectionHeaderView:(NSInteger)sectionTag;

/// 为section添加footerView
- (ZZFLEXChainViewModel *(^)(NSString *className))setFooter;
- (id)dataModelForSectionFooter:(NSInteger)sectionTag;
- (BOOL)deleteSectionFooterView:(NSInteger)sectionTag;

#pragma mark - # Section Cell 操作
/// 添加cell
ZZFLEX_CHAINAPI_TYPE ZZFLEXChainViewModel *(^ addCell)(NSString *className);
/// 批量添加cell
ZZFLEX_CHAINAPI_TYPE ZZFLEXChainViewArrayModel *(^ addCells)(NSString *className);
/// 添加空白cell
ZZFLEX_CHAINAPI_TYPE ZZFLEXChainViewModel *(^ addSeperatorCell)(CGSize size, UIColor *color);

/// 为指定section插入cell，非必须不建议使用，建议单独section+addCell代替（失败返回nil）
- (NSIndexPath *)insertCellWithModel:(id)model forSection:(NSInteger)sectionTag className:(NSString *)className pos:(NSInteger)pos;
- (NSIndexPath *)insertCellWithModel:(id)model forSection:(NSInteger)sectionTag className:(NSString *)className tag:(NSInteger)tag pos:(NSInteger)pos;

/// 为指定section批量添加，非必须不建议使用，建议单独section+addCell代替（失败返回nil）
- (NSArray<NSIndexPath *> *)insertCellsWithModelArray:(NSArray *)modelArray forSection:(NSInteger)sectionTag className:(NSString *)className pos:(NSInteger)pos;
- (NSArray<NSIndexPath *> *)insertCellsWithModelArray:(NSArray *)modelArray forSection:(NSInteger)sectionTag className:(NSString *)className tag:(NSInteger)tag pos:(NSInteger)pos;

/// 根据indexPath删除cell
- (BOOL)deleteCellAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)deleteCellsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

/// 根据tag删除cell，仅删除找到的第一个
- (BOOL)deleteCellByCellTag:(NSInteger)tag;
- (BOOL)deleteCellForSection:(NSInteger)sectionTag tag:(NSInteger)tag;

/// 根据tag删除cell，删除所有
- (BOOL)deleteAllCellsByCellTag:(NSInteger)tag;
- (BOOL)deleteAllCellsForSection:(NSInteger)sectionTag tag:(NSInteger)tag;

/// 根据数据源删除cell
- (BOOL)deleteCellByModel:(id)model;
- (BOOL)deleteCellForSection:(NSInteger)sectionTag model:(id)model;

/// 根据数据源删除找到的所有cell
- (BOOL)deleteAllCellsByModel:(id)model;
- (BOOL)deleteAllCellsForSection:(NSInteger)sectionTag model:(id)model;

/// 根据类名删除cell
- (BOOL)deleteCellsByClassName:(NSString *)className;
- (BOOL)deleteCellsForSection:(NSInteger)sectionTag className:(NSString *)className;

/// 判断cell是否存在
- (BOOL)hasCell:(NSInteger)tag;
- (BOOL)hasCellWithDataModel:(id)dataModel;
- (BOOL)hasCellAtSection:(NSInteger)sectionTag cellTag:(NSInteger)cellTag;
- (BOOL)hasCellAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark - # Index获取
/// 获取section index
- (NSInteger)sectionIndexForTag:(NSInteger)sectionTag;

/// 获取cell的IndexPaths
- (NSArray<NSIndexPath *> *)cellIndexPathForCellTag:(NSInteger)cellTag;
- (NSArray<NSIndexPath *> *)cellIndexPathForSectionTag:(NSInteger)sectionTag cellTag:(NSInteger)cellTag;

#pragma mark - # 滚动操作
- (void)scrollToTop:(BOOL)animated;
- (void)scrollToBottom:(BOOL)animated;
- (void)scrollToSection:(NSInteger)sectionTag position:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated;
- (void)scrollToSection:(NSInteger)sectionTag cell:(NSInteger)cellTag position:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated;
- (void)scrollToCell:(NSInteger)cellTag position:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated;
- (void)scrollToSectionIndex:(NSInteger)sectionIndex position:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated;
- (void)scrollToIndexPath:(NSIndexPath *)indexPath position:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated;

@end
