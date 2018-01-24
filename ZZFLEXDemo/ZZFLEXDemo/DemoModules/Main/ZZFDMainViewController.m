//
//  ZZFDMainViewController.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/11/28.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFDMainViewController.h"
#import "ZZFDMainTitleView.h"
#import "ZZFDMainSectionTitleView.h"
#import "ZZFDMainIntroduceCell.h"
#import "ZZFDMainMenuCell.h"

#import "ZZFDGoodListViewController.h"
#import "TLMineViewController.h"
#import "ZZFDCateViewController.h"

typedef NS_ENUM(NSInteger, ZZFDMainSectionType) {
    ZZFDMainSectionTypeHello,               // Hello
    ZZFDMainSectionTypeVC,                  // ZZFlexibleLayoutViewController
    ZZFDMainSectionTypeVCDemo,
    ZZFDMainSectionTypeAgent,               // ZZFLEXAgent
    ZZFDMainSectionTypeAgentDemo,
    ZZFDMainSectionTypeVCEdit,              // ZZFlexibleLayoutViewController 编辑拓展
    ZZFDMainSectionTypeVCEditDemo,
    ZZFDMainSectionTypeVE,                  // ZZFLEX View拓展
    ZZFDMainSectionTypeRQ,                  // ZZFLEX事件响应队列
    ZZFDMainSectionTypeRQDemo,
};

@interface ZZFDMainViewController ()

@end

@implementation ZZFDMainViewController

- (void)loadView
{
    [super loadView];

    [self setTitle:@"ZZFlexibleLayoutFramework"];
    [self.view setBackgroundColor:[UIColor colorGrayBG]];
    
    [self.navigationItem setBackBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain actionBlick:nil]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initMainMenu];
}

- (void)initMainMenu
{
    @weakify(self);
    
    NSString *menuCell = NSStringFromClass([ZZFDMainMenuCell class]);
    UIEdgeInsets demoSectionInset = UIEdgeInsetsMake(0, 0, 35, 0);
    
    void (^addIntroduceSection)(NSInteger, NSString *, NSArray *) = ^(NSInteger sectionTag, NSString *title, NSArray *intro) {
        self.addSection(sectionTag).minimumLineSpacing(8).sectionInsets(UIEdgeInsetsMake(8, 0, 8, 0));
        if (title) {
            self.setHeader(NSStringFromClass([ZZFDMainSectionTitleView class])).toSection(sectionTag).withDataModel(title);
        }
        self.addCells(NSStringFromClass([ZZFDMainIntroduceCell class])).toSection(sectionTag).withDataModelArray(intro);
    };
    
    
    // Hello
    {
        NSArray *intro = @[@"ZZFLEX框架是对UIKit的二次封装，设计思想为“UI的模块化”，使用它可以帮助你更快速更优雅的进行UI开发。",
                           @"ZZFLEX目前包含以下5个部分:"];
        addIntroduceSection(ZZFDMainSectionTypeHello, nil, intro);
        self.setHeader(@"ZZFDMainTitleView").toSection(ZZFDMainSectionTypeHello).withDataModel(@"欢迎使用ZZFLEX全家桶");
    }
    
    // ZZFlexibleLayoutViewController
    {
        // intro
        {
            NSArray *intro = @[@"ZZFlexibleLayoutViewController 是一个基于UICollectionView实现的数据驱动的列表页框架，可大幅降低复杂列表界面实现和维护的难度。",
                               @"使用它我们无需再关心collectionView的各种代理方法，只需潜心实现我们需要的列表元素。",
                               @"它使得一个复杂界面的构建就如同拼图一般，我们只需一件件的add需要的模块，即可绘制出我们想要的界面。"];
            addIntroduceSection(ZZFDMainSectionTypeVC, @"ZZFlexibleLayoutViewController", intro);
        }
        
        // Demo
        {
            NSInteger sectionTag = ZZFDMainSectionTypeVCDemo;
            self.addSection(sectionTag).sectionInsets(demoSectionInset);
            self.addCell(menuCell).withDataModel(@"商品列表&详情页").toSection(sectionTag).selectedAction(^(id model){
                @strongify(self);
                ZZFDGoodListViewController *goodDetailVC = [[ZZFDGoodListViewController alloc] init];
                PushVC(goodDetailVC);
            });
            self.addCell(menuCell).withDataModel(@"微信“我的”").toSection(sectionTag).selectedAction(^(id model){
                @strongify(self);
                TLMineViewController *mineVC = [[TLMineViewController alloc] init];
                PushVC(mineVC);
            });
        }
    }
   
    
    // ZZFLEXAgent
    {
        // Intro
        {
            NSArray *intro = @[@"ZZFlexibleLayoutViewController 是一个页面级别的实现，这在某些业务场景下还是不够灵活的。",
                               @"ZZFLEXAngel是ZZFLEXVC核心思想和设计的提炼。我们只需把任意collectionView/tableView的DataSource和Delegate指向它或它子类的实例，就可以和在ZZFLEXVC中一样使用那些好用的API。"];
            addIntroduceSection(ZZFDMainSectionTypeAgent, @"ZZFLEXAngel", intro);
        }
        
        // Demo
        {
            NSInteger sectionTag = ZZFDMainSectionTypeAgentDemo;
            self.addSection(sectionTag).sectionInsets(demoSectionInset);
            self.addCell(menuCell).withDataModel(@"电商分类页").toSection(sectionTag).selectedAction(^(id model){
                @strongify(self);
                ZZFDCateViewController *goodDetailVC = [[ZZFDCateViewController alloc] init];
                PushVC(goodDetailVC);
            });
        }
    }
    
    // ZZFlexibleLayoutViewController + Edit
    {
        // Intro
        {
            NSArray *intro = @[@"ZZFlexibleLayoutViewController+EditExtension，是使ZZFLEXVC具有处理编辑页面能力的一种解决方案。",
                               @"其主要原理是将数据模型的属性与UI控件对应属性进行关联映射。",
                               @"如果你的项目中使用了RAC，那么你大可无视这个拓展。"];
            addIntroduceSection(ZZFDMainSectionTypeVCEdit, @"ZZFLEXVC+EditExtension", intro);
        }
        
        // Demo
        {
            NSInteger sectionTag = ZZFDMainSectionTypeVCEditDemo;
            self.addSection(sectionTag).sectionInsets(demoSectionInset);
            self.addCell(menuCell).withDataModel(@"信息编辑页 Demo").toSection(sectionTag);
        }
    }

    // ZZFLEX View拓展
    {
        self.addSection(ZZFDMainSectionTypeVE).minimumLineSpacing(8).sectionInsets(UIEdgeInsetsMake(8, 0, 35, 0));
        self.setHeader(NSStringFromClass([ZZFDMainSectionTitleView class])).toSection(ZZFDMainSectionTypeVE).withDataModel(@"UIView+ZZFLEX");
        NSArray *intro = @[@"UIView+ZZFLEX 是一个常用UI组件提供链式API的拓展，使用它可以更加方便快捷的进行UI的编写、布局和事件处理。",
                           @"上述Demo中多有使用此拓展，详见代码。"];
        self.addCells(NSStringFromClass([ZZFDMainIntroduceCell class])).toSection(ZZFDMainSectionTypeVE).withDataModelArray(intro);
    }

    // ZZFLEX事件响应队列
    {
        // Intro
        {
            NSArray *intro = @[@"某些复杂页面的数据可能是来自多个网络请求的，然而同时发起的网络请求，请求结果返回顺序是不确定的。",
                               @"ZZFLEXRequestQueue设计用来保证这种业务场景下，按既定顺序依次加载展示UI。"];
            addIntroduceSection(ZZFDMainSectionTypeRQ, @"ZZFLEXRequestQueue", intro);
        }
        
        // Demo
        {
            NSInteger sectionTag = ZZFDMainSectionTypeRQDemo;
            self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(0, 0, 100, 0));
            self.addCell(menuCell).withDataModel(@"多接口页面 Demo").toSection(sectionTag);
        }
    }
    
    [self reloadView];
}

@end
