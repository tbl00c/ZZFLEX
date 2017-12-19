//
//  ZZFDCateMenuCell.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/12/18.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFDCateMenuCell.h"

@implementation ZZFDCateMenuCell

+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 50;
}

- (void)setViewDataModel:(id)dataModel
{
    [self.textLabel setText:dataModel];
}


@end
