//
//  ZZFDBaseCell.h
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2018/2/5.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZFLEXEditModel.h"
#import "ZZFDSubscriptionModel.h"
#import "ZZFlexibleLayoutViewProtocol.h"

@interface ZZFDBaseCell : UICollectionViewCell <ZZFlexibleLayoutViewProtocol>

/// 右箭头
@property (nonatomic, strong) UIImageView *arrowView;

@property (nonatomic, strong) ZZFLEXEditModel *editModel;

@property (nonatomic, copy) void (^eventAction)(NSInteger eventType, id data);

@end
