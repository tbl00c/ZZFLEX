//
//  ZZFDAppDelegate.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/11/27.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFDAppDelegate.h"
#import "ZZFDMainViewController.h"
#import "TLFriendHelper.h"

@interface ZZFDAppDelegate ()

@end

@implementation ZZFDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
    ZZFDMainViewController *mainVC = [[ZZFDMainViewController alloc] init];
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:mainVC];
    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance *appearance = UINavigationBarAppearance.new;
        appearance.backgroundColor = [UIColor whiteColor];
        appearance.shadowImage = [UIImage new];
        navC.navigationBar.standardAppearance = appearance;
        navC.navigationBar.scrollEdgeAppearance = appearance;
    } else {
        navC.navigationBar.shadowImage = [UIImage new];
        navC.navigationBar.barTintColor = [UIColor whiteColor];
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setRootViewController:navC];
    [self.window addSubview:navC.view];
    [self.window makeKeyAndVisible];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [TLFriendHelper sharedFriendHelper];
    });
    
    return YES;
}

@end
