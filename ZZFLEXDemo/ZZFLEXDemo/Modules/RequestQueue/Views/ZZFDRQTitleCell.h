//
//  ZZFDRQTitleCell.h
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2018/1/25.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZFDRQTitleModel : NSObject

@property (nonatomic, strong) NSString *title;

@property (nonatomic, assign) BOOL selected;

+ (instancetype)createModelWithTitle:(NSString *)title;

@end

@interface ZZFDRQTitleCell : UICollectionViewCell

@property (nonatomic, copy) id (^eventAction)(NSInteger eventType, id data);

@property (nonatomic, strong) ZZFDRQTitleModel *model;

@end
