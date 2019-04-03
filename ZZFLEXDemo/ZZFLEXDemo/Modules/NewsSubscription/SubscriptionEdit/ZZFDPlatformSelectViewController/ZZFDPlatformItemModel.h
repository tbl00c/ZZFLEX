//
//  ZZFDPlatformItemModel.h
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2018/2/5.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZFDPlatformItemModel : NSObject

@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, strong) NSString *title;

@property (nonatomic, assign) BOOL selected;

@end

ZZFDPlatformItemModel *__createPlatformItemModel(NSInteger tag, NSString *title, BOOL selected);
