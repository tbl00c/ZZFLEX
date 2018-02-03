//
//  FSActionSheetItem.m
//  FSActionSheet
//
//  Created by Steven on 16/5/11.
//  Copyright © 2016年 Steven. All rights reserved.
//

#import "FSActionSheetItem.h"

@implementation FSActionSheetItem

+ (instancetype)itemWithType:(FSActionSheetType)type image:(UIImage *)image title:(NSString *)title tintColor:(UIColor *)tintColor {
    
    FSActionSheetItem *item = [[FSActionSheetItem alloc] init];
    item.type  = type;
    item.image = image;
    item.title = title;
    item.tintColor = tintColor;
    
    return item;
}

@end
