//
//  TLContactsSearchResultViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/1/25.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLContactsSearchResultViewController.h"
#import "ZZFLEX.h"
#import "TLContactsItemCell.h"
#import "TLFriendHelper.h"
#import "TLContactsHeaderView.h"

@interface TLContactsSearchResultViewController ()

@property (nonatomic, strong) ZZFLEXAngel *tableViewAngel;

@property (nonatomic, strong) NSMutableArray *friendsData;

@end

@implementation TLContactsSearchResultViewController

- (void)loadView
{
    [super loadView];
    
    self.tableView.zz_setup.backgroundColor([UIColor colorGrayBG])
    .separatorStyle(UITableViewCellSeparatorStyleNone).tableFooterView([UIView new])
    .estimatedRowHeight(0).estimatedSectionFooterHeight(0).estimatedSectionHeaderHeight(0);
    
    self.tableViewAngel = [[ZZFLEXAngel alloc] initWithHostView:self.tableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.friendsData = [TLFriendHelper sharedFriendHelper].friendsData;
}

//MARK: UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    TLContactsItemModel *(^createContactsItemModelWithUserModel)(TLUser *userModel) = ^TLContactsItemModel *(TLUser *userModel){
        TLContactsItemModel *model = createContactsItemModel(userModel.avatar, nil, userModel.username, nil, userModel);
        return model;
    };
    
    // 查找数据
    NSString *searchText = [searchController.searchBar.text lowercaseString];
    NSMutableArray *data = [[NSMutableArray alloc] init];
    for (TLUser *user in self.friendsData) {
        if ([user.username containsString:searchText] || [user.pinyin containsString:searchText] || [user.pinyinInitial containsString:searchText]) {
            TLContactsItemModel *model = createContactsItemModelWithUserModel(user);
            [data addObject:model];
        }
    }
    
    // 更新UI
    self.tableViewAngel.clear();
    if (data.count > 0) {
        self.tableViewAngel.addSection(0);
        self.tableViewAngel.setHeader([TLContactsHeaderView class]).toSection(0).withDataModel(@"联系人");
        self.tableViewAngel.addCells([TLContactsItemCell class]).toSection(0).withDataModelArray(data).selectedAction(^ (TLContactsItemModel *model) {
            if (self.itemSelectedAction) {
                self.itemSelectedAction(self, model.userInfo);
            }
        });
    }
    [self.tableView reloadData];
}

//MARK: UISearchBarDelegate
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar
{
    [TLAlertView showWithTitle:@"语音搜索按钮" message:nil];
}

@end
