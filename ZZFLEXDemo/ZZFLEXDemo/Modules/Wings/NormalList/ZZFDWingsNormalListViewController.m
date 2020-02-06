//
//  ZZFDWingsNormalListViewController.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2020/2/6.
//  Copyright © 2020 李伯坤. All rights reserved.
//

#import "ZZFDWingsNormalListViewController.h"

@interface ZZFDWingsNormalListViewController ()

@property (nonatomic, strong) NSString *icon;

@property (nonatomic, assign) ZZFLEXAngelItemAccessoryType accessoryType;

@property (nonatomic, assign) ZZFLEXAngelItemSeperatorType seperatorType;

@end

@implementation ZZFDWingsNormalListViewController

- (void)loadView
{
    [super loadView];
    [self setTitle:@"ZZFLEXAngelWings"];
    [self.view setBackgroundColor:[UIColor colorGrayBG]];
    
    @weakify(self);
    UISwitch *button1 = UISwitch.zz_create(0)
    .eventBlock(UIControlEventValueChanged, ^(UISwitch *button) {
        @strongify(self);
        self.icon = button.on ? @"mine_wallet" : nil;
        [self resetData];
    })
    .view;
    
    _accessoryType = ZZFLEXAngelItemAccessoryDisclosureIndicator;
    UISwitch *button2 = UISwitch.zz_create(0).on(YES)
    .eventBlock(UIControlEventValueChanged, ^(UISwitch *button) {
        @strongify(self);
        self.accessoryType = button.on ? ZZFLEXAngelItemAccessoryDisclosureIndicator : ZZFLEXAngelItemAccessoryNone;
        [self resetData];
    })
    .view;
    
    _seperatorType = ZZFLEXAngelItemSeperatorSimple;
    UISwitch *button3 = UISwitch.zz_create(0).on(YES)
    .eventBlock(UIControlEventValueChanged, ^(UISwitch *button) {
        @strongify(self);
        self.seperatorType = button.on ? ZZFLEXAngelItemSeperatorSimple : ZZFLEXAngelItemSeperatorNone;
        [self resetData];
    })
    .view;
    
    [self.navigationItem setRightBarButtonItems:@[[[UIBarButtonItem alloc] initWithCustomView:button1],
                                                  [[UIBarButtonItem alloc] initWithCustomView:button2],
                                                  [[UIBarButtonItem alloc] initWithCustomView:button3],
    ]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self resetData];
}

- (void)resetData
{
    CGFloat offset = 12;
    self.clear();

    UIEdgeInsets sectionInsets = self.group ? UIEdgeInsetsMake(offset, offset, 0, offset) : UIEdgeInsetsMake(offset, 0, 0, 0);
    NSValue *seperatorInsets = self.group ? [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 15)] : nil;
    
    void (^ addItemsToSection)(NSInteger) = ^ (NSInteger sectionType) {
        NSMutableArray *data = [[NSMutableArray alloc] init];
        
        [data addObject:zzflex_createAngelItem(@"标准菜单项1")];
        [data addObject:zzflex_createAngelItem(@"标准菜单项2")];
        [data addObject:zzflex_createAngelItemWithSubTitle(@"标准菜单项3", @"这里是副标题")];
        [data addObject:zzflex_createAngelItemWithSubTitle(@"标准菜单项4", @"这里是副标题")];

        for (ZZFLEXAngelItem *item in data) {
            item.iconName = self.icon;
            item.style.cornorType = self.group ? ZZFLEXAngelItemCornorSimple : ZZFLEXAngelItemCornorNone;
            item.style.seperatorInsets = seperatorInsets;
            item.style.seperatorType = self.seperatorType;
            item.style.accessoryType = self.accessoryType;
        }
        
        self.addCells(ZZFLEXAngeWingsClassEnum.normalClass).toSection(sectionType).withDataModelArray(data);
    };

    NSInteger sectionType = 0;
    // 组1
    {
        sectionType ++;
        self.addSection(sectionType).sectionInsets(sectionInsets);
        
        addItemsToSection(sectionType);
    }
    
    // 组4
    {
        sectionType ++;
        self.addSection(sectionType).sectionInsets(sectionInsets);
        
        addItemsToSection(sectionType);
    }
    
    [self reloadView];
}

@end
