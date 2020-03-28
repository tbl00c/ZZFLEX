//
//  ZZFDWingsDemoViewController.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2020/2/3.
//  Copyright © 2020 李伯坤. All rights reserved.
//

#import "ZZFDWingsDemoViewController.h"
#import "ZZFDWingsNormalListViewController.h"

@interface ZZFDWingsDemoViewController ()

@end

@implementation ZZFDWingsDemoViewController

- (void)loadView
{
    [super loadView];
    [self setTitle:@"ZZFLEXAngelWings"];
    [self.view setBackgroundColor:[UIColor colorGrayBG]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self resetData];
}

- (void)resetData
{
    @weakify(self);
    CGFloat offset = 12;
    self.clear();
    
    // 平铺
    {
        NSInteger sectionType = 0;
        self.addSection(sectionType).sectionInsets(UIEdgeInsetsMake(offset, 0, 0, 0));
        
        self.addCell(ZZFLEXAngelWingsClassEnum.normalClass).toSection(sectionType).withDataModel(zzflex_createAngelItem(@"平铺分组菜单列表"))
        .selectedAction(^ (ZZFLEXAngelItem *item) {
            @strongify(self);
            ZZFDWingsNormalListViewController *vc = [[ZZFDWingsNormalListViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        });
        
        self.addCell(ZZFLEXAngelWingsClassEnum.normalClass).toSection(sectionType).withDataModel(zzflex_createAngelItem(@"区块分组菜单列表"))
        .selectedAction(^ (ZZFLEXAngelItem *item) {
            @strongify(self);
            ZZFDWingsNormalListViewController *vc = [[ZZFDWingsNormalListViewController alloc] init];
            [vc setGroup:YES];
            [self.navigationController pushViewController:vc animated:YES];
        });
    }
        
       
    
    [self reloadView];
}

@end
