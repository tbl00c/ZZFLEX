//
//  NSArray+SafeAccess.m
//  TLKit
//
//  Created by 李伯坤 on 2017/9/11.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "NSArray+SafeAccess.h"

@implementation NSArray (SafeAccess)

- (id)safeObjectAtIndex:(NSUInteger)index{
    if (index <self.count) {
        return self[index];
    }else{
        return nil;
    }
}

- (NSString *)stringAtIndex:(NSUInteger)index
{
    id value = [self safeObjectAtIndex:index];
    if (value == nil || value == [NSNull null] || [[value description] isEqualToString:@"<null>"]) {
        return nil;
    }
    if ([value isKindOfClass:[NSString class]]) {
        return (NSString*)value;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value stringValue];
    }
    
    return nil;
}

- (NSNumber *)numberAtIndex:(NSUInteger)index
{
    id value = [self safeObjectAtIndex:index];
    if ([value isKindOfClass:[NSNumber class]]) {
        return (NSNumber*)value;
    }
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        return [f numberFromString:(NSString*)value];
    }
    return nil;
}

- (NSDecimalNumber *)decimalNumberAtIndex:(NSUInteger)index{
    id value = [self safeObjectAtIndex:index];
    
    if ([value isKindOfClass:[NSDecimalNumber class]]) {
        return value;
    }
    else if ([value isKindOfClass:[NSNumber class]]) {
        NSNumber * number = (NSNumber*)value;
        return [NSDecimalNumber decimalNumberWithDecimal:[number decimalValue]];
    }
    else if ([value isKindOfClass:[NSString class]]) {
        NSString * str = (NSString*)value;
        return [str isEqualToString:@""] ? nil : [NSDecimalNumber decimalNumberWithString:str];
    }
    return nil;
}

- (NSArray *)arrayAtIndex:(NSUInteger)index
{
    id value = [self safeObjectAtIndex:index];
    if (value == nil || value == [NSNull null]) {
        return nil;
    }
    if ([value isKindOfClass:[NSArray class]]) {
        return value;
    }
    return nil;
}

- (NSDictionary *)dictionaryAtIndex:(NSUInteger)index
{
    id value = [self safeObjectAtIndex:index];
    if (value == nil || value == [NSNull null]) {
        return nil;
    }
    if ([value isKindOfClass:[NSDictionary class]]) {
        return value;
    }
    return nil;
}

- (NSInteger)integerAtIndex:(NSUInteger)index
{
    id value = [self safeObjectAtIndex:index];
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value integerValue];
    }
    return 0;
}

- (NSUInteger)unsignedIntegerAtIndex:(NSUInteger)index
{
    id value = [self safeObjectAtIndex:index];
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value unsignedIntegerValue];
    }
    return 0;
}

- (BOOL)boolAtIndex:(NSUInteger)index
{
    id value = [self safeObjectAtIndex:index];
    
    if (value == nil || value == [NSNull null]) {
        return NO;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value boolValue];
    }
    if ([value isKindOfClass:[NSString class]]) {
        return [value boolValue];
    }
    return NO;
}

- (int16_t)int16AtIndex:(NSUInteger)index
{
    id value = [self safeObjectAtIndex:index];
    
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value shortValue];
    }
    if ([value isKindOfClass:[NSString class]]) {
        return [value intValue];
    }
    return 0;
}

- (int32_t)int32AtIndex:(NSUInteger)index
{
    id value = [self safeObjectAtIndex:index];
    
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value intValue];
    }
    return 0;
}

- (int64_t)int64AtIndex:(NSUInteger)index
{
    id value = [self safeObjectAtIndex:index];
    
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value longLongValue];
    }
    return 0;
}

- (char)charAtIndex:(NSUInteger)index{
    
    id value = [self safeObjectAtIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value charValue];
    }
    return 0;
}

- (short)shortAtIndex:(NSUInteger)index
{
    id value = [self safeObjectAtIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [value shortValue];
    }
    if ([value isKindOfClass:[NSString class]])
    {
        return [value intValue];
    }
    return 0;
}
- (float)floatAtIndex:(NSUInteger)index
{
    id value = [self safeObjectAtIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value floatValue];
    }
    return 0;
}
- (double)doubleAtIndex:(NSUInteger)index
{
    id value = [self safeObjectAtIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value doubleValue];
    }
    return 0;
}

- (NSDate *)dateAtIndex:(NSUInteger)index dateFormat:(NSString *)dateFormat {
    NSDateFormatter *formater = [[NSDateFormatter alloc]init];
    formater.dateFormat = dateFormat;
    id value = [self safeObjectAtIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return nil;
    }
    
    if ([value isKindOfClass:[NSString class]] && ![value isEqualToString:@""] && !dateFormat) {
        return [formater dateFromString:value];
    }
    return nil;
}

//CG
- (CGFloat)CGFloatAtIndex:(NSUInteger)index
{
    id value = [self safeObjectAtIndex:index];
    
    CGFloat f = [value doubleValue];
    
    return f;
}

- (CGPoint)pointAtIndex:(NSUInteger)index
{
    id value = [self safeObjectAtIndex:index];
    
    CGPoint point = CGPointFromString(value);
    
    return point;
}
- (CGSize)sizeAtIndex:(NSUInteger)index
{
    id value = [self safeObjectAtIndex:index];

    CGSize size = CGSizeFromString(value);
    
    return size;
}
- (CGRect)rectAtIndex:(NSUInteger)index
{
    id value = [self safeObjectAtIndex:index];
    
    CGRect rect = CGRectFromString(value);
    
    return rect;
}

@end
