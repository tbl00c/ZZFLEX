//
//  ZZFDGoodListModel.h
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/11/28.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZZFDGoodParamModel;
@class ZZFDGoodCommitModel;

ZZFDGoodCommitModel *createCommitModel(NSString *name, NSString *avatar, NSString *date, NSString *detail);

@interface ZZFDGoodListModel : NSObject <NSMutableCopying>

@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *position;
@property (nonatomic, strong) NSString *lastLoginIn;

@property (nonatomic, strong) NSString *goodId;
@property (nonatomic, strong) NSString *goodTitle;
@property (nonatomic, strong) NSString *goodDetail;
@property (nonatomic, strong, readonly) NSAttributedString *attrGoodDetail;
@property (nonatomic, strong) NSString *goodFirstImage;
@property (nonatomic, strong) NSArray *goodImages;
@property (nonatomic, strong) NSString *price;

@property (nonatomic, strong) NSArray<ZZFDGoodParamModel *> *params;

@property (nonatomic, strong) NSString *readCount;

@property (nonatomic, assign) NSInteger goodCount;
@property (nonatomic, assign) NSInteger tradeCount;
@property (nonatomic, assign) NSInteger commitCount;
@property (nonatomic, assign) NSInteger zhimaCount;

@property (nonatomic, strong) NSAttributedString *attrGood;
@property (nonatomic, strong) NSAttributedString *attrTrade;
@property (nonatomic, strong) NSAttributedString *attrCommit;
@property (nonatomic, strong) NSAttributedString *attrZhima;

@property (nonatomic, strong) NSMutableArray<ZZFDGoodCommitModel *> *commitData;

@property (nonatomic, strong, readonly) NSAttributedString *attrPrice;

+ (void)requestHomePageDataWithOffset:(NSInteger)offset
                              success:(void (^)(NSArray *data))success
                              failure:(void (^)(NSString *errMsg))failure;

@end

@interface ZZFDGoodParamModel : NSObject

@property (nonatomic, strong) NSString *key;

@property (nonatomic, strong) NSString *value;

@end

@interface ZZFDGoodCommitModel : NSObject

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *date;

@property (nonatomic, strong) NSString *detail;

@end
