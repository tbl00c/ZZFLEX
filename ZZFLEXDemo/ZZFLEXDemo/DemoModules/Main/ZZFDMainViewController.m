//
//  ZZFDMainViewController.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/11/28.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFDMainViewController.h"

typedef NS_ENUM(NSInteger, ZZFDMainSectionType) {
    ZZFDMainSectionTypeVC = 100,            // ZZFlexibleLayoutViewController
    ZZFDMainSectionTypeVCEdit,              // ZZFlexibleLayoutViewController 编辑拓展
    ZZFDMainSectionTypeRQ,                  // ZZFLEX事件响应队列
    ZZFDMainSectionTypeVE,                  // ZZFLEX View拓展
    ZZFDMainSectionTypeAD,                  // 广告
};

@interface ZZFDMainViewController ()

@end

@implementation ZZFDMainViewController

- (void)loadView
{
    [super loadView];
    
    [self setTitle:@"ZZFLEX"];
    [self.view setBackgroundColor:RGBColor(239.0, 239.0, 244.0)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initMainMenu];
}

- (void)initMainMenu
{
    // ZZFlexibleLayoutViewController
    self.addSection(ZZFDMainSectionTypeVC).sectionInsets(UIEdgeInsetsMake(0, 0, 25, 0));
    self.setHeader(@"ZZFDMainIntroduceHeader")
    .withDataModel(@"ZZFLEXVC是一个基于UICollectionView实现的数据驱动的列表页框架。\n使用ZZFLEX，我们无需再关心collectionView的各种代理方法，只需潜心实现我们需要的列表元素。\n它使得一个复杂界面的构建就如同拼图一般，我们只需一件件的add我们需要的模块即可。")
    .toSection(ZZFDMainSectionTypeVC);
    self.addCell(@"ZZFDMainMenuCell").withDataModel(@"ZZFLEXVC 电商详情页Demo").toSection(ZZFDMainSectionTypeVC);
    
    // ZZFlexibleLayoutViewController + Edit
    self.addSection(ZZFDMainSectionTypeVCEdit).sectionInsets(UIEdgeInsetsMake(0, 0, 25, 0));
    self.setHeader(@"ZZFDMainIntroduceHeader")
    .withDataModel(@"ZZFLEXVC+Edit拓展，是ZZFLEX具有处理编辑页面能力的一种解决方案.\n其主要原理是将数据模型的属性与UI控件对应属性进行关联映射。")
    .toSection(ZZFDMainSectionTypeVCEdit);
    self.addCell(@"ZZFDMainMenuCell").withDataModel(@"ZZFLEXVC+Edit 信息编辑页Demo").toSection(ZZFDMainSectionTypeVCEdit);
    
    // ZZFLEX事件响应队列
    self.addSection(ZZFDMainSectionTypeRQ).sectionInsets(UIEdgeInsetsMake(0, 0, 25, 0));;
    self.setHeader(@"ZZFDMainIntroduceHeader")
    .withDataModel(@"某些复杂页面的数据可能是来自多个网络请求的，然而同时发起的网络请求，请求结果返回顺序是不确定的。\nZZFLEXRequestQueue设计用来保证这种业务场景下，按既定顺序依次加载展示UI。")
    .toSection(ZZFDMainSectionTypeRQ);
    self.addCell(@"ZZFDMainMenuCell").withDataModel(@"ZZFLEXRequestQueue 多接口页面Demo").toSection(ZZFDMainSectionTypeRQ);
    
    // ZZFLEX View拓展
    self.addSection(ZZFDMainSectionTypeVE).sectionInsets(UIEdgeInsetsMake(0, 0, 25, 0));
    self.setHeader(@"ZZFDMainIntroduceHeader")
    .withDataModel(@"UIView+ZZFLEX 是使用链式API实现的快速编写UI代码的拓展，旨在实现View级别的模块化。")
    .toSection(ZZFDMainSectionTypeVE);
    self.addCell(@"ZZFDMainMenuCell").withDataModel(@"UIView+ZZFLEX Demo").toSection(ZZFDMainSectionTypeVE);
    
    // ZZFLEX AD
    self.addSection(ZZFDMainSectionTypeAD).sectionInsets(UIEdgeInsetsMake(40, 0, 80, 0));
    self.addCell(@"ZZFDADCell").toSection(ZZFDMainSectionTypeAD).eventAction(^id(NSInteger eventType, id data) {
        [[UIApplication sharedApplication] openURL:@"https://itunes.apple.com/cn/app/id1002355194?mt=8".toURL];
        return nil;
    });
    
    [self reloadView];
}

@end
