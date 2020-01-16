//
//  WXSettingViewController.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2019/4/18.
//  Copyright © 2019 李伯坤. All rights reserved.
//

#import "WXSettingViewController.h"
#import "WXSettingItemCell.h"
#import "WXSettingButtonCell.h"

@implementation WXSettingViewController

- (void)loadView
{
    [super loadView];
    [self setTitle:@"设置"];

    self.collectionView.zz_setup
    .backgroundColor([UIColor colorGrayBG])
    .masonry(^(UIView *senderView, MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    });
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadSettingCells];
}

- (void)loadSettingCells
{
    self.clear();
    
    CGFloat edgeTop = 8;
    
    {
        NSInteger sectionType = 0;
        self.addSection(sectionType).sectionInsets(UIEdgeInsetsMake(edgeTop, 0, 0, 0));
        self.addXibCell([WXSettingItemCell class]).toSection(sectionType).withDataModel(@"账号与安全");
    }
    
    {
        NSInteger sectionType = 1;
        self.addSection(sectionType).sectionInsets(UIEdgeInsetsMake(edgeTop, 0, 0, 0));
        self.addXibCells([WXSettingItemCell class]).toSection(sectionType).withDataModelArray(@[@"新消息通知", @"隐私", @"通用"]);
    }
    
    {
        NSInteger sectionType = 2;
        self.addSection(sectionType).sectionInsets(UIEdgeInsetsMake(edgeTop, 0, 0, 0));
        self.addXibCells([WXSettingItemCell class]).toSection(sectionType).withDataModelArray(@[@"帮助与反馈", @"关于微信"]);
    }
    
    {
        NSInteger sectionType = 3;
        self.addSection(sectionType).sectionInsets(UIEdgeInsetsMake(edgeTop, 0, 0, 0));
        self.addXibCell([WXSettingItemCell class]).toSection(sectionType).withDataModel(@"插件");
    }
    
    {
        NSInteger sectionType = 4;
        self.addSection(sectionType).sectionInsets(UIEdgeInsetsMake(edgeTop, 0, 0, 0));
        self.addXibCell([WXSettingButtonCell class]).toSection(sectionType).withDataModel(@"切换账号");
    }
    
    {
        NSInteger sectionType = 5;
        self.addSection(sectionType).sectionInsets(UIEdgeInsetsMake(edgeTop, 0, 0, 0));
        self.addXibCell([WXSettingButtonCell class]).toSection(sectionType).withDataModel(@"退出登录");
    }
    
    [self reloadView];
}

@end
