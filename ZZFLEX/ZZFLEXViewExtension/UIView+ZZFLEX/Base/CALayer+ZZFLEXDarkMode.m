//
//  CALayer+ZZFLEXDarkMode.m
//  ZZFLEX
//
//  Created by 李伯坤 on 2020/4/12.
//

#import "CALayer+ZZFLEXDarkMode.h"
#import <objc/runtime.h>

@implementation CALayer (ZZFLEXDarkMode)

- (void)setDynamicColor
{
    [CATransaction begin];
    [CATransaction setDisableActions:YES]; // 禁用隐式动画，否则在调完color回到主界面会有动画
    
    if([self isMemberOfClass:CAShapeLayer.class]) { // 设置CAShapeLayer
        CAShapeLayer *shapeLayer = (CAShapeLayer *)self;
        
        if (self.zzflex_fillColor != nil) {
            shapeLayer.fillColor = shapeLayer.zzflex_fillColor.CGColor;
        }
        if (self.zzflex_strokeColor != nil) {
            shapeLayer.strokeColor = shapeLayer.zzflex_strokeColor.CGColor;
        }
        
    } else if ([self isMemberOfClass:CAGradientLayer.class] && self.zzflex_gradientColors != nil) {
        // 设置CAGradientLayer colors
        NSMutableArray *colors = [NSMutableArray arrayWithCapacity:self.zzflex_gradientColors.count];
        // 遍历 zzflex_gradientColors的元素，添加元素对应的CGColor到colors中
        for (int i=0; i<self.zzflex_gradientColors.count; i++) {
            colors[i] = (__bridge id _Nonnull)([self.zzflex_gradientColors[i] CGColor]);
        }
        CAGradientLayer *gradientLayer = (CAGradientLayer *)self;
        gradientLayer.colors = colors;
    }
    if(self.zzflex_backgroundColor != nil){ // 非CAShapeLayer和GradientLayer，设置背景色
        self.backgroundColor = self.zzflex_backgroundColor.CGColor;
    }
    
    if (self.zzflex_shadowColor != nil) { // 阴影设置
        self.shadowColor = self.zzflex_shadowColor.CGColor;
    }
    if (self.zzflex_borderColor != nil) { // 边框设置
        self.borderColor = self.zzflex_borderColor.CGColor;
    }
    
    if (self.zzflex_fillColor != nil
        && self.zzflex_contents != nil
        && self.zzflex_fillPath != nil) { // imageView设置圆角

        CGImageRef cgImage = (__bridge CGImageRef)(self.zzflex_contents);
        
        // 这里通过content的图片获取context. 要用图片的宽高除以scale
        CGContextRef context = CGBitmapContextCreate(nil,
                                                  CGImageGetWidth(cgImage)/UIScreen.mainScreen.scale,
                                                  CGImageGetHeight(cgImage)/UIScreen.mainScreen.scale,
                                                  CGImageGetBitsPerComponent(cgImage),
                                                  CGImageGetBytesPerRow(cgImage),
                                                  CGImageGetColorSpace(cgImage),
                                                  CGImageGetBitmapInfo(cgImage));
        if (!context) return;
        
        CGContextSetFillColorWithColor(context, self.zzflex_fillColor.CGColor);
        
        UIBezierPath *bezierPath_Fill = [UIBezierPath bezierPathWithRect:self.bounds];
        // 添加两条path， 一个bounds方框，一个要展示头像的样式圆
        CGContextAddPath(context, self.zzflex_fillPath.CGPath);
        CGContextAddPath(context, bezierPath_Fill.CGPath);
        // drawPath： kCGPathEOFill 奇偶规则，异或。 相当于swift该语法中的 .xor
        CGContextDrawPath(context, kCGPathEOFill);
        
        // 去除cgImageshe知道context中
        self.contents = (__bridge id _Nullable)(CGBitmapContextCreateImage(context));
        
        // 释放 context
        CGContextRelease(context);
    }
    
    [CATransaction commit];
        
}

#pragma mark -- getter/Setter

- (UIColor *)zzflex_backgroundColor {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setZzflex_backgroundColor:(UIColor *)zzflex_backgroundColor {
    objc_setAssociatedObject(self, @selector(zzflex_backgroundColor), zzflex_backgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)zzflex_fillColor {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setZzflex_fillColor:(UIColor *)zzflex_fillColor {
    objc_setAssociatedObject(self, @selector(zzflex_fillColor), zzflex_fillColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIColor *)zzflex_strokeColor {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setZzflex_strokeColor:(UIColor *)zzflex_strokeColor {
    objc_setAssociatedObject(self, @selector(zzflex_strokeColor), zzflex_strokeColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIColor *)zzflex_borderColor {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setZzflex_borderColor:(UIColor *)zzflex_borderColor {
    objc_setAssociatedObject(self, @selector(zzflex_borderColor), zzflex_borderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)zzflex_gradientColors {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setZzflex_gradientColors:(NSArray *)zzflex_gradientColors {
    objc_setAssociatedObject(self, @selector(zzflex_gradientColors), zzflex_gradientColors, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (UIColor *)zzflex_shadowColor {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setZzflex_shadowColor:(NSArray *)zzflex_shadowColor {
    objc_setAssociatedObject(self, @selector(zzflex_shadowColor), zzflex_shadowColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)zzflex_fillPath {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setZzflex_fillPath:(UIBezierPath *)zzflex_fillPath {
    objc_setAssociatedObject(self, @selector(zzflex_fillPath), zzflex_fillPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)zzflex_contents {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setZzflex_contents:(id)zzflex_contents {
    objc_setAssociatedObject(self, @selector(zzflex_contents), zzflex_contents, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end


@implementation UIView (ZZLFEXDynamicColor)

+ (void)load
{
    Method layoutSubviews = class_getInstanceMethod(self, @selector(layoutSubviews));
    Method swizzling_layoutSubviews = class_getInstanceMethod(self, @selector(zzflex_layoutSubviews));
    method_exchangeImplementations(layoutSubviews, swizzling_layoutSubviews);
}

- (void)zzflex_layoutSubviews
{
    if (self.layer.sublayers.count > 0) {
        for (CALayer *layer in self.layer.sublayers) {
            [layer setDynamicColor];
        }
    }
    [self.layer setDynamicColor];
    
    [self zzflex_layoutSubviews];
}	

@end
