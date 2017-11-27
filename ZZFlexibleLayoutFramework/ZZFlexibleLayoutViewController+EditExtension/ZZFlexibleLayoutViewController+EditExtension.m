//
//  ZZFlexibleLayoutViewController+EditExtension.m
//  zhuanzhuan
//
//  Created by 李伯坤 on 2017/8/15.
//  Copyright © 2017年 转转. All rights reserved.
//

#import "ZZFlexibleLayoutViewController+EditExtension.h"
#import "ZZFLEXEditModelProtocol.h"

NSString *const ZZFLEXEditErrorDomain = @"AsyncSocketErrorDomain";

@implementation ZZFlexibleLayoutViewController (EditExtension)

- (NSError *)checkInputlegitimacy
{
    for (NSArray *section in self.allDataModelArray) {
        for (id<ZZFLEXEditModelProtocol> model in section) {
            if ([model respondsToSelector:@selector(checkInputlegitimacy)]) {
                NSError *error = [model checkInputlegitimacy];
                if (error) {
                    return error;
                }
            }
        }
    }
    return nil;
}

- (void)executeRelationalMapping
{
    for (NSArray *section in self.allDataModelArray) {
        for (id<ZZFLEXEditModelProtocol> model in section) {
            if ([model respondsToSelector:@selector(executeRelationalMapping)]) {
                [model executeRelationalMapping];
            }
        }
    }
}

@end
