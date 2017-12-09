//
//  ZZFLEXChainSectionModel.h
//  zhuanzhuan
//
//  Created by 李伯坤 on 2017/8/15.
//  Copyright © 2017年 转转. All rights reserved.
//

/**
 *  向列表中添加Section
 */

#import <UIKit/UIKit.h>

@class ZZFlexibleLayoutSectionModel;
@interface ZZFLEXChainSectionModel : NSObject

/// 最小行间距
- (ZZFLEXChainSectionModel *(^)(CGFloat minimumLineSpacing))minimumLineSpacing;
/// 最小元素间距
- (ZZFLEXChainSectionModel *(^)(CGFloat minimumInteritemSpacing))minimumInteritemSpacing;
/// sectionInsets
- (ZZFLEXChainSectionModel *(^)(UIEdgeInsets sectionInsets))sectionInsets;
/// backgrounColor
- (ZZFLEXChainSectionModel *(^)(UIColor *backgrounColor))backgrounColor;


#pragma mark - 框架内部使用
- (id)initWithSectionModel:(ZZFlexibleLayoutSectionModel *)sectionModel;

@end
