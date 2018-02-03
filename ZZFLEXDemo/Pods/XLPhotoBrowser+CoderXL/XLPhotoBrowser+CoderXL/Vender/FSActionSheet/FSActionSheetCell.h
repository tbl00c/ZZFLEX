//
//  FSActionSheetCell.h
//  FSActionSheet
//
//  Created by Steven on 6/7/16.
//  Copyright © 2016年 Steven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSActionSheetConfig.h"
@class FSActionSheetItem;

@interface FSActionSheetCell : UITableViewCell

@property (nonatomic, assign) FSContentAlignment contentAlignment;
@property (nonatomic, strong) FSActionSheetItem *item;
@property (nonatomic, assign) BOOL hideTopLine; ///< 是否隐藏顶部线条

@end
