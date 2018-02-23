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
#import "ZZFDSubscriptionViewController.h"
#import "ZZFDRquestQueueViewController.h"

#define     FDMAIN_FONT_SIZE_DETAIL         14

typedef NS_ENUM(NSInteger, ZZFDMainSectionType) {
    ZZFDMainSectionTypeHello,               // Hello
    ZZFDMainSectionTypeVE,                  // ZZFLEX View拓展
    ZZFDMainSectionTypeVC,                  // ZZFlexibleLayoutViewController
    ZZFDMainSectionTypeAgent,               // ZZFLEXAgent
    ZZFDMainSectionTypeEdit,                // 编辑类页面处理Demo
    ZZFDMainSectionTypeRQ,                  // ZZFLEX事件响应队列
};

NSMutableAttributedString *__zz_create_introduce(NSString *title, NSString *detail)
{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] init];
    if (title) {
        NSAttributedString *attrTitle = [[NSAttributedString alloc] initWithString:[title stringByAppendingString:@"\n"]
                                                                        attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:16],
                                                                                     NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                                                                     }];
        [attrStr appendAttributedString:attrTitle];
    }
    if (detail) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:5];
        NSAttributedString *attrDetail = [[NSAttributedString alloc] initWithString:detail
                                                                         attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:FDMAIN_FONT_SIZE_DETAIL],
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

void __zz_attr_string_bold(NSMutableAttributedString *attrStr, NSString *text) {
    NSRange range = [attrStr.string rangeOfString:text];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont italicSystemFontOfSize:FDMAIN_FONT_SIZE_DETAIL] range:range];
}


@interface ZZFDMainViewController ()

@end

@implementation ZZFDMainViewController

- (void)loadView
{
    [super loadView];
    [self.view setBackgroundColor:[UIColor colorGrayBG]];
        
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
        NSString *detail = @"ZZFlexibleLayoutFramework（下称ZZFLEX），是对UIKit的二次封装，助力于UI界面的快速开发，其主要设计思想为“UI的模块化”。\nZZFLEX目前包含以下5个部分:";
        if (@available(iOS 11.0, *)) {
            [self setTitle:@"欢迎使用ZZFLEX全家桶"];
            attrTitle = __zz_create_introduce(nil, detail);
        }
        else {
            [self setTitle:@"ZZFlexibleLayoutFramework"];
            attrTitle = __zz_create_introduce(@"欢迎使用ZZFLEX全家桶", detail);
        }
        self.setHeader(headerCell).toSection(sectionTag).withDataModel(attrTitle);
    }
    
    // ZZFLEX View拓展
    {
        NSInteger sectionTag = ZZFDMainSectionTypeVE;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(0, 0, 15, 0));
        NSAttributedString *attrTitle = __zz_create_introduce(@"UIView+ZZFLEX",
                                                              @"UIView+ZZFLEX 为常用的UI控件提供了链式调用方法，使用链式API可以更加连贯快捷的进行控件的属性设置、Masonry布局和事件处理。\n下述Demo中多有使用此拓展，详见代码。");
        self.setHeader(headerCell).toSection(sectionTag).withDataModel(attrTitle);
    }
    
    // ZZFlexibleLayoutViewController
    {
        NSInteger sectionTag = ZZFDMainSectionTypeVC;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(0, 0, 30, 0));
        NSMutableAttributedString *attrTitle = __zz_create_introduce(@"ZZFlexibleLayoutViewController",
                                                                     @"ZZFlexibleLayoutViewController（下称ZZFLEXVC） 是一个基于collectionView实现的数据驱动的列表页框架，可大幅降低复杂列表界面实现和维护的难度。\n使用它我们无需再关心collectionView的各种代理方法，只需潜心实现我们需要的列表元素。\n它使得一个复杂界面的构建就如同拼图一般，我们只需一件件的add需要的模块，即可绘制出我们想要的界面。");
        __zz_attr_string_bold(attrTitle, @"数据驱动的列表页框架");
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
        NSMutableAttributedString *attrTitle = __zz_create_introduce(@"ZZFLEXAngel",
                                                                     @"ZZFLEXVC为列表页的开发带来的优异的拓展性和可维护性，但它是一个VC级别的实现，在一些业务场景下还是不够灵活的。\nZZFLEXAngel是ZZFLEXVC核心思想和设计提炼而成的一个“列表控制中心”，它与页面和列表控件是完全解耦的。\n使用它我们只需把任意collectionView或tableView的dataSource和delegate指向它或它子类的实例，就可以通过这个实例、使用和ZZFLEXVC中一样的那些好用的API了。");
        __zz_attr_string_bold(attrTitle, @"列表控制中心");
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

    // ZZFLEXEditExtension
    {
        NSInteger sectionTag = ZZFDMainSectionTypeEdit;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(0, 0, 30, 0));
        NSAttributedString *attrTitle = __zz_create_introduce(@"ZZFLEXEditExtension",
                                                              @"此拓展使得ZZFLEXVC和ZZFLEXAngel具有了处理编辑页面的能力，其主要原理为规范了编辑类页面处理流程，并使用一个额外的模型来控制它");
        self.setHeader(headerCell).toSection(sectionTag).withDataModel(attrTitle);
        self.addCell(menuCell).withDataModel(@"开发者信息订阅").toSection(sectionTag).selectedAction(^(id model){
            @strongify(self);
            ZZFDSubscriptionViewController *subVC = [[ZZFDSubscriptionViewController alloc] init];
            PushVC(subVC);
        });
    }

    // ZZFLEX事件响应队列
    {
        NSInteger sectionTag = ZZFDMainSectionTypeRQ;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(0, 0, 100, 0));
        NSMutableAttributedString *attrTitle = __zz_create_introduce(@"ZZFLEXRequestQueue",
                                                                     @"一些复杂的页面中会存在多个异步数据请求（net、db等），然而同时发起的异步请求，其结果的返回顺序是不确定的，这样会导致UI展示顺序的不确定性，很多情况下这是我们不希望看到的。\nZZFLEXRequestQueue的核心思想是“将一次数据请求的过程封装成对象”，他可以保证在此业务场景下，按队列顺序加载展示UI。");
        __zz_attr_string_bold(attrTitle, @"将一次数据请求的过程封装成对象");
        self.setHeader(headerCell).toSection(sectionTag).withDataModel(attrTitle);
        self.addCell(menuCell).withDataModel(@"多接口页面 Demo").toSection(sectionTag).selectedAction(^(id model){
            @strongify(self);
            ZZFDRquestQueueViewController *rqVC = [[ZZFDRquestQueueViewController alloc] init];
            PushVC(rqVC);
        });
    }
    
    [self reloadView];
}

-（void)hello
{
    // 创建列表视图
    UITableView *tableView = self.view.addTableView(1)
    .frame(self.view.bounds)
    .backgroundColor([UIColor colorGrayBG])
    .tableFooterView([UIView new])
    .view;
    
    // 根据列表视图初始化angel，hostView支持UITableView和UICollectionView
    ZZFLEXAngel *angel = [[ZZFLEXAngel alloc] initWithHostView:self.tableView];
    
    // 添加列表元素
    angel.addSection(1);
    angel.addCell(@"ACell").toSection(1);
    
    // 刷新列表
    [tableView reloadData];

}

@end
