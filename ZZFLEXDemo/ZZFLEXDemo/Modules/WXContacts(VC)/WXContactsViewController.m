//
//  WXContactsViewController.m
//  ZZFLEXDemo
//
//  Created by libokun on 2020/3/19.
//  Copyright © 2020 李伯坤. All rights reserved.
//

#import "WXContactsViewController.h"
#import "TLFriendHelper.h"
#import "TLSearchController.h"
#import "TLContactsSearchResultViewController.h"
#import "WXUserViewController.h"
#import "TLUserGroup.h"
#import "TLContactsItemCell.h"
#import "ZZFLEXSectionModel.h"
#import "TLContactsHeaderView.h"

// 仅使用枚举定义
#import "TLContactsAngel.h"

@interface WXContactsViewController ()

/// 总好友数
@property (nonatomic, strong) UILabel *footerLabel;

/// 搜索
@property (nonatomic, strong) TLSearchController *searchController;

/// header
@property (nonatomic, strong) NSArray *sectionHeaders;

@end

@implementation WXContactsViewController

- (void)loadView
{
    [super loadView];
    [self setTitle:LOCSTR(@"通讯录")];
    
    self.tableView.zz_setup.backgroundColor([UIColor colorGrayBG]).separatorStyle(UITableViewCellSeparatorStyleNone)
    .tableHeaderView(self.searchController.searchBar).tableFooterView(self.footerLabel)
    .estimatedRowHeight(0).estimatedSectionFooterHeight(0).estimatedSectionHeaderHeight(0)
    .sectionIndexBackgroundColor([UIColor clearColor]).sectionIndexColor([UIColor darkGrayColor]);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 开始监听通讯录数据
    [self p_startMonitorContactsData];
}

#pragma mark - # Pirvate Methods
- (void)p_startMonitorContactsData
{
    [self resetListWithContactsData:[TLFriendHelper sharedFriendHelper].data sectionHeaders:[TLFriendHelper sharedFriendHelper].sectionHeaders];
    [self.footerLabel setText:[NSString stringWithFormat:@"%ld%@", (long)[TLFriendHelper sharedFriendHelper].friendCount, LOCSTR(@"位联系人")]];
    [self.tableView reloadData];
    
    @weakify(self);
    [[TLFriendHelper sharedFriendHelper] setDataChangedBlock:^(NSMutableArray *data, NSMutableArray *headers, NSInteger friendCount) {
        @strongify(self);
        [self resetListWithContactsData:[TLFriendHelper sharedFriendHelper].data sectionHeaders:[TLFriendHelper sharedFriendHelper].sectionHeaders];
        [self.footerLabel setText:[NSString stringWithFormat:@"%ld%@", (long)friendCount, LOCSTR(@"位联系人")]];
        [self.tableView reloadData];
    }];
}

- (void)resetListWithContactsData:(NSArray *)contactsData sectionHeaders:(NSArray *)sectionHeaders
{
    self.sectionHeaders = sectionHeaders;
    
    @weakify(self);
    self.clear();
    
    self.view.addButton(1001).title(@"title").image([UIImage imageNamed:@"asdfadf"])
    .frame(CGRectMake(0, 0, 100, 100))
    .imageHL([UIImage imageNamed:@"imageHL"]);
    
    
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
            [self.navigationController pushViewController:vc animated:YES];
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
            TLUser *userModel = data.userInfo;
            WXUserViewController *vc = [[WXUserViewController alloc] initWithUserModel:userModel];
            [self.navigationController pushViewController:vc animated:YES];
        });
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
    if (indexPath.section > self.data.count - 1) {
        return @[];
    }
    ZZFLEXSectionModel *sectionModel = [self.data objectAtIndex:indexPath.section];
    if (sectionModel.sectionTag != TLContactsVCSectionTypeFuncation && sectionModel.sectionTag != TLContactsVCSectionTypeEnterprise) {
        UITableViewRowAction *remarkAction;
        remarkAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal
                                                          title:@"备注"
                                                        handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                                            [TLToast showSuccessToast:@"备注：暂未实现"];
                                                        }];
        return @[remarkAction];
    }
    return @[];
}


#pragma mark - # Getters
- (TLSearchController *)searchController
{
    if (_searchController == nil) {
        TLContactsSearchResultViewController *resultVC = [[TLContactsSearchResultViewController alloc] init];
        @weakify(self);
        [resultVC setItemSelectedAction:^(TLContactsSearchResultViewController *searchVC, TLUser *userModel) {
            @strongify(self);
            [self.searchController setActive:NO];
            WXUserViewController *detailVC = [[WXUserViewController alloc] initWithUserModel:userModel];
            PushVC(detailVC);
        }];
        _searchController = [TLSearchController createWithResultVC:resultVC];
    }
    return _searchController;
}

- (UILabel *)footerLabel
{
    if (_footerLabel == nil) {
        _footerLabel= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50.0f)];
        _footerLabel.zz_setup.textAlignment(NSTextAlignmentCenter).font([UIFont systemFontOfSize:17.0f]).textColor([UIColor grayColor]);
    }
    return _footerLabel;
}


@end
