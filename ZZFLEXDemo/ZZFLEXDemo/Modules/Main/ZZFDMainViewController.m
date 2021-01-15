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
#import "ZZFDAlbumViewController.h"
#import "WXSettingViewController.h"
#import "WXContactsViewController.h"

#define     FDMAIN_FONT_SIZE_DETAIL         14
#define     ClassMenuHeaderCell             [ZZFDMainSectionTitleView class]
#define     ClassMenuCell                   [ZZFDMainMenuCell class]

typedef NS_ENUM(NSInteger, ZZFDMainSectionType) {
    ZZFDMainSectionTypeHello,               // Hello
    ZZFDMainSectionTypeFE,                  // ZZFLEX Foundation拓展
    ZZFDMainSectionTypeVE,                  // ZZFLEX View拓展
    ZZFDMainSectionTypeVC,                  // ZZFLEXCollectionViewController
    ZZFDMainSectionTypeTVC,
    ZZFDMainSectionTypeVCExtension,
    ZZFDMainSectionTypeAgent,               // ZZFLEXAgent
    ZZFDMainSectionTypeEdit,                // 编辑类页面处理Demo
    ZZFDMainSectionTypeRQ,                  // ZZFLEX事件响应队列
    ZZFDMainSectionTypeHeaderSpace,
};

NSMutableAttributedString *__zz_create_introduce(NSString *title, NSString *detail)
{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] init];
    if (title) {
        NSAttributedString *attrTitle = NSMutableAttributedString.zz_create([title stringByAppendingString:@"\n"]).font([UIFont boldSystemFontOfSize:17]).foregroundColor([UIColor darkGrayColor]).object;
        [attrStr appendAttributedString:attrTitle];
    }
    if (detail) {
        NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.zz_create.lineSpacing(5).object;
        NSAttributedString *attrDetail = NSMutableAttributedString.zz_create(detail).font([UIFont systemFontOfSize:FDMAIN_FONT_SIZE_DETAIL]).foregroundColor([UIColor grayColor]).paragraphStyle(paragraphStyle).object;
        [attrStr appendAttributedString:attrDetail];
        
        if (title && detail.length > 1) {
            NSMutableParagraphStyle *titlePStyle = NSMutableParagraphStyle.zz_create.lineSpacing(5).object;
            attrStr.zz_setup.paragraphStyleWithRange(titlePStyle, NSMakeRange(0, title.length + 1));
        }
    }
    return attrStr;
}

void __zz_attr_string_bold(NSMutableAttributedString *attrStr, NSString *text) {
    NSRange range = [attrStr.string rangeOfString:text];
    attrStr.zz_setup.foregroundColorWithRange([UIColor darkGrayColor], range).fontWithRange([UIFont italicSystemFontOfSize:FDMAIN_FONT_SIZE_DETAIL], range);
}


@implementation ZZFDMainViewController

- (void)loadView
{
    [super loadView];
    [self.view setBackgroundColor:[UIColor colorGrayBG]];
    [self setTitle:@"ZZFLEX"];
    [self.navigationItem setBackBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain actionBlick:nil]];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    [self addRightBarButtonWithTitle:[NSString stringWithFormat:@"%@", version] actionBlick:^{
        TLActionSheet *actionSheet = [[TLActionSheet alloc] initWithTitle:[NSString stringWithFormat:@"当前版本号：%@", version] clickAction:^(NSInteger buttonIndex) {
            if (buttonIndex == 0) {
                [[UIApplication sharedApplication] openURL:@"https://github.com/tbl00c/ZZFLEX".toURL];
            }
        } cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"Github", nil];
        [actionSheet show];
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initMainMenu];
}

#pragma mark - # UI
- (void)initMainMenu
{
    @weakify(self);
    
    self.addSection(ZZFDMainSectionTypeHeaderSpace).sectionInsets(UIEdgeInsetsMake(10, 15, 0, 15));

    // Hello
    {
        NSInteger sectionTag = ZZFDMainSectionTypeHello;
        self.addSection(sectionTag);
        NSString *detail = @"ZZFlexibleLayoutFramework（下称ZZFLEX），是对UIKit的二次封装，助力于UI界面的快速开发，其主要设计思想为“UI的模块化”。\nZZFLEX目前包含以下5个部分:";
        NSAttributedString *attrTitle = __zz_create_introduce(@"欢迎使用ZZFLEX全家桶", detail);
        self.setHeader(ClassMenuHeaderCell).toSection(sectionTag).withDataModel(attrTitle);
    }
    
    // ZZFLEX Foundation拓展
    {
        NSInteger sectionTag = ZZFDMainSectionTypeFE;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(0, 15, 15, 15));
        NSAttributedString *attrTitle = __zz_create_introduce(@"ZZFLEXFoundationExtension",
                                                              @"ZZFLEXFoundationExtension 为Foundation框架链式封装，目前提供了NSAttributeString的链式API拓展，见本页面Demo。");
        self.setHeader(ClassMenuHeaderCell).toSection(sectionTag).withDataModel(attrTitle);
    }
    
    
    // ZZFLEX View拓展
    {
        NSInteger sectionTag = ZZFDMainSectionTypeVE;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(0, 15, 25, 15));
        NSAttributedString *attrTitle = __zz_create_introduce(@"UIView+ZZFLEX",
                                                              @"UIView+ZZFLEX 为常用的UI控件提供了链式调用方法，使用链式API可以更加连贯快捷的进行控件的属性设置、Masonry布局和事件处理。\n下述Demo中多有使用此拓展，详见代码。");
        self.setHeader(ClassMenuHeaderCell).toSection(sectionTag).withDataModel(attrTitle);
    }
    
    // ZZFLEXAgent
    {
        NSInteger sectionTag = ZZFDMainSectionTypeAgent;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(0, 15, 30, 15));
        NSMutableAttributedString *attrTitle = __zz_create_introduce(@"ZZFLEXAngel",
                                                                     @"ZZFLEXAngel是一个列表页控制器，支持UITableView和UICollectionView（统称hostView）；使用她，我们通常无需关心和实现hostView的各种代理方法。她的设计使得列表页的构建就如同拼图一般，只需要一件件的add需要的cell\\header\\footer(需实现ZZFlexibleLayoutViewProtocol)，我们想要的界面就绘制出来了。");
        __zz_attr_string_bold(attrTitle, @"列表控制中心");
        self.setHeader(ClassMenuHeaderCell).toSection(sectionTag).withDataModel(attrTitle);
        
        self.addCell(ClassMenuCell).withDataModel(@"电商分类页").toSection(sectionTag).selectedAction(^(id model){
            @strongify(self);
            ZZFDCateViewController *vc = [[ZZFDCateViewController alloc] init];
            PushVC(vc);
        });
        self.addCell(ClassMenuCell).withDataModel(@"微信“通讯录”").toSection(sectionTag).selectedAction(^(id model){
            @strongify(self);
            TLContactsViewController *vc = [[TLContactsViewController alloc] init];
            PushVC(vc);
        });
    }
    
    // ZZFLEXCollectionViewController
    {
        NSInteger sectionTag = ZZFDMainSectionTypeVC;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(0, 15, 30, 15));
        NSMutableAttributedString *attrTitle = __zz_create_introduce(@"ZZFLEXCollectionViewController",
                                                                     @"基于UICollectionView+ZZFLEXAngel的VC级实现");
        self.setHeader(ClassMenuHeaderCell).toSection(sectionTag).withDataModel(attrTitle);
        self.addCell(ClassMenuCell).withDataModel(@"商品列表&详情页").toSection(sectionTag).selectedAction(^(id model){
            @strongify(self);
            ZZFDGoodListViewController *vc = [[ZZFDGoodListViewController alloc] init];
            PushVC(vc);
        });
        self.addCell(ClassMenuCell).withDataModel(@"微信“我的”").toSection(sectionTag).selectedAction(^(id model){
            @strongify(self);
            TLMineViewController *vc = [[TLMineViewController alloc] init];
            PushVC(vc);
        });
        self.addCell(ClassMenuCell).withDataModel(@"微信“设置” (XIB)").toSection(sectionTag).selectedAction(^(id model){
            @strongify(self);
            WXSettingViewController *vc = [[WXSettingViewController alloc] init];
            PushVC(vc);
        });
    }
    
    // ZZFLEXTableViewController
    {
       NSInteger sectionTag = ZZFDMainSectionTypeTVC;
       self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(0, 15, 30, 15));
       NSMutableAttributedString *attrTitle = __zz_create_introduce(@"ZZFLEXTableViewController",
                                                                    @"基于UITableView+ZZFLEXAngel的VC级实现");
       self.setHeader(ClassMenuHeaderCell).toSection(sectionTag).withDataModel(attrTitle);
       self.addCell(ClassMenuCell).withDataModel(@"微信“通信录”").toSection(sectionTag).selectedAction(^(id model){
           @strongify(self);
           WXContactsViewController *vc = [[WXContactsViewController alloc] init];
           PushVC(vc);
       });
    }
    
    {
        NSInteger sectionTag = ZZFDMainSectionTypeVCExtension;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(0, 15, 30, 15));
        NSMutableAttributedString *attrTitle = __zz_create_introduce(@"低成本迁移至ZZFLEX列表页",
                                                                     @"针对已存在的列表页，我们提供了一种无需修改Cell代码便可快速迁移至ZZFLEX列表页的方案，为后续的开发带来最大的便捷。");
        __zz_attr_string_bold(attrTitle, @"无需修改Cell代码");
        self.setHeader(ClassMenuHeaderCell).toSection(sectionTag).withDataModel(attrTitle);
        self.addCell(ClassMenuCell).withDataModel(@"相册列表页").toSection(sectionTag).selectedAction(^(id model){
            @strongify(self);
            ZZFDAlbumViewController *vc = [[ZZFDAlbumViewController alloc] init];
            PushVC(vc);
        });
    }

    // ZZFLEXEditExtension
    {
        NSInteger sectionTag = ZZFDMainSectionTypeEdit;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(0, 15, 30, 15));
        NSAttributedString *attrTitle = __zz_create_introduce(@"ZZFLEXEditExtension",
                                                              @"此拓展使得ZZFLEXVC和ZZFLEXAngel具有了处理编辑页面的能力，其主要原理为规范了编辑类页面处理流程，并使用一个额外的模型来控制它");
        self.setHeader(ClassMenuHeaderCell).toSection(sectionTag).withDataModel(attrTitle);
        self.addCell(ClassMenuCell).withDataModel(@"开发者信息订阅").toSection(sectionTag).selectedAction(^(id model){
            @strongify(self);
            ZZFDSubscriptionViewController *vc = [[ZZFDSubscriptionViewController alloc] init];
            PushVC(vc);
        });
    }

    // ZZFLEX事件响应队列
    {
        NSInteger sectionTag = ZZFDMainSectionTypeRQ;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(0, 15, 100, 15));
        NSMutableAttributedString *attrTitle = __zz_create_introduce(@"ZZFLEXRequestQueue",
                                                                     @"一些复杂的页面中会存在多个异步数据请求（net、db等），然而同时发起的异步请求，其结果的返回顺序是不确定的，这样会导致UI展示顺序的不确定性，很多情况下这是我们不希望看到的。\nZZFLEXRequestQueue的核心思想是“将一次数据请求的过程封装成对象”，他可以保证在此业务场景下，按队列顺序加载展示UI。");
        __zz_attr_string_bold(attrTitle, @"将一次数据请求的过程封装成对象");
        self.setHeader(ClassMenuHeaderCell).toSection(sectionTag).withDataModel(attrTitle);
        self.addCell(ClassMenuCell).withDataModel(@"多接口页面 Demo").toSection(sectionTag).selectedAction(^(id model){
            @strongify(self);
            ZZFDRquestQueueViewController *vc = [[ZZFDRquestQueueViewController alloc] init];
            PushVC(vc);
        });
    }
    
    [self reloadView];
}

@end
