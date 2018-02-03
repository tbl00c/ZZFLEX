//
//  UIImage+XLExtension.m
//  XLPhotoBrowserDemo
//
//  Created by ehang on 2016/10/26.
//  Copyright © 2016年 LiuShannoon. All rights reserved.
//

#import "UIImage+XLExtension.h"

@implementation UIImage (XLExtension)

/**
 *  返回一张指定size的指定颜色的纯色图片
 */
+ (UIImage *)xl_imageWithColor:(UIColor *)color size:(CGSize)size
{
    if (size.width <= 0  ) {
        size = CGSizeMake(3, 3);
    }
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
