//
//  ZZFLEXAppearance.h
//  ZZFLEX
//
//  Created by 李伯坤 on 2021/7/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZZFLEXAppearance : NSObject

@property (nonatomic, strong) UIColor *seperatorColor;
@property (nonatomic, copy) void (^borderColorAction)(UIView *view, UIColor *color);
@property (nonatomic, copy) void (^shadowColorAction)(UIView *view, UIColor *color);
@property (nonatomic, copy) void (^seperatorColorAction)(UIView *view, CAShapeLayer *layer, NSString *key, UIColor *color);

+ (instancetype)appearance;

@end

NS_ASSUME_NONNULL_END
