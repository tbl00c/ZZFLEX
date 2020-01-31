
//
//  TLToast.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/10.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLToast.h"
#import <SVProgressHUD/SVProgressHUD.h>

static UILabel *hLabel = nil;

@implementation TLToast
+ (void)initialize
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
    [SVProgressHUD setMinimumSize:CGSizeMake(110, 110)];
    [SVProgressHUD setMinimumDismissTimeInterval:1.0f];
}

#pragma mark - # HUD
+ (void)showLoading:(NSString *)hintText
{
    [SVProgressHUD showWithStatus:hintText];
}

+ (void)dismiss
{
    [SVProgressHUD dismissWithCompletion:nil];
}

+ (BOOL)isVisible
{
    return [SVProgressHUD isVisible];
}

+ (void)showProgress:(CGFloat)progress
{
    [SVProgressHUD showProgress:progress];
}

+ (void)showSuccessToast:(NSString *)message
{
    [SVProgressHUD showSuccessWithStatus:message];
}

+ (void)showErrorToast:(NSString *)message
{
    [SVProgressHUD showErrorWithStatus:message];
}

+ (void)showWarningToast:(NSString *)message
{
    [SVProgressHUD showInfoWithStatus:message];
}

@end
