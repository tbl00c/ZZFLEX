//
//  ZZFDGoodDetailViewController.h
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/11/28.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFlexibleLayoutViewController.h"
#import "ZZFDGoodListModel.h"

@interface ZZFDGoodDetailViewController : ZZFlexibleLayoutViewController

@property (nonatomic, strong) ZZFDGoodListModel *listModel;

- (id)initWithListModel:(ZZFDGoodListModel *)listModel;

@end
