//
//  ZZFlexibleLayoutViewController.m
//  zhuanzhuan
//
//  Created by 李伯坤 on 2016/10/10.
//  Copyright © 2016年 wuba. All rights reserved.
//

#import "ZZFlexibleLayoutViewController.h"
#import "ZZFlexibleLayoutViewController+Kernel.h"
#import "ZZFlexibleLayoutSectionModel.h"
#import "ZZFlexibleLayoutViewProtocol.h"

@implementation ZZFlexibleLayoutViewController

- (id)init
{
    if (self = [super init]) {
        _data = [[NSMutableArray alloc] init];
        _scrollDirection = UICollectionViewScrollDirectionVertical;
        
        ZZFlexibleLayoutFlowLayout *layout = [[ZZFlexibleLayoutFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self.collectionView setBackgroundColor:[UIColor clearColor]];
        [self.collectionView setDataSource:self];
        [self.collectionView setDelegate:self];
        [self.collectionView setShowsHorizontalScrollIndicator:NO];
        [self.collectionView setAlwaysBounceVertical:YES];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    [self.collectionView setFrame:self.view.bounds];
    [self.view addSubview:self.collectionView];
    RegisterCollectionViewCell(self.collectionView, CELL_SEPEARTOR);        // 注册空白cell
    RegisterCollectionViewReusableView(self.collectionView, UICollectionElementKindSectionHeader, @"ZZFlexibleLayoutEmptyHeaderFooterView");
    RegisterCollectionViewReusableView(self.collectionView, UICollectionElementKindSectionFooter, @"ZZFlexibleLayoutEmptyHeaderFooterView");
}

- (void)dealloc
{
    NSLog(@"dealloc");
}

#pragma mark - # Public Methods
- (void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection
{
    _scrollDirection = scrollDirection;
    [(ZZFlexibleLayoutFlowLayout *)self.collectionView.collectionViewLayout setScrollDirection:scrollDirection];
}


@end
