//
//  ZZFDCateCell.h
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2018/2/5.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZFlexibleLayoutViewProtocol.h"

@interface ZZFDCateCell : UICollectionViewCell <ZZFlexibleLayoutViewProtocol>

@end

@interface ZZFDCateItemCell : UICollectionViewCell <ZZFlexibleLayoutViewProtocol>

@property (nonatomic, strong) UIButton *titleLabel;

@end
