//
//  NSArray+SafeAccess.h
//  TLKit
//
//  Created by 李伯坤 on 2017/9/11.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSArray (SafeAccess)

- (id)safeObjectAtIndex:(NSUInteger)index;

- (NSString *)stringAtIndex:(NSUInteger)index;

- (NSNumber *)numberAtIndex:(NSUInteger)index;

- (NSDecimalNumber *)decimalNumberAtIndex:(NSUInteger)index;

- (NSArray *)arrayAtIndex:(NSUInteger)index;

- (NSDictionary *)dictionaryAtIndex:(NSUInteger)index;

- (NSInteger)integerAtIndex:(NSUInteger)index;

- (NSUInteger)unsignedIntegerAtIndex:(NSUInteger)index;

- (BOOL)boolAtIndex:(NSUInteger)index;

- (int16_t)int16AtIndex:(NSUInteger)index;

- (int32_t)int32AtIndex:(NSUInteger)index;

- (int64_t)int64AtIndex:(NSUInteger)index;

- (char)charAtIndex:(NSUInteger)index;

- (short)shortAtIndex:(NSUInteger)index;

- (float)floatAtIndex:(NSUInteger)index;

- (double)doubleAtIndex:(NSUInteger)index;

- (NSDate *)dateAtIndex:(NSUInteger)index dateFormat:(NSString *)dateFormat;

- (CGFloat)CGFloatAtIndex:(NSUInteger)index;

- (CGPoint)pointAtIndex:(NSUInteger)index;

- (CGSize)sizeAtIndex:(NSUInteger)index;

- (CGRect)rectAtIndex:(NSUInteger)index;

@end
