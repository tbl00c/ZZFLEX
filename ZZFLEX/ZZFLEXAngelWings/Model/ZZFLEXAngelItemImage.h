//
//  ZZFLEXAngelItemImage.h
//  Masonry
//
//  Created by 李伯坤 on 2020/2/4.
//

#import <Foundation/Foundation.h>

@interface ZZFLEXAngelItemImageStyle : NSObject

/// 大小
@property (nonatomic, assign) CGSize size;

/// 圆角
@property (nonatomic, strong) NSNumber *cornorRadius;

@end

@interface ZZFLEXAngelItemImage : NSObject

/// 设置方式1/3：直接设置image
@property (nonatomic, strong) UIImage *image;
/// 设置方式2/3：设置imageName
@property (nonatomic, strong) NSString *imageName;
/// 设置方式3/3：设置网络url
@property (nonatomic, strong) NSString *imageUrl;

@property (nonatomic, assign, readonly) BOOL enable;

@property (nonatomic, strong) ZZFLEXAngelItemImageStyle *style;

@end

static ZZFLEXAngelItemImage *zzflex_createAngelWebImage(NSString *imageUrl) {
    ZZFLEXAngelItemImage *item = [[ZZFLEXAngelItemImage alloc] init];
    item.imageUrl = imageUrl;
    return item;
}

static ZZFLEXAngelItemImage *zzflex_createAngelImage(NSString *imageName) {
    ZZFLEXAngelItemImage *item = [[ZZFLEXAngelItemImage alloc] init];
    item.imageName = imageName;
    return item;
}
