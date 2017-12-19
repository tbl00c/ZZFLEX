//
//  ZZFDGoodListViewController.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/11/28.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFDGoodListViewController.h"
#import "ZZFDGoodDetailViewController.h"
#import "ZZFDGoodListModel.h"
#import <MJRefresh/MJRefresh.h>

typedef NS_ENUM(NSInteger, ZZFDGoodListSectionType) {
    ZZFDGoodListSectionTypeGood,
};

@interface ZZFDGoodListViewController () <ZZFlexibleLayoutViewControllerProtocol>

@property (nonatomic, assign) NSInteger offset;

@end

@implementation ZZFDGoodListViewController

- (void)loadView
{
    [super loadView];
    [self setTitle:@"商品列表"];
    [self.view setBackgroundColor:[UIColor colorGrayBG]];
    self.addSection(ZZFDGoodListSectionTypeGood);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [TLUIUtility showLoading:nil];
    [self requestDataWithOffset:0];
    
    @weakify(self);
    [self.collectionView setMj_header:[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self requestDataWithOffset:0];
    }]];
}

#pragma mark - # Request
- (void)requestDataWithOffset:(NSInteger)offset
{
    @weakify(self);
    [ZZFDGoodListModel requestHomePageDataWithOffset:offset success:^(NSArray *data) {
        @strongify(self);
        
        // 很重要
        if (!self) {
            return ;
        }
        
        self.offset = offset + data.count;
        [TLUIUtility hiddenLoading];
        [self.collectionView.mj_header endRefreshing];
        
        if (offset == 0) {
            [self deleteAllItemsForSection:ZZFDGoodListSectionTypeGood];
            if (!self.collectionView.mj_footer) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.collectionView setMj_footer:[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                        @strongify(self);
                        [self requestDataWithOffset:self.offset];
                    }]];
                });
            }
            else {
                [self.collectionView.mj_footer resetNoMoreData];
            }
        }
        else {
            if (data.count == 20) {
                [self.collectionView.mj_footer endRefreshing];
            }
            else {
                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            }
        }
        
        // 批量添加cell
        self.addCells(@"ZZFDGoodListCell").toSection(ZZFDGoodListSectionTypeGood).withDataModelArray(data);
        [self reloadView];
    } failure:^(NSString *errMsg) {
        [TLUIUtility hiddenLoading];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        
        [TLUIUtility showErrorHint:errMsg];
    }];
}

#pragma mark - # Delegate
- (void)collectionViewDidSelectItem:(id)itemModel sectionTag:(NSInteger)sectionTag cellTag:(NSInteger)cellTag className:(NSString *)className indexPath:(NSIndexPath *)indexPath
{
    ZZFDGoodDetailViewController *detailVC = [[ZZFDGoodDetailViewController alloc] init];
    PushVC(detailVC);
}

@end
