//
//  FSActionSheetConfig.h
//  FSActionSheet
//
//  Created by Steven on 6/7/16.
//  Copyright © 2016 Steven. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

// 选择选项block回调
typedef void(^FSActionSheetHandler)(NSInteger selectedIndex);

// 选项类型枚举
typedef NS_ENUM(NSInteger, FSActionSheetType) {
    FSActionSheetTypeNormal = 0,    // 正常状态
    FSActionSheetTypeHighlighted,   // 高亮状态
};

// 内容偏移枚举
typedef NS_ENUM(NSInteger, FSContentAlignment) {
    FSContentAlignmentLeft = 0,     // 内容紧靠左边
    FSContentAlignmentCenter,       // 内容居中
    FSContentAlignmentRight,        // 内容紧靠右边
};


// float
UIKIT_EXTERN CGFloat const FSActionSheetDefaultMargin; ///< 默认边距 (标题四边边距, 选项靠左或靠右时距离边缘的距离), default is 10.
UIKIT_EXTERN CGFloat const FSActionSheetContentMaxScale; ///< 弹窗内容高度与屏幕高度的默认比例, default is 0.65.
UIKIT_EXTERN CGFloat const FSActionSheetRowHeight; ///< 行高, default is 44.
UIKIT_EXTERN CGFloat const FSActionSheetTitleLineSpacing; ///< 标题行距, default is 2.5.
UIKIT_EXTERN CGFloat const FSActionSheetTitleKernSpacing; ///< 标题字距, default is 0.5.
UIKIT_EXTERN CGFloat const FSActionSheetItemTitleFontSize; ///< 选项文字字体大小, default is 16.
UIKIT_EXTERN CGFloat const FSActionSheetItemContentSpacing; ///< 选项图片和文字的间距, default is 5.
// color
UIKIT_EXTERN NSString * const FSActionSheetTitleColor; ///< 标题颜色, default is #888888
UIKIT_EXTERN NSString * const FSActionSheetBackColor; ///< 背景颜色, default is #E8E8ED
UIKIT_EXTERN NSString * const FSActionSheetRowNormalColor; ///< 单元格背景颜色, default is #FBFBFE
UIKIT_EXTERN NSString * const FSActionSheetRowHighlightedColor; ///< 选中高亮颜色, default is #F1F1F5
UIKIT_EXTERN NSString * const FSActionSheetRowTopLineColor; ///< 单元格顶部线条颜色, default is #D7D7D8
UIKIT_EXTERN NSString * const FSActionSheetItemNormalColor; ///< 选项默认颜色, default is #000000
UIKIT_EXTERN NSString * const FSActionSheetItemHighlightedColor; ///< 选项高亮颜色, default is #E64340

/*! @brief 将十六进制颜色值字符串转化为对应颜色
 *  @param aColorString 十六进制颜色字符串
 */
NS_INLINE UIColor *FSActionSheetColorWithString(NSString *aColorString) {
    if (aColorString.length == 0) {
        return nil;
    }
    
    if ([aColorString hasPrefix:@"#"]) {
        aColorString = [aColorString substringFromIndex:1];
    }
    
    if (aColorString.length == 6) {
        int len = (int)aColorString.length/3;
        unsigned int a[3];
        for (int i=0; i<3; i++) {
            NSRange range;
            range.location = i*len;
            range.length = len;
            NSString *str = [aColorString substringWithRange:range];
            [[NSScanner scannerWithString:str] scanHexInt:a+i];
            if (len == 1) {
                a[i] *= 17;
            }
        }
        return [UIColor colorWithRed:a[0]/255.0f green:a[1]/255.0f blue:a[2]/255.0f alpha:1];
    }
    else if (aColorString.length == 8) {
        int len = (int)aColorString.length/4;
        unsigned int a[4];
        for (int i=0; i<4; i++) {
            NSRange range;
            range.location = i*len;
            range.length = len;
            NSString *str = [aColorString substringWithRange:range];
            [[NSScanner scannerWithString:str] scanHexInt:a+i];
            if (len == 1) {
                a[i] *= 17;
            }
        }
        return [UIColor colorWithRed:a[0]/255.0f green:a[1]/255.0f blue:a[2]/255.0f alpha:a[3]/255.0f];
    }
    else if (aColorString.length <= 2) {
        unsigned int gray;
        [[NSScanner scannerWithString:aColorString] scanHexInt:&gray];
        if (aColorString.length == 1)
        {
            gray *= 17;
        }
        return [UIColor colorWithWhite:gray/255.0f alpha:1];
    }
    
    return nil;
}



