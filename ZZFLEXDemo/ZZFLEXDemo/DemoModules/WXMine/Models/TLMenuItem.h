//
//  TLMenuItem.h
//  TLChat
//
//  Created by 李伯坤 on 2017/7/17.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLMenuItem : NSObject

/**
 * 左侧图标路径
 */
@property (nonatomic, strong) NSString *iconName;

/**
 * 标题
 */
@property (nonatomic, strong) NSString *title;

/**
 * 左侧气泡
 */
@property (nonatomic, strong) NSString *badge;

/**
 * 副标题
 */
@property (nonatomic, strong) NSString *subTitle;


@property (nonatomic, assign, readonly) CGSize badgeSize;


@end

TLMenuItem *createMenuItem(NSString *icon, NSString *title);
