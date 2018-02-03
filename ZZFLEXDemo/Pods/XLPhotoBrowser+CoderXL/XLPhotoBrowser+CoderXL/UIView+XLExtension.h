//
//  UIView+XLExtension.h
//  TopHot
//
//  Created by Liushannoon on 16/4/20.
//  Copyright © 2016年 Liushannoon. All rights reserved.
//

#import <UIKit/UIKit.h>

#define XLScreenBounds [UIScreen mainScreen].bounds
#define XLScreenSize [UIScreen mainScreen].bounds.size
#define XLScreenW [UIScreen mainScreen].bounds.size.width
#define XLScreenH [UIScreen mainScreen].bounds.size.height
#define xl_autoSizeScaleX ([UIScreen mainScreen].bounds.size.width / 375)
#define xl_autoSizeScaleY ([UIScreen mainScreen].bounds.size.height / 667)

#define XLDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)
#define XLKeyWindow [UIApplication sharedApplication].windows.firstObject

/**
 *  动画类型
 */
typedef NS_ENUM(NSUInteger, XLAnimationType){
    /**
     *  弹性动画放大
     */
    XLAnimationTypeToBigger = 1,
    /**
     *  缩小的弹性动画
     */
    XLAnimationTypeToSmaller = 2
};

@interface UIView (XLExtension)

@property (nonatomic, assign) CGFloat height XLDeprecated("请使用xl_height");
@property (nonatomic, assign) CGFloat width XLDeprecated("请使用xl_width");
@property (nonatomic, assign) CGFloat x  XLDeprecated("请使用xl_x");
@property (nonatomic, assign) CGFloat y XLDeprecated("请使用xl_y");
@property (nonatomic, assign) CGFloat centerX XLDeprecated("请使用xl_centerX");
@property (nonatomic, assign) CGFloat centerY XLDeprecated("请使用xl_centerY");

@property (nonatomic, assign) CGFloat xl_height;
@property (nonatomic, assign) CGFloat xl_width;
@property (nonatomic, assign) CGFloat xl_x;
@property (nonatomic, assign) CGFloat xl_y;
@property (nonatomic, assign) CGSize xl_size;
@property (nonatomic, assign) CGFloat xl_centerX;
@property (nonatomic, assign) CGFloat xl_centerY;

/**
 * 判断一个控件是否真正显示在主窗口
 */
- (BOOL)xl_isShowingOnKeyWindow;

/**
 *  加载xibview
 */
+ (instancetype)xl_viewFromXib ;

/**
 *  显示一个5*5点的红色提醒圆点
 *
 *  @param redX x坐标
 *  @param redY y坐标
 */
- (void)xl_showRedTipViewInRedX:(CGFloat)redX redY:(CGFloat)redY XLDeprecated("请使用其他同类方法");
/**
 *  在view上面绘制一个指定width宽度的红色提醒圆点
 *
 *  @param redX  x坐标
 *  @param redY  y坐标
 *  @param width 宽度
 */
- (void)xl_showRedTipViewInRedX:(CGFloat)redX redY:(CGFloat)redY redTipViewWidth:(CGFloat)width ;
/**
 *  在view上面绘制一个指定width宽度的 指定颜色的提醒圆点
 *
 *  @param redX  x坐标
 *  @param redY  y坐标
 *  @param width 圆点的直径
 *  @param backgroundColor 圆点的颜色
 */
- (void)xl_showRedTipViewInRedX:(CGFloat)redX redY:(CGFloat)redY redTipViewWidth:(CGFloat)width backgroundColor:(UIColor *)backgroundColor;
/**
 *  显示一个5*5点的红色提醒圆点
 *
 *  @param redX x坐标
 *  @param redY y坐标
 *  @param numberCount 展示的数字
 */
- (void)xl_showRedTipViewWithNumberCountInRedX:(CGFloat)redX redY:(CGFloat)redY numberCount:(NSInteger)numberCount;

/**
 *  隐藏红色提醒圆点
 */
- (void)xl_hideRedTipView;

/**
 *  类方法,对指定的layer进行弹性动画
 *
 *  @param layer 进行动画的图层
 *  @param type  动画类型
 */
+ (void)xl_showOscillatoryAnimationWithLayer:(CALayer *)layer type:(XLAnimationType)type;
/**
 *  给视图添加虚线边框
 *
 *  @param lineWidth  线宽
 *  @param lineMargin 每条虚线之间的间距
 *  @param lineLength 每条虚线的长度
 *  @param lineColor 每条虚线的颜色
 */
- (void)xl_addDottedLineBorderWithLineWidth:(CGFloat)lineWidth lineMargin:(CGFloat)lineMargin lineLength:(CGFloat)lineLength lineColor:(UIColor *)lineColor;

@end
