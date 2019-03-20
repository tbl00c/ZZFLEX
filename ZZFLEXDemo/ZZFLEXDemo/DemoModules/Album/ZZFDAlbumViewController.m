//
//  ZZFDAlbumViewController.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2019/3/20.
//  Copyright © 2019 李伯坤. All rights reserved.
//

#import "ZZFDAlbumViewController.h"
#import <Photos/Photos.h>
#import <XLPhotoBrowser+CoderXL/XLPhotoBrowser.h>

#import "ZZFDAlbumModel.h"
#import "ZZFDAlbumCell.h"

@implementation ZZFDAlbumViewController

- (void)loadView
{
    [super loadView];
    [self setTitle:@"相册"];
    [self.view setBackgroundColor:[UIColor colorGrayBG]];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self requestAlbumInfo];
}

- (void)requestAlbumInfo
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (status == PHAuthorizationStatusAuthorized) {
                PHFetchOptions *options = [[PHFetchOptions alloc] init];
                [options setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]]];
                PHFetchResult<PHAsset *> *result = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:options];
                [self loadListWithData:result];
            }
            else {
                [TLUIUtility showAlertWithTitle:@"未获取到相册权限" message:@"请在设置/ZZFLEXDemo/照片-允许访问照片" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] actionHandler:^(NSInteger buttonIndex) {
                    if (buttonIndex == 1) {
                        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestAlbumInfo) name:UIApplicationWillEnterForegroundNotification object:nil];
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                    }
                }];
            }
        });
    }];
}

- (void)loadListWithData:(PHFetchResult<PHAsset *> *)assetData
{
    self.clear();
    
    if (assetData.count == 0) {
        [self reloadView];
        return;
    }
    
    NSArray *data = [ZZFDAlbumModel albumModelArrayByPHFetchResult:assetData];
    
    NSInteger lineCount = 4;
    CGFloat space = 2;
    CGFloat itemWidth = (SCREEN_WIDTH - space * (lineCount + 1)) / lineCount;
    
    NSInteger sectionType = 0;
    self.addSection(sectionType).sectionInsets(UIEdgeInsetsMake(space, space, space, space)).minimumLineSpacing(space).minimumInteritemSpacing(space);
    self.addCells(@"ZZFDAlbumCell").toSection(sectionType).withDataModelArray(data)
    .configAction(^(ZZFDAlbumCell *cell, ZZFDAlbumModel *model) {   // 配置cell，等价于cellForRowAtIndexPath时的配置逻辑
        [cell setModel:model];
    })
    .viewSize(CGSizeMake(itemWidth, itemWidth))         // 设置大小
    .selectedAction(^ (ZZFDAlbumModel *model) {         // 点击事件，等价于didSelectRowAtIndexPath时的逻辑
        [XLPhotoBrowser showPhotoBrowserWithImages:@[model.image] currentImageIndex:0];
    });
    [self reloadView];
}

@end
