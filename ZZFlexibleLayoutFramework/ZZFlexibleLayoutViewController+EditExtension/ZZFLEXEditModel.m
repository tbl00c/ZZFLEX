//
//  ZZFLEXEditModel.m
//  zhuanzhuan
//
//  Created by 李伯坤 on 2017/8/15.
//  Copyright © 2017年 转转. All rights reserved.
//

#import "ZZFLEXEditModel.h"

ZZFLEXEditModel *createFLEXEditModel(NSInteger tag, id sourceModel, NSDictionary *relationMap, NSError* (^inputlegitimacyCheckAction)(ZZFLEXEditModel *model))
{
    ZZFLEXEditModel *model = [[ZZFLEXEditModel alloc] initWithTag:tag sourceModel:sourceModel relationMap:relationMap inputlegitimacyCheckAction:inputlegitimacyCheckAction];
    return model;
}

ZZFLEXEditModel *createFLEXEditModel2(NSInteger tag, NSString *title, NSString *placeholder, BOOL showArrow, id sourceModel, NSDictionary *relationMap, NSError* (^inputlegitimacyCheckAction)(ZZFLEXEditModel *model))
{
    ZZFLEXEditModel *model = [[ZZFLEXEditModel alloc] initWithTag:tag title:title placeholder:placeholder showArrow:showArrow sourceModel:sourceModel relationMap:relationMap inputlegitimacyCheckAction:inputlegitimacyCheckAction];
    return model;
}

@interface ZZFLEXEditModel ()

/// 输入合法性检查，ZZFLEXEditModelProtocol中checkInputlegitimacy方法，默认执行此block
@property (nonatomic, copy) NSError* (^inputlegitimacyCheckAction)(ZZFLEXEditModel *model);

@property (nonatomic, strong) NSDictionary *cache;

@end

@implementation ZZFLEXEditModel

- (id)initWithTag:(NSInteger)tag sourceModel:(id)sourceModel relationMap:(NSDictionary *)relationMap inputlegitimacyCheckAction:(NSError *(^)(ZZFLEXEditModel *))inputlegitimacyCheckAction
{
    if (self = [super init]) {
        self.tag = tag;
        self.sourceModel = sourceModel;
        self.relationMap = relationMap;
        self.inputlegitimacyCheckAction = inputlegitimacyCheckAction;
        [self executeReverseRelationalMapping];
    }
    return self;
}

- (id)initWithTag:(NSInteger)tag title:(NSString *)title placeholder:(NSString *)placeholder showArrow:(BOOL)showArrow sourceModel:(id)sourceModel relationMap:(NSDictionary *)relationMap inputlegitimacyCheckAction:(NSError *(^)(ZZFLEXEditModel *))inputlegitimacyCheckAction
{
    if (self = [self initWithTag:tag sourceModel:sourceModel relationMap:relationMap inputlegitimacyCheckAction:inputlegitimacyCheckAction]) {
        self.title = title;
        self.placeholder = placeholder;
        self.showArrow = showArrow;
    }
    return self;
}

- (NSError *)checkInputlegitimacy
{
    if (self.inputlegitimacyCheckAction) {
        return self.inputlegitimacyCheckAction(self);
    }
    return nil;
}

- (void)executeRelationalMapping
{
    for (NSString *key in self.relationMap) {
        id sourceKey = self.relationMap[key];
        id value = [self valueForKey:key];
        [self.sourceModel setValue:value forKey:sourceKey];
    }
}

- (void)executeReverseRelationalMapping
{
    for (NSString *key in self.relationMap) {
        id sourceKey = self.relationMap[key];
        id value = [self.sourceModel valueForKey:sourceKey];
        [self setValue:value forKey:key];
    }
}

@end
