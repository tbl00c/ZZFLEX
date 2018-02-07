//
//  ZZFDPlatformItemModel.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2018/2/5.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "ZZFDPlatformItemModel.h"

ZZFDPlatformItemModel *__createPlatformItemModel(NSInteger tag, NSString *title, BOOL selected)
{
    ZZFDPlatformItemModel *model = [[ZZFDPlatformItemModel alloc] init];
    model.tag = tag;
    model.title = title;
    model.selected = selected;
    return model;
}

@implementation ZZFDPlatformItemModel

@end
