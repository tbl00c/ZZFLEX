//
//  TLToast.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/10.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLToast : NSObject

+ (void)showLoading:(NSString *)title;
+ (void)dismiss;
+ (BOOL)isVisible;

+ (void)showProgress:(CGFloat)progress;

+ (void)showSuccessToast:(NSString *)message;
+ (void)showErrorToast:(NSString *)message;
+ (void)showWarningToast:(NSString *)message;



@end
