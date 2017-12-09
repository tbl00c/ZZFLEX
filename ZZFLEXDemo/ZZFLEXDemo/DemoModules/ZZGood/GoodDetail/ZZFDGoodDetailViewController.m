//
//  ZZFDGoodDetailViewController.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/11/28.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFDGoodDetailViewController.h"

@interface ZZFDGoodDetailViewController ()

@end

@implementation ZZFDGoodDetailViewController

- (id)initWithListModel:(ZZFDGoodListModel *)listModel
{
    if (self = [super init]) {
        self.listModel = listModel;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    [self setTitle:@"商品详情"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

@end
