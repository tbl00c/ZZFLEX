//
//  TLContactsAngel.m
//  TLChat
//
//  Created by 李伯坤 on 2018/1/8.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "TLContactsAngel.h"
#import "ZZFLEXAngel+Private.h"
#import "TLUserGroup.h"
#import "TLContactsItemCell.h"
#import "ZZFlexibleLayoutSectionModel.h"
#import "TLContactsHeaderView.h"

@interface TLContactsAngel ()

/// header
@property (nonatomic, strong) NSArray *sectionHeaders;

@end

@implementation TLContactsAngel

- (instancetype)initWithHostView:(__kindof UIScrollView *)hostView pushAction:(void (^)(__kindof UIViewController *vc))pushAction
{
    if (self = [super initWithHostView:hostView]) {
        self.pushAction = pushAction;
    }
    return self;
}

- (void)resetListWithContactsData:(NSArray *)contactsData sectionHeaders:(NSArray *)sectionHeaders
{
    self.sectionHeaders = sectionHeaders;
    
    @weakify(self);
    self.clear();
    
    /// 功能
    self.addSection(TLContactsVCSectionTypeFuncation);
    {
        TLContactsItemModel *newModel = createContactsItemModelWithTag(TLContactsVCCellTypeNew, @"friends_new", nil, LOCSTR(@"新的朋友"), nil, nil);
        TLContactsItemModel *groupModel = createContactsItemModelWithTag(TLContactsVCCellTypeGroup, @"friends_group", nil, LOCSTR(@"群聊"), nil, nil);
        TLContactsItemModel *tagModel = createContactsItemModelWithTag(TLContactsVCCellTypeTag, @"friends_tag", nil, LOCSTR(@"标签"), nil, nil);
        TLContactsItemModel *publicModel = createContactsItemModelWithTag(TLContactsVCCellTypePublic, @"friends_public", nil, LOCSTR(@"公众号"), nil, nil);
        NSArray *funcationData = @[newModel, groupModel, tagModel, publicModel];
        self.addCells([TLContactsItemCell class]).toSection(TLContactsVCSectionTypeFuncation).withDataModelArray(funcationData).selectedAction(^ (TLContactsItemModel *model) {
            @strongify(self);
            UIViewController *vc = [[UIViewController alloc] init];
            [vc.view setBackgroundColor:[UIColor whiteColor]];
            [vc setTitle:model.title];
            [self tryPushVC:vc];
        });
    }
    // 企业
    self.addSection(TLContactsVCSectionTypeEnterprise);
    
    // 好友
    TLContactsItemModel *(^createContactsItemModelWithUserModel)(TLUser *userModel) = ^TLContactsItemModel *(TLUser *userModel){
        TLContactsItemModel *model = createContactsItemModel(userModel.avatar, nil, userModel.username, nil, userModel);
        return model;
    };
    for (TLUserGroup *group in contactsData) {
        NSInteger sectionTag = group.tag;
        self.addSection(sectionTag);
        self.setHeader([TLContactsHeaderView class]).toSection(sectionTag).withDataModel(group.groupName);
        
        NSMutableArray *data = [[NSMutableArray alloc]initWithCapacity:group.users.count];
        for (TLUser *user in group.users) {
            TLContactsItemModel *newModel = createContactsItemModelWithUserModel(user);
            [data addObject:newModel];
        }
        self.addCells([TLContactsItemCell class]).toSection(sectionTag).withDataModelArray(data).selectedAction(^ (TLContactsItemModel *data) {
            @strongify(self);
            TLUser *user = data.userInfo;
            UIViewController *vc = [[UIViewController alloc] init];
            [vc.view setBackgroundColor:[UIColor whiteColor]];
            [vc setTitle:user.username];
            [self tryPushVC:vc];
        });
    }
}

- (void)tryPushVC:(__kindof UIViewController *)vc
{
    if (self.pushAction) {
        self.pushAction(vc);
    }
}

#pragma mark - # Delegate
// 拼音首字母检索
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.sectionHeaders;
}

// 检索时空出搜索框
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if(index == 0) {
        [tableView scrollRectToVisible:CGRectMake(0, 0, tableView.width, tableView.height) animated:NO];
        return -1;
    }
    return index;
}

// 备注
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:indexPath.section];
    if (sectionModel.sectionTag != TLContactsVCSectionTypeFuncation && sectionModel.sectionTag != TLContactsVCSectionTypeEnterprise) {
        UITableViewRowAction *remarkAction;
        remarkAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal
                                                          title:@"备注"
                                                        handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                                            [TLUIUtility showSuccessHint:@"备注：暂未实现"];
                                                        }];
        return @[remarkAction];
    }
    return @[];
}

@end
