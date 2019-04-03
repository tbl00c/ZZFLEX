//
//  ZZFDAlbumModel.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2019/3/20.
//  Copyright © 2019 李伯坤. All rights reserved.
//

#import "ZZFDAlbumModel.h"

@implementation ZZFDAlbumModel

+ (NSArray<ZZFDAlbumModel *> *)albumModelArrayByPHFetchResult:(PHFetchResult<PHAsset *> *)result
{
    NSMutableArray *data = [[NSMutableArray alloc] init];
    for (PHAsset *asset in result) {
        ZZFDAlbumModel *model = [[ZZFDAlbumModel alloc] initWithPHAsset:asset];
        [data addObject:model];
    }
    return data;
}

- (instancetype)initWithPHAsset:(PHAsset *)asset
{
    if (self = [super init]) {
        _asset = asset;
        
    }
    return self;
}

- (void)requestImage:(void (^)(ZZFDAlbumModel *model, UIImage *image))imageAction
{
    if (self.image) {
        if (imageAction) {
            imageAction(self, self.image);
        }
    }
    else {
        PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc]init];
        options.version = PHVideoRequestOptionsVersionCurrent;
        options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
        options.networkAccessAllowed = NO;
        [[PHImageManager defaultManager] requestImageForAsset:self.asset targetSize:CGSizeMake(SCREEN_WIDTH / 2, SCREEN_WIDTH / 2) contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage *result, NSDictionary *info) {
            self.image = result;
            if (imageAction) {
                imageAction(self, self.image);
            }
        }];
    }
}

@end
