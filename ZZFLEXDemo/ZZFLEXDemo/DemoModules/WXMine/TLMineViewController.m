//
//  TLMineViewController.m
//  TLChat
//
//  Created by 李伯坤 on 2017/7/6.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLMineViewController.h"
#import "TLMenuItemCell.h"
#import "TLMenuItem.h"
#import "TLUser.h"

typedef NS_ENUM(NSInteger, TLMineSectionTag) {
    TLMineSectionTagUserInfo,
    TLMineSectionTagWallet,
    TLMineSectionTagFounction,
    TLMineSectionTagSetting,
};

typedef NS_ENUM(NSInteger, TLMineCellTag) {
    TLMineCellTagUserInfo,
    TLMineCellTagWallet,
    TLMineCellTagCollect,
    TLMineCellTagAlbum,
    TLMineCellTagCard,
    TLMineCellTagExpression,
    TLMineCellTagSetting,
};

@interface TLMineViewController () <ZZFlexibleLayoutViewControllerProtocol>

@end

@implementation TLMineViewController

- (void)loadView
{
    [super loadView];

    [self.navigationItem setTitle:LOCSTR(@"我")];
    [self.view setBackgroundColor:[UIColor colorGrayBG]];

    [self loadMenus];
}

#pragma mark - # Private Methods
- (void)loadMenus
{
    [self clear];
    
    // 用户信息
    TLUser *user = [self defaultUser];
    self.addSection(TLMineSectionTagUserInfo).sectionInsets(UIEdgeInsetsMake(15, 0, 0, 0));
    self.addCell(@"TLMineHeaderCell").toSection(TLMineCellTagUserInfo).withDataModel(user).viewTag(TLMineCellTagUserInfo);
    
    NSString *mineMenuCellName = NSStringFromClass([TLMenuItemCell class]);
    
    // 钱包
    self.addSection(TLMineSectionTagWallet).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
    TLMenuItem *wallet = createMenuItem(@"mine_wallet", LOCSTR(@"钱包"));
    [wallet setBadge:@""];
    [wallet setSubTitle:@"新到账1024元"];
    self.addCell(mineMenuCellName).toSection(TLMineSectionTagWallet).withDataModel(wallet).viewTag(TLMineCellTagWallet);
    
    // 功能
    self.addSection(TLMineSectionTagFounction).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
    
    TLMenuItem *collect = createMenuItem(@"mine_favorites", LOCSTR(@"收藏"));
    self.addCell(mineMenuCellName).toSection(TLMineSectionTagFounction).withDataModel(collect).viewTag(TLMineCellTagCollect);
    TLMenuItem *album = createMenuItem(@"mine_album", LOCSTR(@"相册"));
    self.addCell(mineMenuCellName).toSection(TLMineSectionTagFounction).withDataModel(album).viewTag(TLMineCellTagAlbum);
    TLMenuItem *card = createMenuItem(@"mine_card", LOCSTR(@"卡包"));
    self.addCell(mineMenuCellName).toSection(TLMineSectionTagFounction).withDataModel(card).viewTag(TLMineCellTagCard);
    TLMenuItem *expression = createMenuItem(@"mine_expression", LOCSTR(@"表情"));
    [expression setBadge:@"NEW"];
    self.addCell(mineMenuCellName).toSection(TLMineSectionTagFounction).withDataModel(expression).viewTag(TLMineCellTagExpression);
    
    // 设置
    self.addSection(TLMineSectionTagSetting).sectionInsets(UIEdgeInsetsMake(20, 0, 30, 0));
    TLMenuItem *setting = createMenuItem(@"mine_setting", LOCSTR(@"设置"));
    self.addCell(mineMenuCellName).toSection(TLMineSectionTagSetting).withDataModel(setting).viewTag(TLMineCellTagSetting);
    
    [self reloadView];
}

#pragma mark - # Delegate
- (void)collectionViewDidSelectItem:(id)itemModel sectionTag:(NSInteger)sectionTag cellTag:(NSInteger)cellTag className:(NSString *)className indexPath:(NSIndexPath *)indexPath
{
    if (cellTag == TLMineCellTagUserInfo) {
        UIViewController *vc = [[UIViewController alloc] init];
        [vc setTitle:@"个人信息"];
        [vc.view setBackgroundColor:[UIColor whiteColor]];
        PushVC(vc);
    }
    else {
        TLMenuItem *item = itemModel;
        UIViewController *vc = [[UIViewController alloc] init];
        [vc setTitle:item.title];
        [vc.view setBackgroundColor:[UIColor whiteColor]];
        PushVC(vc);
        
        if (item.badge || item.subTitle) {
            item.badge = nil;
            item.subTitle = nil;
            [self reloadView];
        }
    }
    
}

#pragma mark - # Private
- (TLUser *)defaultUser
{
    TLUser *user = [[TLUser alloc] init];
    user.avatar = @"avatar";
    user.username = @"李伯坤";
    user.userID = @"li-bokun";
    return user;
}

@end
