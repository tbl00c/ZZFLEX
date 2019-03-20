//
//  ZZFDAlbumModel.h
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2019/3/20.
//  Copyright © 2019 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface ZZFDAlbumModel : NSObject

@property (nonatomic, strong) PHAsset *asset;
@property (nonatomic, strong) UIImage *image;

- (instancetype)initWithPHAsset:(PHAsset *)asset;

+ (NSArray<ZZFDAlbumModel *> *)albumModelArrayByPHFetchResult:(PHFetchResult<PHAsset *> *)result;

- (void)requestImage:(void (^)(ZZFDAlbumModel *model, UIImage *image))imageAction;

@end

