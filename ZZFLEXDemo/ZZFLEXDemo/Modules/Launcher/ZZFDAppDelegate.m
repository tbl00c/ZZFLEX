//
//  ZZFDAppDelegate.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/11/27.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFDAppDelegate.h"
#import "TLFriendHelper.h"

@implementation ZZFDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [TLFriendHelper sharedFriendHelper];
    });
    
    return YES;
}

@end
