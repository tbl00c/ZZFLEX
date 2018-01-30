//
//  ZZFDGoodListCell.h
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/11/28.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZFlexibleLayoutViewProtocol.h"

typedef NS_ENUM(NSInteger, ZZFDGoodListCellEventType) {
    ZZFDGoodListCellEventTypeClose,
};

@class ZZFDGoodListModel;
@interface ZZFDGoodListCell : UICollectionViewCell <ZZFlexibleLayoutViewProtocol>

@property (nonatomic, strong) ZZFDGoodListModel *dataModel;

@property (nonatomic, copy) id (^eventAction)(ZZFDGoodListCellEventType, id data);

@end
