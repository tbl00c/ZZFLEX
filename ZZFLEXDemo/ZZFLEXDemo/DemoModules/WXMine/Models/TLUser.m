
//
//  TLUser.m
//  TLChat
//
//  Created by 李伯坤 on 16/1/23.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLUser.h"

@implementation TLUser

- (void)setUsername:(NSString *)username
{
    _username = username;
    _pinyin = username.pinyin;
    _pinyinInitial = username.pinyinInitial;
}

@end
