//
//  TLFriendHelper.h
//  TLChat
//
//  Created by 李伯坤 on 16/1/27.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLUserGroup.h"

@interface TLFriendHelper : NSObject

/// 好友数据(原始)
@property (nonatomic, strong, readonly) NSMutableArray *friendsData;

/// 格式化的好友数据（二维数组，列表用）
@property (nonatomic, strong) NSMutableArray *data;

/// 格式化好友数据的分组标题
@property (nonatomic, strong) NSMutableArray *sectionHeaders;

/// 好友数量
@property (nonatomic, assign, readonly) NSInteger friendCount;


@property (nonatomic, strong) void(^dataChangedBlock)(NSMutableArray *friends, NSMutableArray *headers, NSInteger friendCount);


+ (TLFriendHelper *)sharedFriendHelper;


@end
