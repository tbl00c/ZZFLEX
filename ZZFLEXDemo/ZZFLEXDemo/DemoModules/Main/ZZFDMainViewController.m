//
//  ZZFDMainViewController.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/11/28.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFDMainViewController.h"
#import "ZZFDMainTitles.h"
#import "ZZFDMainIntroduceHeader.h"
#import "ZZFDMainMenuCell.h"

#import "ZZFDGoodListViewController.h"
#import "TLMineViewController.h"

typedef NS_ENUM(NSInteger, ZZFDMainSectionType) {
    ZZFDMainSectionTypeVC,                  // ZZFlexibleLayoutViewController
    ZZFDMainSectionTypeVCEdit,              // ZZFlexibleLayoutViewController 编辑拓展
    ZZFDMainSectionTypeVE,                  // ZZFLEX View拓展
    ZZFDMainSectionTypeRQ,                  // ZZFLEX事件响应队列
    ZZFDMainSectionTypeAD,                  // 广告
};

@interface ZZFDMainViewController ()

@end

@implementation ZZFDMainViewController

- (void)loadView
{
    [super loadView];

    [self setTitle:@"ZZFlexibleLayoutFramework"];
    [self.view setBackgroundColor:[UIColor colorGrayBG]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initMainMenu];
}

- (void)initMainMenu
{
    @weakify(self);
    
    NSString *headerClassName = NSStringFromClass([ZZFDMainIntroduceHeader class]);
    NSString *menuCellCalssName = NSStringFromClass([ZZFDMainMenuCell class]);
    
    // ZZFlexibleLayoutViewController
    self.addSection(ZZFDMainSectionTypeVC).sectionInsets(UIEdgeInsetsMake(0, 0, 25, 0));
    // 设置header
    self.setHeader(headerClassName)
    .withDataModel(TITLE_ZZFLEX_VC)
    .toSection(ZZFDMainSectionTypeVC);
    // 添加cell，模块化
    self.addCell(menuCellCalssName).withDataModel(@"商品列表&详情页 Demo").toSection(ZZFDMainSectionTypeVC).selectedAction(^(id model){
        @strongify(self);
        ZZFDGoodListViewController *goodDetailVC = [[ZZFDGoodListViewController alloc] init];
        PushVC(goodDetailVC);
    });
    self.addCell(menuCellCalssName).withDataModel(@"微信“我的” Demo").toSection(ZZFDMainSectionTypeVC).selectedAction(^(id model){
        @strongify(self);
        TLMineViewController *mineVC = [[TLMineViewController alloc] init];
        PushVC(mineVC);
    });
    
    // ZZFlexibleLayoutViewController + Edit
    self.addSection(ZZFDMainSectionTypeVCEdit).sectionInsets(UIEdgeInsetsMake(0, 0, 25, 0));
    self.setHeader(headerClassName)
    .withDataModel(TITLE_ZZFLEX_EDIT_VC)
    .toSection(ZZFDMainSectionTypeVCEdit);
    self.addCell(menuCellCalssName).withDataModel(@"信息编辑页 Demo").toSection(ZZFDMainSectionTypeVCEdit);
    
    // ZZFLEX View拓展
    self.addSection(ZZFDMainSectionTypeVE).sectionInsets(UIEdgeInsetsMake(0, 0, 25, 0));
    self.setHeader(headerClassName)
    .withDataModel(TITLE_ZZFLEX_VE)
    .toSection(ZZFDMainSectionTypeVE);
    self.addCell(menuCellCalssName).withDataModel(@"UIView+ZZFLEX Demo").toSection(ZZFDMainSectionTypeVE);
    
    
    // ZZFLEX事件响应队列
    self.addSection(ZZFDMainSectionTypeRQ).sectionInsets(UIEdgeInsetsMake(0, 0, 25, 0));;
    self.setHeader(headerClassName)
    .withDataModel(TITLE_ZZFLEX_RQ)
    .toSection(ZZFDMainSectionTypeRQ);
    self.addCell(menuCellCalssName).withDataModel(@"多接口页面 Demo").toSection(ZZFDMainSectionTypeRQ);
    self.addCell(menuCellCalssName).withDataModel(@"多接口页面 - 接口失败重试 Demo").toSection(ZZFDMainSectionTypeRQ);
    
    
    // ZZFLEX AD
    self.addSection(ZZFDMainSectionTypeAD).sectionInsets(UIEdgeInsetsMake(40, 0, 80, 0));
    self.addCell(@"ZZFDADCell").toSection(ZZFDMainSectionTypeAD).eventAction(^id(NSInteger eventType, id data) {
        [[UIApplication sharedApplication] openURL:@"https://itunes.apple.com/cn/app/id1002355194?mt=8".toURL];
        return nil;
    });
    
    [self reloadView];
}

@end
