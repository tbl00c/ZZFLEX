//
//  CALayer+ZZFLEXDarkMode.h
//  ZZFLEX
//
//  Created by 李伯坤 on 2020/4/12.
//

// 参考：https://github.com/Qihuaile/DarkMode.git

#import <QuartzCore/QuartzCore.h>

@interface CALayer (ZZFLEXDarkMode)

@property (nonatomic, strong) UIColor *zzflex_backgroundColor;
@property (nonatomic, strong) UIColor *zzflex_borderColor;
@property (nonatomic, strong) UIColor *zzflex_shadowColor;
@property (nonatomic, strong) UIColor *zzflex_fillColor;
@property (nonatomic, strong) UIColor *zzflex_strokeColor;
@property (nonatomic, strong) NSArray *zzflex_gradientColors;
@property (nonatomic, strong) UIBezierPath *zzflex_fillPath;
@property (nonatomic, strong) id zzflex_contents;

@end
