//
//  TLFriendHelper.m
//  TLChat
//
//  Created by 李伯坤 on 16/1/27.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLFriendHelper.h"

@implementation TLFriendHelper

+ (TLFriendHelper *)sharedFriendHelper
{
    static TLFriendHelper *friendHelper;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        friendHelper = [[TLFriendHelper alloc] init];
    });
    return friendHelper;
}

- (id)init
{
    if (self = [super init]) {
        // 初始化好友数据
        _friendsData = [[NSMutableArray alloc] init];
        self.data = [[NSMutableArray alloc] init];
        self.sectionHeaders = [[NSMutableArray alloc] initWithObjects:UITableViewIndexSearch, nil];
        [self p_initTestData];
    }
    return self;
}

#pragma mark - # Private Methods
- (void)p_resetFriendData
{
    // 1、排序
    NSArray *serializeArray = [self.friendsData sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        int i;
        NSString *strA = ((TLUser *)obj1).pinyin;
        NSString *strB = ((TLUser *)obj2).pinyin;
        for (i = 0; i < strA.length && i < strB.length; i ++) {
            char a = toupper([strA characterAtIndex:i]);
            char b = toupper([strB characterAtIndex:i]);
            if (a > b) {
                return (NSComparisonResult)NSOrderedDescending;
            }
            else if (a < b) {
                return (NSComparisonResult)NSOrderedAscending;
            }
        }
        if (strA.length > strB.length) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        else if (strA.length < strB.length){
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    // 2、分组
    NSMutableArray *ansData = [[NSMutableArray alloc] init];
    NSMutableArray *ansSectionHeaders = [[NSMutableArray alloc] initWithObjects:UITableViewIndexSearch, nil];
    char lastC = '1';
    TLUserGroup *curGroup;
    TLUserGroup *othGroup = [[TLUserGroup alloc] init];
    [othGroup setGroupName:@"#"];
    [othGroup setTag:27];
    for (TLUser *user in serializeArray) {
        // 获取拼音失败
        if (user.pinyin == nil || user.pinyin.length == 0) {
            [othGroup addObject:user];
            continue;
        }
        
        char c = toupper([user.pinyin characterAtIndex:0]);
        if (!isalpha(c)) {      // #组
            [othGroup addObject:user];
        }
        else if (c != lastC){
            if (curGroup && curGroup.count > 0) {
                [ansData addObject:curGroup];
                [ansSectionHeaders addObject:curGroup.groupName];
            }
            lastC = c;
            curGroup = [[TLUserGroup alloc] init];
            [curGroup setGroupName:[NSString stringWithFormat:@"%c", c]];
            [curGroup addObject:user];
            [curGroup setTag:(NSInteger)c];
        }
        else {
            [curGroup addObject:user];
        }
    }
    if (curGroup && curGroup.count > 0) {
        [ansData addObject:curGroup];
        [ansSectionHeaders addObject:curGroup.groupName];
    }
    if (othGroup.count > 0) {
        [ansData addObject:othGroup];
        [ansSectionHeaders addObject:othGroup.groupName];
    }
    
    [self.data removeAllObjects];
    [self.data addObjectsFromArray:ansData];
    [self.sectionHeaders removeAllObjects];
    [self.sectionHeaders addObjectsFromArray:ansSectionHeaders];
    if (self.dataChangedBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.dataChangedBlock(self.data, self.sectionHeaders, self.friendCount);
        });
    }
}

- (void)p_initTestData
{
    // 好友数据
    NSArray *nameData = @[@"曾小贤", @"胡一菲", @"吕子乔", @"陈美嘉", @"唐悠悠", @"关谷神奇", @"林宛瑜", @"陆展博", @"张伟", @"秦羽墨", @"诺澜"];
    NSMutableArray *data = [[NSMutableArray alloc] init];
    for (NSString *name in nameData) {
        TLUser *user = [[TLUser alloc] init];
        user.username = name;
        user.avatar = name;
        [data addObject:user];
    }
    
    [self.friendsData removeAllObjects];
    [self.friendsData addObjectsFromArray:data];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self p_resetFriendData];
    });
}

#pragma mark - # Getters
- (NSInteger)friendCount
{
    return self.friendsData.count;
}

@end
