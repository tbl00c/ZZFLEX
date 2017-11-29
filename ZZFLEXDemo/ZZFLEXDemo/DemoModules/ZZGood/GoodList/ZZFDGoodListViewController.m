//
//  ZZFDGoodListViewController.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/11/28.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFDGoodListViewController.h"
#import "ZZFDGoodListModel.h"

@interface ZZFDGoodListViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ZZFDGoodListViewController

- (void)loadView
{
    [super loadView];
    [self setTitle:@"转转"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataSource = @[].mutableCopy;
    [self requestData];
}

#pragma mark - # Request
- (void)requestData
{
    [ZZFDGoodListModel requestHomePageDataWithOffset:0 success:^(NSArray *data) {
        [self loadUIWithData:data];
    } failure:^(NSString *errMsg) {
        [TLUIUtility showErrorHint:errMsg];
    }];
}

#pragma mark - #
- (void)loadUIWithData:(NSArray *)data
{
    
}

@end
