//
//  FSActionSheetItem.h
//  FSActionSheet
//
//  Created by Steven on 16/5/11.
//  Copyright © 2016年 Steven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSActionSheetConfig.h"

@interface FSActionSheetItem : NSObject

@property (nonatomic, assign) FSActionSheetType type; ///< 选项类型, 有 默认 和 高亮 两种类型.
@property (nonatomic, strong) UIImage  *image; ///< 选项图标, 建议image的size为 @2x: 46x46, @3x: 69x69.
@property (nonatomic, copy)   NSString *title; ///< 选项标题
@property (nonatomic, strong) UIColor  *tintColor; ///< 选项前景色, 如果设置了这个颜色的话, 则无论选项设置的图标是什么颜色都会被修改为当前设置的这个颜色,
                                                   ///< 同时这个颜色也会是标题的文本颜色.

+ (instancetype)itemWithType:(FSActionSheetType)type image:(UIImage *)image title:(NSString *)title tintColor:(UIColor *)tintColor;

@end

/*! @author Steven
 *  @brief 单标题的选项
 *  @param type  类型
 *  @param title 标题
 */
NS_INLINE FSActionSheetItem *FSActionSheetTitleItemMake(FSActionSheetType type, NSString *title) {
    return [FSActionSheetItem itemWithType:type image:nil title:title tintColor:nil];
}

/*! @author Steven
 *  @brief 标题和图标的选项
 *  @param type  类型
 *  @param image 图片
 *  @param title 标题
 */
NS_INLINE FSActionSheetItem *FSActionSheetTitleWithImageItemMake(FSActionSheetType type, UIImage *image, NSString *title) {
    return [FSActionSheetItem itemWithType:type image:image title:title tintColor:nil];
}

/*! @author Steven
 *  @brief 单标题且自定义前景色的选项
 *  @param type  类型
 *  @param title 标题
 *  @param tintColor 自定义前景色
 */
NS_INLINE FSActionSheetItem *FSActionSheetTitleWithColorItemMake(FSActionSheetType type, NSString *title, UIColor *tintColor) {
    return [FSActionSheetItem itemWithType:type image:nil title:title tintColor:tintColor];
}

/*! @author Steven
 *  @brief 标题和图片并且自定义前景色的选项
 *  @param type  类型
 *  @param title 标题
 *  @param image 图片
 *  @param tintColor 自定义前景色
 */
NS_INLINE FSActionSheetItem *FSActionSheetItemMake(FSActionSheetType type, UIImage *image, NSString *title, UIColor *tintColor) {
    return [FSActionSheetItem itemWithType:type image:image title:title tintColor:tintColor];
}


