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
#import "ZZFDMainMenuCell.h"

#import "ZZFDGoodListViewController.h"
#import "TLMineViewController.h"
#import "ZZFDCateViewController.h"
#import "TLContactsViewController.h"
#import "ZZFDRquestQueueViewController.h"

typedef NS_ENUM(NSInteger, ZZFDMainSectionType) {
    ZZFDMainSectionTypeHello,               // Hello
    ZZFDMainSectionTypeVC,                  // ZZFlexibleLayoutViewController
    ZZFDMainSectionTypeAgent,               // ZZFLEXAgent
    ZZFDMainSectionTypeVCEdit,              // ZZFlexibleLayoutViewController 编辑拓展
    ZZFDMainSectionTypeVE,                  // ZZFLEX View拓展
    ZZFDMainSectionTypeRQ,                  // ZZFLEX事件响应队列
};

NSAttributedString *__zz_create_introduce(NSString *title, NSString *detail)
{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] init];
    if (title) {
        NSAttributedString *attrTitle = [[NSAttributedString alloc] initWithString:[title stringByAppendingString:@"\n"]
                                                                        attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:15],
                                                                                     NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                                                                     }];
        [attrStr appendAttributedString:attrTitle];
    }
    if (detail) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:5];
        NSAttributedString *attrDetail = [[NSAttributedString alloc] initWithString:detail
                                                                         attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13],
                                                                                      NSForegroundColorAttributeName : [UIColor grayColor],
                                                                                      NSParagraphStyleAttributeName : paragraphStyle,
                                                                                      }];
        [attrStr appendAttributedString:attrDetail];
        
        if (title && detail.length > 1) {
            NSMutableParagraphStyle *titlePStyle = [[NSMutableParagraphStyle alloc] init];
            [titlePStyle setLineSpacing:6];
            [attrStr addAttribute:NSParagraphStyleAttributeName value:titlePStyle range:NSMakeRange(0, title.length + 1)];
        }
    }
    return attrStr;
}


@interface ZZFDMainViewController ()

@end

@implementation ZZFDMainViewController

- (void)loadView
{
    [super loadView];
    [self.view setBackgroundColor:[UIColor colorGrayBG]];

    [self setTitle:@"ZZFlexibleLayoutFramework"];
//    [self setTitle:@"欢迎使用ZZFLEX全家桶"];
//    [self.navigationItem setTitle:@"ZZFLEX"];
    
    [self.navigationItem setBackBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain actionBlick:nil]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initMainMenu];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (@available(iOS 11.0, *)) {
        [self.navigationController.navigationBar setLargeTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:26]}];
        [self.navigationController.navigationBar setPrefersLargeTitles:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (@available(iOS 11.0, *)) {
        [self.navigationController.navigationBar setPrefersLargeTitles:NO];
    }
}

#pragma mark - # UI
- (void)initMainMenu
{
    @weakify(self);
    
    NSString *headerCell = NSStringFromClass([ZZFDMainSectionTitleView class]);
    NSString *menuCell = NSStringFromClass([ZZFDMainMenuCell class]);

    // Hello
    {
        NSInteger sectionTag = ZZFDMainSectionTypeHello;
        self.addSection(sectionTag);
        NSAttributedString *attrTitle;
        if (@available(iOS 11.0, *)) {
            attrTitle = __zz_create_introduce(nil,
                                              @"ZZFlexibleLayoutFramework(下简称ZZFLEX框架)是对UIKit的二次封装，设计思想为“UI的模块化”，使用它可以帮助你更快速更优雅的进行UI开发。\nZZFLEX目前包含以下5个部分:");
        }
        else {
            attrTitle = __zz_create_introduce(@"欢迎使用ZZFLEX全家桶",
                                              @"ZZFlexibleLayoutFramework(下简称ZZFLEX框架)是对UIKit的二次封装，设计思想为“UI的模块化”，使用它可以帮助你更快速更优雅的进行UI开发。\nZZFLEX目前包含以下5个部分:");
        }
        self.setHeader(headerCell).toSection(sectionTag).withDataModel(attrTitle);
    }
    
    // ZZFlexibleLayoutViewController
    {
        NSInteger sectionTag = ZZFDMainSectionTypeVC;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(0, 0, 30, 0));
        NSAttributedString *attrTitle = __zz_create_introduce(@"ZZFlexibleLayoutViewController",
                                                              @"ZZFlexibleLayoutViewController 是一个基于UICollectionView实现的数据驱动的列表页框架，可大幅降低复杂列表界面实现和维护的难度。\n使用它我们无需再关心collectionView的各种代理方法，只需潜心实现我们需要的列表元素。\n它使得一个复杂界面的构建就如同拼图一般，我们只需一件件的add需要的模块，即可绘制出我们想要的界面。");
        self.setHeader(headerCell).toSection(sectionTag).withDataModel(attrTitle);
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

    // ZZFLEXAgent
    {
        NSInteger sectionTag = ZZFDMainSectionTypeAgent;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(0, 0, 30, 0));
        NSAttributedString *attrTitle = __zz_create_introduce(@"ZZFLEXAngel",
                                                              @"ZZFlexibleLayoutViewController是一个页面级别的实现，这在某些业务场景下还是不够灵活的。\nZZFLEXAngel是ZZFLEXVC核心思想和设计的提炼。我们只需把任意collectionView/tableView的DataSource和Delegate指向它或它子类的实例，就可以和在ZZFLEXVC中一样使用那些好用的API。");
        self.setHeader(headerCell).toSection(sectionTag).withDataModel(attrTitle);
        
        self.addCell(menuCell).withDataModel(@"电商分类页").toSection(sectionTag).selectedAction(^(id model){
            @strongify(self);
            ZZFDCateViewController *goodDetailVC = [[ZZFDCateViewController alloc] init];
            PushVC(goodDetailVC);
        });
        self.addCell(menuCell).withDataModel(@"微信“通讯录”").toSection(sectionTag).selectedAction(^(id model){
            @strongify(self);
            TLContactsViewController *contactsVC = [[TLContactsViewController alloc] init];
            PushVC(contactsVC);
        });
    }

    // ZZFlexibleLayoutViewController + Edit
    {
        NSInteger sectionTag = ZZFDMainSectionTypeVCEdit;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(0, 0, 30, 0));
        NSAttributedString *attrTitle = __zz_create_introduce(@"ZZFLEXVC+EditExtension",
                                                              @"ZZFlexibleLayoutViewController+EditExtension，是使ZZFLEXVC具有处理编辑页面能力的一种解决方案。\n其主要原理是将数据模型的属性与UI控件对应属性进行关联映射。\n如果你的项目中使用了RAC，那么你大可无视这个拓展。");
        self.setHeader(headerCell).toSection(sectionTag).withDataModel(attrTitle);
        self.addCell(menuCell).withDataModel(@"信息编辑页 Demo").toSection(sectionTag);
    }

    // ZZFLEX View拓展
    {
        NSInteger sectionTag = ZZFDMainSectionTypeVE;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(0, 0, 15, 0));
        NSAttributedString *attrTitle = __zz_create_introduce(@"UIView+ZZFLEX",
                                                              @"UIView+ZZFLEX 是一个常用UI组件提供链式API的拓展，使用它可以更加方便快捷的进行UI的编写、布局和事件处理。\n上述Demo中多有使用此拓展，详见代码。");
        self.setHeader(headerCell).toSection(sectionTag).withDataModel(attrTitle);
    }

    // ZZFLEX事件响应队列
    {
        NSInteger sectionTag = ZZFDMainSectionTypeRQ;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(0, 0, 100, 0));
        NSAttributedString *attrTitle = __zz_create_introduce(@"ZZFLEXVC+EditExtension",
                                                              @"某些复杂页面可能存在多个数据请求（Net、DB、文件等），然而同时发起的请求，其结果返回顺序是不确定的。\nZZFLEXRequestQueue的核心思想是“将一次数据请求的过程封装成对象（即队列元素）”，如此以保证此业务场景下，可按既定顺序加载展示UI。");
        self.setHeader(headerCell).toSection(sectionTag).withDataModel(attrTitle);
        self.addCell(menuCell).withDataModel(@"多接口页面 Demo").toSection(sectionTag).selectedAction(^(id model){
            @strongify(self);
            ZZFDRquestQueueViewController *rqVC = [[ZZFDRquestQueueViewController alloc] init];
            PushVC(rqVC);
        });
    }
    
    [self reloadView];
}

@end
