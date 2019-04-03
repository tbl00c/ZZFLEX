//
//  ZZFDCateModel.h
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/12/19.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZZFDCateSectionModel;
@interface ZZFDCateModel : NSObject

@property (nonatomic, strong) NSString *cateName;

@property (nonatomic, strong) NSArray<ZZFDCateSectionModel *> *cateSectionItems;

@property (nonatomic, assign) BOOL selected;

+ (void)requestCateModelSuccess:(void (^)(NSArray<ZZFDCateModel *> *data))success
                        failure:(void (^)(NSString *errMsg))failure;

@end


@class ZZFDCateItemModel;
@interface ZZFDCateSectionModel : NSObject

@property (nonatomic, strong) NSString *sectionName;

@property (nonatomic, strong) NSArray<ZZFDCateItemModel *> *cateSectionItems;

@end


@interface ZZFDCateItemModel : NSObject

@property (nonatomic, strong) NSString *itemName;

@property (nonatomic, strong) NSString *itemImageName;

@end
