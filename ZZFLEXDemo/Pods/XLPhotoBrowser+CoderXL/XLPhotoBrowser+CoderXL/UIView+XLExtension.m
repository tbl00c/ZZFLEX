//
//  UIView+XLExtension.m
//  TopHot
//
//  Created by Liushannoon on 16/4/20.
//  Copyright © 2016年 Liushannoon. All rights reserved.
//

#import "UIView+XLExtension.h"
#import <objc/runtime.h>

@implementation UIView (XLExtension)

#pragma mark    -   // 添加一个红点属性

static char RedTipViewKey;

- (UILabel *)redTipView
{
    return objc_getAssociatedObject(self,&RedTipViewKey);
}

- (void)setRedTipView:(UILabel *)redTipView
{
    objc_setAssociatedObject(self, &RedTipViewKey, redTipView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/**
 *  显示一个5*5点的红色提醒圆点
 *
 *  @param redX x坐标
 *  @param redY y坐标
 */
- (void)xl_showRedTipViewInRedX:(CGFloat)redX redY:(CGFloat)redY
{
    [self xl_showRedTipViewInRedX:redX redY:redY redTipViewWidth:5];
}

/**
 *  在view上面绘制一个指定width宽度的红色提醒远点
 *
 *  @param redX  x坐标
 *  @param redY  y坐标
 *  @param width 宽度
 */
- (void)xl_showRedTipViewInRedX:(CGFloat)redX redY:(CGFloat)redY redTipViewWidth:(CGFloat)width
{
    [self xl_showRedTipViewInRedX:redX redY:redY redTipViewWidth:width backgroundColor:[UIColor redColor]];
}

/**
 *  在view上面绘制一个指定width宽度的 指定颜色的提醒圆点
 *
 *  @param redX  x坐标
 *  @param redY  y坐标
 *  @param width 圆点的直径
 *  @param backgroundColor 圆点的颜色
 */
- (void)xl_showRedTipViewInRedX:(CGFloat)redX redY:(CGFloat)redY redTipViewWidth:(CGFloat)width backgroundColor:(UIColor *)backgroundColor
{
    if (!self.redTipView) {
        self.redTipView = [[UILabel alloc] init];
        self.redTipView.backgroundColor = backgroundColor;
        self.redTipView.xl_width = width;
        self.redTipView.xl_height = width;
        self.redTipView.layer.cornerRadius = self.redTipView.xl_height * 0.5;
        self.redTipView.layer.masksToBounds = YES;
        [self insertSubview:self.redTipView atIndex:self.subviews.count];
    }
    [self bringSubviewToFront:self.redTipView];
    self.redTipView.xl_x = redX;
    self.redTipView.xl_y = redY;
    self.redTipView.hidden = NO;
}

/**
 *  显示一个5*5点的红色提醒圆点
 *
 *  @param redX x坐标
 *  @param redY y坐标
 *  @param numberCount 展示的数字
 */
- (void)xl_showRedTipViewWithNumberCountInRedX:(CGFloat)redX redY:(CGFloat)redY numberCount:(NSInteger)numberCount
{
    if (!self.redTipView) {
        self.redTipView = [[UILabel alloc] init];
        self.redTipView.backgroundColor = [UIColor redColor];
    }
    self.redTipView.xl_x = redX;
    self.redTipView.xl_y = redY;
    self.redTipView.text = [NSString stringWithFormat:@"%zd",numberCount];
    self.redTipView.textAlignment = NSTextAlignmentCenter;
    self.redTipView.textColor = [UIColor whiteColor];
    self.redTipView.font = [UIFont systemFontOfSize:13];
    [self.redTipView sizeToFit];
    self.redTipView.xl_width += 8.5;
    self.redTipView.layer.cornerRadius = self.redTipView.xl_height * 0.5;
    self.redTipView.layer.masksToBounds = YES;
    [self insertSubview:self.redTipView atIndex:self.subviews.count];
    self.redTipView.hidden = NO;
}

/**
 *  隐藏红色提醒圆点
 */
- (void)xl_hideRedTipView
{
    self.redTipView.hidden = YES;
}


#pragma mark    -   计算frame

- (CGSize)xl_size
{
    return self.frame.size;
}

- (void)setXl_size:(CGSize)xl_size
{
    CGRect frame = self.frame;
    frame.size = xl_size;
    self.frame = frame;
}

- (CGFloat)xl_width
{
    return self.frame.size.width;
}

- (void)setXl_width:(CGFloat)xl_width
{
    CGRect rect = self.frame;
    rect.size.width = xl_width;
    self.frame = rect;
}

- (CGFloat)xl_height
{
    return self.frame.size.height;
}

- (void)setXl_height:(CGFloat)xl_height
{
    CGRect rect = self.frame;
    rect.size.height = xl_height;
    self.frame = rect;
}

- (CGFloat)xl_x
{
    return self.frame.origin.x;
}

- (void)setXl_x:(CGFloat)xl_x
{
    CGRect rect = self.frame;
    rect.origin.x = xl_x;
    self.frame = rect;
}

- (CGFloat)xl_y
{
    return self.frame.origin.y;
}

- (void)setXl_y:(CGFloat)xl_y
{
    CGRect rect = self.frame;
    rect.origin.y = xl_y;
    self.frame = rect;
}

- (CGFloat)xl_centerX
{
    return self.center.x;
}

- (void)setXl_centerX:(CGFloat)xl_centerX
{
    CGPoint point = self.center;
    point.x = xl_centerX;
    self.center = point;
}

- (CGFloat)xl_centerY
{
    return self.center.y;
}

- (void)setXl_centerY:(CGFloat)xl_centerY
{
    CGPoint point = self.center;
    point.y = xl_centerY;
    self.center = point;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x
{
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y
{
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint point = self.center;
    point.x = centerX;
    self.center = point;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint point = self.center;
    point.y = centerY;
    self.center = point;
}

/**
 *  判断是否在窗口上面
 */
- (BOOL)xl_isShowingOnKeyWindow
{
    // 主窗口
    UIWindow *keyWindow = XLKeyWindow;
    
    // 以主窗口左上角为坐标原点, 计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect winBounds = keyWindow.bounds;
    
    // 主窗口的bounds 和 self的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    
    return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && intersects;
}

+ (instancetype)xl_viewFromXib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

/**
 *  对指定的layer进行弹性动画
 *
 *  @param layer 进行动画的图层
 *  @param type  动画类型
 */
+ (void)xl_showOscillatoryAnimationWithLayer:(CALayer *)layer type:(XLAnimationType)type
{
    NSNumber *animationScale1 = type == XLAnimationTypeToBigger ? @(1.15) : @(0.5);
    NSNumber *animationScale2 = type == XLAnimationTypeToBigger ? @(0.92) : @(1.15);
    
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
        [layer setValue:animationScale1 forKeyPath:@"transform.scale"];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
            [layer setValue:animationScale2 forKeyPath:@"transform.scale"];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
                [layer setValue:@(1.0) forKeyPath:@"transform.scale"];
            } completion:nil];
        }];
    }];
}

/**
 *  给视图添加虚线边框
 *
 *  @param lineWidth  线宽
 *  @param lineMargin 每条虚线之间的间距
 *  @param lineLength 每条虚线的长度
 *  @param lineColor 每条虚线的颜色
 */
- (void)xl_addDottedLineBorderWithLineWidth:(CGFloat)lineWidth lineMargin:(CGFloat)lineMargin lineLength:(CGFloat)lineLength lineColor:(UIColor *)lineColor;
{
    CAShapeLayer *border = [CAShapeLayer layer];
    
    border.strokeColor = lineColor.CGColor;
    
    border.fillColor = nil;
    
    border.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    
    border.frame = self.bounds;
    
    border.lineWidth = lineWidth;
    
    border.lineCap = @"round";
    
    border.lineDashPattern = @[@(lineLength), @(lineMargin)];
    
    [self.layer addSublayer:border];
}

@end
