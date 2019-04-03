//
//  ZZFDSubscriptionTitleCell.h
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2018/2/7.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZFlexibleLayoutViewProtocol.h"

@class TLMenuItem;
@interface ZZFDSubscriptionTitleCell : UITableViewCell<ZZFlexibleLayoutViewProtocol>

@property (nonatomic, strong) TLMenuItem *menuItem;

@end
