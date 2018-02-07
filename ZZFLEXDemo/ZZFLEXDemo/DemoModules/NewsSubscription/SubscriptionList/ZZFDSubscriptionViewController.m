//
//  ZZFDSubscriptionViewController.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2018/2/4.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "ZZFDSubscriptionViewController.h"
#import "ZZFDSubscriptionEditViewController.h"
#import "TLMenuItem.h"
#import "ZZFDSubscriptionModel+Request.h"

typedef NS_ENUM(NSInteger, ZZFDBillListVCSectionType) {
    ZZFDBillListVCSectionTypeAdd,
    ZZFDBillListVCSectionTypeItems,
};

@interface ZZFDSubscriptionViewController ()

@end

@implementation ZZFDSubscriptionViewController

- (void)loadView
{
    [super loadView];
    [self.view setBackgroundColor:[UIColor colorGrayBG]];
    [self setTitle:@"我的订阅"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self requsetData];
}

#pragma mark - # Request
- (void)requsetData
{
    @weakify(self);
    [ZZFDSubscriptionModel requestSubListSuccess:^(NSArray<ZZFDSubscriptionModel *> *data) {
        @strongify(self);
        [self loadBillListUIWithData:data];
    } failure:nil];
}

- (void)reqeustAddSubscription:(ZZFDSubscriptionModel *)model
{
    model.subId = @([[NSDate date] timeIntervalSince1970]).stringValue;
    NSMutableArray *data = self.sectionForTag(ZZFDBillListVCSectionTypeItems).dataModelArray.mutableCopy;
    [data insertObject:model atIndex:0];
    [self loadBillListUIWithData:data];
}

- (void)reqeustModifySubscription:(ZZFDSubscriptionModel *)model
{
    NSMutableArray *data = self.sectionForTag(ZZFDBillListVCSectionTypeItems).dataModelArray.mutableCopy;
    for (ZZFDSubscriptionModel *item in data) {
        if ([item.subId isEqualToString:model.subId]) {
            NSInteger index = [data indexOfObject:item];
            [data replaceObjectAtIndex:index withObject:model];
            break;
        }
    }
    
    [self loadBillListUIWithData:data];
}

#pragma mark - # UI
- (void)loadBillListUIWithData:(NSArray *)data
{
    @weakify(self);
    self.clear();
    
    self.addSection(ZZFDBillListVCSectionTypeAdd).sectionInsets(UIEdgeInsetsMake(15, 0, 0, 0));
    self.addCell(@"TLMenuItemCell").toSection(ZZFDBillListVCSectionTypeAdd).withDataModel(createMenuItem(@"add_icon", @"添加订阅")).selectedAction(^ (id model) {
        @strongify(self);
        ZZFDSubscriptionEditViewController *billEditVC = [[ZZFDSubscriptionEditViewController alloc] initWithSubModel:nil completeAction:^(ZZFDSubscriptionModel *subModel) {
            @strongify(self);
            [self reqeustAddSubscription:subModel];
        }];
        [billEditVC setTitle:@"添加订阅"];
        PushVC(billEditVC);
    });
    
    self.addSection(ZZFDBillListVCSectionTypeItems).sectionInsets(UIEdgeInsetsMake(10, 0, 40, 0));
    if (data.count > 0) {
        self.addCells(@"ZZFDSubscriptionCell").toSection(ZZFDBillListVCSectionTypeItems).withDataModelArray(data).selectedAction(^ (ZZFDSubscriptionModel *model) {
            @strongify(self);
            ZZFDSubscriptionEditViewController *billEditVC = [[ZZFDSubscriptionEditViewController alloc] initWithSubModel:model.mutableCopy completeAction:^(ZZFDSubscriptionModel *subModel) {
                @strongify(self);
                [self reqeustModifySubscription:subModel];
            }];
            [billEditVC setTitle:@"编辑订阅"];
            PushVC(billEditVC);
        });
    }
    
    [self.collectionView reloadData];
}

@end
