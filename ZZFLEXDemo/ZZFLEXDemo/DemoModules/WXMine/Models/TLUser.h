//
//  TLUser.h
//  TLChat
//
//  Created by 李伯坤 on 16/1/23.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLUser : NSObject

/// 用户ID
@property (nonatomic, strong) NSString *userID;

/// 用户名
@property (nonatomic, strong) NSString *username;

/// 昵称
@property (nonatomic, strong) NSString *nikeName;

/// 头像
@property (nonatomic, strong) NSString *avatar;

/// 备注名
@property (nonatomic, strong) NSString *remarkName;

@end
