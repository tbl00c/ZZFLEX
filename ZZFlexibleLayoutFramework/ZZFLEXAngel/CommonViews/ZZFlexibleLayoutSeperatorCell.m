//
//  ZZFlexibleLayoutSeperatorCell.m
//  ZZFlexibleLayoutFrameworkDemo
//
//  Created by 李伯坤 on 2016/12/27.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "ZZFlexibleLayoutSeperatorCell.h"

@implementation ZZFlexibleLayoutSeperatorModel

- (id)initWithSize:(CGSize)size andColor:(UIColor *)color
{
    if (self = [super init]) {
        self.size = size;
        self.color = color;
    }
    return self;
}

@end

@implementation ZZFlexibleLayoutSeperatorCell

+ (CGSize)viewSizeByDataModel:(id)dataModel
{
    return ((ZZFlexibleLayoutSeperatorModel *)dataModel).size;
}

- (id)init
{
    if (self = [super init]) {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)setViewDataModel:(id)dataModel
{
    ZZFlexibleLayoutSeperatorModel *model = dataModel;
    if (model.color) {
        [self setBackgroundColor:model.color];
    }
}

@end
