//
//  ZZFlexibleLayoutViewModel.m
//  ZZFlexibleLayoutFrameworkDemo
//
//  Created by 李伯坤 on 2016/12/27.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "ZZFlexibleLayoutViewModel.h"
#import "ZZFlexibleLayoutViewProtocol.h"

@implementation ZZFlexibleLayoutViewModel
@synthesize viewSize = _viewSize;
@synthesize dataModel = _dataModel;

- (id)initWithClassName:(NSString *)className andDataModel:(id)dataModel
{
    return [self initWithClassName:className andDataModel:dataModel viewTag:0];
}

- (id)initWithClassName:(NSString *)className andDataModel:(id)dataModel viewTag:(NSInteger)viewTag
{
    if (self = [super init]) {
        _dataModel = dataModel;
        _className = className;
        _viewTag = viewTag;
        if (className.length > 0) {
            _viewClass = NSClassFromString(className);
        }
        [self updateCellHeight];
    }
    return self;
}

- (void)setDataModel:(id)dataModel
{
    _dataModel = dataModel;
    [self updateCellHeight];
}

- (id)dataModel
{
    if (!_dataModel) {
        return [NSNull null];
    }
    return _dataModel;
}

- (void)setClassName:(NSString *)className
{
    _className = className;
    if (className.length > 0) {
        _viewClass = NSClassFromString(className);
    }
    [self updateCellHeight];
}

- (void)updateCellHeight
{
    if (self.viewClass && [(id<ZZFlexibleLayoutViewProtocol>)self.viewClass respondsToSelector:@selector(viewSizeByDataModel:)]) {
        id dataModel = [self.dataModel isKindOfClass:[NSNull class]] ? nil : self.dataModel;
        _viewSize = [(id<ZZFlexibleLayoutViewProtocol>)self.viewClass viewSizeByDataModel:dataModel];
    }
    else {
        _viewSize = CGSizeZero;
    }
}

@end
