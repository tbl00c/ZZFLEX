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
#import "ZZFDGoodListCell.h"

typedef NS_ENUM(NSInteger, ZZFDGoodListSectionType) {
    ZZFDGoodListSectionTypeGood,
};

@interface ZZFDGoodListViewController ()

@property (nonatomic, assign) NSInteger offset;

@end

@implementation ZZFDGoodListViewController

- (void)loadView
{
    [super loadView];
    [self setTitle:@"商品列表"];
    [self.view setBackgroundColor:[UIColor colorGrayBG]];
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
        
        [TLUIUtility hiddenLoading];
        [self.collectionView.mj_header endRefreshing];
        
        if (offset == 0) {
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

        if (data.count < 20) {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
        else {
            [self.collectionView.mj_footer endRefreshing];
        }
        
        [self ui_loadUIWithData:data clear:offset == 0];
        self.offset = offset + data.count;
    } failure:^(NSString *errMsg) {
        [TLUIUtility hiddenLoading];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        
        [TLUIUtility showErrorHint:errMsg];
    }];
}

#pragma mark - # UI
- (void)ui_loadUIWithData:(NSArray *)data clear:(BOOL)clear
{
    @weakify(self);
    if (clear) {
        self.clear();
        self.addSection(ZZFDGoodListSectionTypeGood);
    }
    // 批量添加cell
    self.addCells([ZZFDGoodListCell class]).toSection(ZZFDGoodListSectionTypeGood).withDataModelArray(data).eventAction(^ id(ZZFDGoodListCellEventType eventType, id data) {
        @strongify(self);
        if (!self) {
            return nil;
        }
        if (eventType == ZZFDGoodListCellEventTypeClose) {
            [TLUIUtility showAlertWithTitle:@"不喜欢这个商品？" message:@"我们以后将减少此类商品的推荐" cancelButtonTitle:@"取消" otherButtonTitles:@[@"不喜欢"] actionHandler:^(NSInteger buttonIndex) {
                if (buttonIndex == 1) {
                    self.deleteCell.byDataModel(data);
                    [self reloadView];
                }
            }];
        }
        return nil;
    }).selectedAction(^ (id itemModel) {
        @strongify(self);
        ZZFDGoodDetailViewController *detailVC = [[ZZFDGoodDetailViewController alloc] initWithListModel:itemModel];
        PushVC(detailVC);
    });
    [self reloadView];
}

@end
