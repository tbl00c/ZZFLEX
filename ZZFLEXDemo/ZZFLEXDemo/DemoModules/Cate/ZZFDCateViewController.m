//
//  ZZFDCateViewController.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/12/18.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFDCateViewController.h"
#import "UIView+ZZFLEX.h"
#import "ZZFLEXAngel.h"

@interface ZZFDCateViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZZFLEXAngel *tableViewAngel;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) ZZFLEXAngel *collectionViewAngel;

@end

@implementation ZZFDCateViewController

- (void)loadView
{
    [super loadView];
    [self setTitle:@"分类"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.tableView = self.view.addTableView(1)
    .masonry(^ (MASConstraintMaker *make) {
        make.left.bottom.top.mas_equalTo(0);
        make.width.mas_equalTo(125);
    })
    .view;
    self.tableViewAngel = [[ZZFLEXAngel alloc] initWithHostView:self.tableView];

    self.collectionView = self.view.addCollectionView(2)
    .backgroundColor([UIColor whiteColor])
    .masonry(^ (MASConstraintMaker *make) {
        make.right.bottom.top.mas_equalTo(0);
        make.left.mas_equalTo(self.tableView.mas_right);
    })
    .view;
    self.collectionViewAngel = [[ZZFLEXAngel alloc] initWithHostView:self.collectionView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableViewAngel.addSection(1001);
    self.tableViewAngel.addCells(@"ZZFDCateMenuCell").withDataModelArray(@[@"手机", @"电脑"]).toSection(1001);
    [self.tableView reloadData];
    
    self.collectionViewAngel.addSection(1001);
}

@end
