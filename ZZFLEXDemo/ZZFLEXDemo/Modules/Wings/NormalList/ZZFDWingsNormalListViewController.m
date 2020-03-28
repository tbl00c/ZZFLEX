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
    
    self.seperatorType = ZZFLEXAngelItemSeperatorSimple;
    self.accessoryType = ZZFLEXAngelItemAccessoryDisclosureIndicator;
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
    NSInteger sectionType = 0;

    UIEdgeInsets sectionInsets = self.group ? UIEdgeInsetsMake(offset, offset, 0, offset) : UIEdgeInsetsMake(offset, 0, 0, 0);
    NSValue *seperatorInsets = self.group ? [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 15)] : nil;
    
    ZZFLEXAngelItem *(^__machinedItem)(ZZFLEXAngelItem *) = ^ZZFLEXAngelItem *(ZZFLEXAngelItem *item) {
        item.iconName = self.icon;
        item.style.cornorType = self.group ? ZZFLEXAngelItemCornorSimple : ZZFLEXAngelItemCornorNone;
        item.style.seperatorInsets = seperatorInsets;
        item.style.seperatorType = self.seperatorType;
        item.style.accessoryType = self.accessoryType;
        return item;
    };
    
    {
        sectionType ++;
        self.addSection(sectionType).sectionInsets(sectionInsets);
        self.addCell(ZZFLEXAngelWingsClassEnum.switchClass).toSection(sectionType).withDataModel(__machinedItem(zzflex_createAngelSwitchItem(@"图标", self.icon != nil)))
        .eventAction(^ id(NSInteger eventType, ZZFLEXAngelItem *item) {
            @strongify(self);
            self.icon = item.style.selected ? @"mine_wallet" : nil;
            [self resetData];
            return nil;
        });
             
        self.addCell(ZZFLEXAngelWingsClassEnum.switchClass).toSection(sectionType).withDataModel(__machinedItem(zzflex_createAngelSwitchItem(@"更多指示器", self.accessoryType == ZZFLEXAngelItemAccessoryDisclosureIndicator)))
        .eventAction(^ id(NSInteger eventType, ZZFLEXAngelItem *item) {
            @strongify(self);
            self.accessoryType = item.style.selected ? ZZFLEXAngelItemAccessoryDisclosureIndicator : ZZFLEXAngelItemAccessoryNone;
            [self resetData];
            return nil;
        });
        
        self.addCell(ZZFLEXAngelWingsClassEnum.switchClass).toSection(sectionType).withDataModel(__machinedItem(zzflex_createAngelSwitchItem(@"分割线", self.seperatorType == ZZFLEXAngelItemSeperatorSimple)))
        .eventAction(^ id(NSInteger eventType, ZZFLEXAngelItem *item) {
            @strongify(self);
            self.seperatorType = item.style.selected ? ZZFLEXAngelItemSeperatorSimple : ZZFLEXAngelItemSeperatorNone;
            [self resetData];
            return nil;
        });
    }
    
    
    void (^ addItemsToSection)(NSInteger) = ^ (NSInteger sectionType) {
        NSMutableArray *data = [[NSMutableArray alloc] init];
        
        [data addObject:zzflex_createAngelItem(@"标准菜单项1")];
        [data addObject:zzflex_createAngelItem(@"标准菜单项2")];
        [data addObject:zzflex_createAngelItemWithSubTitle(@"标准菜单项3", @"这里是副标题")];
        [data addObject:zzflex_createAngelItemWithSubTitle(@"标准菜单项4", @"这里是副标题")];

        for (ZZFLEXAngelItem *item in data) {
            __machinedItem(item);
        }
        
        self.addCells(ZZFLEXAngelWingsClassEnum.normalClass).toSection(sectionType).withDataModelArray(data);
    };

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
