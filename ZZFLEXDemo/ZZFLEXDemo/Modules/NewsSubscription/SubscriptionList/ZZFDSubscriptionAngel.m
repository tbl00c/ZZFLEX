//
//  ZZFDSubscriptionAngel.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2018/2/7.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "ZZFDSubscriptionAngel.h"
#import "ZZFLEXAngel+Private.h"
#import "ZZFlexibleLayoutSectionModel.h"
#import "ZZFDSubscriptionEditViewController.h"
#import "ZZFDSubscriptionModel+Request.h"
#import "TLMenuItem.h"
#import "ZZFDSubscriptionTitleCell.h"
#import "ZZFDSubscriptionCell.h"

@interface ZZFDSubscriptionAngel ()

@property (nonatomic, copy) void (^pushAction)(__kindof UIViewController *vc);

@end

@implementation ZZFDSubscriptionAngel

- (instancetype)initWithHostView:(__kindof UIScrollView *)hostView pushAction:(void (^)(__kindof UIViewController *vc))pushAction;
{
    if (self = [super initWithHostView:hostView]) {
        self.pushAction = pushAction;
    }
    return self;
}

- (void)loadBillListUIWithData:(NSArray *)data
{
    @weakify(self);
    self.clear();
    
    self.addSection(ZZFDBillListVCSectionTypeAdd);
    self.addSeperatorCell(CGSizeMake(0, 15), [UIColor clearColor]).toSection(ZZFDBillListVCSectionTypeAdd);
    self.addCell([ZZFDSubscriptionTitleCell class]).toSection(ZZFDBillListVCSectionTypeAdd).withDataModel(createMenuItem(@"add_icon", @"添加订阅")).selectedAction(^ (id model) {
        @strongify(self);
        ZZFDSubscriptionEditViewController *billEditVC = [[ZZFDSubscriptionEditViewController alloc] initWithSubModel:nil completeAction:^(ZZFDSubscriptionModel *subModel) {
            @strongify(self);
            [self requestAddSubscription:subModel];
        }];
        [billEditVC setTitle:@"添加订阅"];
        if (self.pushAction) {
            self.pushAction(billEditVC);
        }
    });
    self.addSeperatorCell(CGSizeMake(0, 15), [UIColor clearColor]).toSection(ZZFDBillListVCSectionTypeAdd);
    
    self.addSection(ZZFDBillListVCSectionTypeItems);
    if (data.count > 0) {
        self.addCells([ZZFDSubscriptionCell class]).toSection(ZZFDBillListVCSectionTypeItems).withDataModelArray(data).selectedAction(^ (ZZFDSubscriptionModel *model) {
            @strongify(self);
            ZZFDSubscriptionEditViewController *billEditVC = [[ZZFDSubscriptionEditViewController alloc] initWithSubModel:model.mutableCopy completeAction:^(ZZFDSubscriptionModel *subModel) {
                @strongify(self);
                [self requestModifySubscription:subModel];
            }];
            [billEditVC setTitle:@"编辑订阅"];
            if (self.pushAction) {
                self.pushAction(billEditVC);
            }
        });
    }
    
    [(UITableView *)self.hostView reloadData];
}

#pragma mark - # Request
- (void)requestData
{
    @weakify(self);
    [ZZFDSubscriptionModel requestSubListSuccess:^(NSArray<ZZFDSubscriptionModel *> *data) {
        @strongify(self);
        [self loadBillListUIWithData:data];
    } failure:nil];
}

- (void)requestAddSubscription:(ZZFDSubscriptionModel *)model
{
    model.subId = @([[NSDate date] timeIntervalSince1970]).stringValue;
    NSMutableArray *data = self.sectionForTag(ZZFDBillListVCSectionTypeItems).dataModelArray.mutableCopy;
    [data insertObject:model atIndex:0];
    [self loadBillListUIWithData:data];
}

- (void)requestModifySubscription:(ZZFDSubscriptionModel *)model
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

#pragma mark - # Delegate
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    @weakify(self);
    TLWeakSelf(tableView);
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:indexPath.section];
    if (sectionModel.sectionTag == ZZFDBillListVCSectionTypeItems) {
        UITableViewRowAction *delAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                             title:@"删除"
                                                                           handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                                                               @strongify(self);
                                                                               self.deleteCell.atIndexPath(indexPath);
                                                                               [weaktableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:YES];
                                                                           }];
        return @[delAction];
    }
    return @[];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:indexPath.section];
    if (sectionModel.sectionTag == ZZFDBillListVCSectionTypeItems) {
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleNone;
}

@end
