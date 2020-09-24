//
//  ZZFLEXAngel+Private.h
//  ZZFLEXDemo
//
//  Created by lbk on 2017/12/14.
//  Copyright © 2017年 lbk. All rights reserved.
//

#import "ZZFLEXAngel.h"

@interface ZZFLEXAngel (Private)

- (ZZFLEXSectionModel *)sectionModelAtIndex:(NSInteger)section;

- (ZZFLEXSectionModel *)sectionModelForTag:(NSInteger)sectionTag;

- (ZZFLEXViewModel *)viewModelAtIndexPath:(NSIndexPath *)indexPath;

- (NSArray<ZZFLEXViewModel *> *)viewModelsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

@end
