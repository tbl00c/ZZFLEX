//
//  ZZFDGoodListModel.h
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/11/28.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZFDGoodListModel : NSObject

@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *position;
@property (nonatomic, strong) NSString *lastLoginIn;

@property (nonatomic, strong) NSString *goodId;
@property (nonatomic, strong) NSString *goodTitle;
@property (nonatomic, strong) NSString *goodFirstImage;
@property (nonatomic, strong) NSArray *goodImages;
@property (nonatomic, strong) NSString *price;

+ (void)requestHomePageDataWithOffset:(NSInteger)offset
                              success:(void (^)(NSArray *data))success
                              failure:(void (^)(NSString *errMsg))failure;

@end
