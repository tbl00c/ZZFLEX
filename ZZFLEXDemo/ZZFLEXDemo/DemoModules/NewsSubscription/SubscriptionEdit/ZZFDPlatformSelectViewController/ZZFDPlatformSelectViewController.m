//
//  ZZFDPlatformSelectViewController.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2018/2/5.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "ZZFDPlatformSelectViewController.h"

@interface ZZFDPlatformSelectViewController ()

@property (nonatomic, strong) NSArray *itemsArray;

@property (nonatomic, copy) void (^selectedAction)(ZZFDSubscriptionPlatform platform);

@end

@implementation ZZFDPlatformSelectViewController

- (instancetype)initWithSelectPlatform:(ZZFDSubscriptionPlatform)platform selectedAction:(void (^)(ZZFDSubscriptionPlatform platform))selectedAction
{
    if (self = [super init]) {
        self.selectedAction = selectedAction;
        
        NSMutableArray *data = [[NSMutableArray alloc] init];
        for (int i = 1; i < 5; i++) {
            ZZFDPlatformItemModel *model = [[ZZFDPlatformItemModel alloc] init];
            [model setTag:i];
            [model setTitle:[ZZFDSubscriptionModel getPlatformNameByType:i]];
            [model setSelected:i == platform];
            [data addObject:model];
        }
        self.itemsArray = data;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    [self setTitle:@"平台选择"];
    [self.collectionView setBackgroundColor:[UIColor colorGrayBG]];
    
    [self reloadUIWithModelArray:self.itemsArray];
}

- (void)reloadUIWithModelArray:(NSArray *)modelArray
{
    @weakify(self);
    self.clear();
    
    self.addSection(0).sectionInsets(UIEdgeInsetsMake(15, 0, 0, 0));
    self.addCells(@"ZZFDPlatformItemCell").withDataModelArray(modelArray).toSection(0).selectedAction(^ (ZZFDPlatformItemModel *model) {
        @strongify(self);
        for (ZZFDPlatformItemModel *item in self.itemsArray) {
            item.selected = (item == model);
        }
        [self reloadView];
        [self.collectionView setUserInteractionEnabled:NO];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.selectedAction) {
                self.selectedAction(model.tag);
            }
            [self.navigationController popViewControllerAnimated:YES];
        });
    });
    
    [self reloadView];
}

@end
