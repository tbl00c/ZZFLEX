//
//  ZZFDRQFailedCell.h
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2018/1/24.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZFlexibleLayoutViewProtocol.h"

@interface ZZFDRQFailedModel : NSObject

@property (nonatomic, assign) BOOL loading;

+ (instancetype)createModelWithLoading:(BOOL)loading;

@end

@interface ZZFDRQFailedCell : UICollectionViewCell <ZZFlexibleLayoutViewProtocol>

@property (nonatomic, strong) ZZFDRQFailedModel *model;

@property (nonatomic, copy) id (^eventAction)(NSInteger eventType, id data);

@end
