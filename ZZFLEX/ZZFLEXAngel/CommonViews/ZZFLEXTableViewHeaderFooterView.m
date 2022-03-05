//
//  ZZFLEXTableViewHeaderFooterView.m
//  WCUIKit
//
//  Created by libokun on 2020/3/19.
//  Copyright © 2020 WeChat. All rights reserved.
//

#import "ZZFLEXTableViewHeaderFooterView.h"

@implementation ZZFLEXTableViewHeaderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.backgroundView = [UIView new];
        self.backgroundView.backgroundColor = [UIColor clearColor];
        self.accessibilityElementsHidden = YES;
    }
    return self;
}

@end
