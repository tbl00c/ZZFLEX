//
//  ZZFDSubscriptionEditViewController.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2018/2/4.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "ZZFDSubscriptionEditViewController.h"
#import "ZZFLEXEditModel.h"
#import "ZZFDPlatformItemModel.h"

#import "ZZFDPlatformSelectViewController.h"
#import "ZZFDLanguageSelectViewController.h"

typedef NS_ENUM(NSInteger, ZZFDSEVCSectionType) {
    ZZFDSEVCSectionTypePlatform,
    ZZFDSEVCSectionTypeCate,
    ZZFDSEVCSectionTypeKeyword,
    ZZFDSEVCSectionTypeLevel,
    ZZFDSEVCSectionTypeNoti,
};

@implementation ZZFDSubscriptionEditViewController

- (instancetype)initWithSubModel:(ZZFDSubscriptionModel *)subModel completeAction:(void (^)(ZZFDSubscriptionModel *subModel))completeAction
{
    if (self = [super init]) {
        self.completeAction = completeAction;
        if (subModel) {
            _subModel = subModel;
            [self setTitle:@"编辑订阅"];
        }
        else {
            _subModel = [[ZZFDSubscriptionModel alloc] init];
            [self setTitle:@"添加订阅"];
        }
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    [self.view setBackgroundColor:[UIColor colorGrayBG]];
    @weakify(self);
    [self addRightBarButtonWithTitle:@"保存" actionBlick:^{
        @strongify(self);
        NSError *error = [self checkInputlegitimacy];
        if (error) {
            [TLUIUtility showAlertWithTitle:[error.userInfo objectForKey:@"msg"] message:nil cancelButtonTitle:@"确定" otherButtonTitles:nil actionHandler:nil];
            return;
        }
        
        [self excuteCompleteAction];
        if (self.completeAction) {
            self.completeAction(self.subModel);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self loadListUIWithModel:self.subModel];
}

#pragma mark - # UI
- (void)loadListUIWithModel:(ZZFDSubscriptionModel *)subModel
{
    @weakify(self);
    self.clear();

    self.addSection(ZZFDSEVCSectionTypePlatform).sectionInsets(UIEdgeInsetsMake(15, 0, 0, 0));
    self.addSection(ZZFDSEVCSectionTypeCate);
    [self loadPlatformModuleWithModel:subModel];
    
    // 关键词
    self.addSection(ZZFDSEVCSectionTypeKeyword).sectionInsets(UIEdgeInsetsMake(15, 0, 0, 0));
    ZZFLEXEditModel *keywordModel = createFLEXEditModel(0, @"关键词", @"请输入关键词", subModel.keyword, subModel, ^NSError *(ZZFLEXEditModel *model) {
        if ([model.value length] == 0) {
            return [NSError errorWithDomain:ZZFLEXEditErrorDomain code:-1 userInfo:@{@"msg" : @"请输入关键词"}];
        }
        return nil;
    }, ^(ZZFLEXEditModel *model) {
        @strongify(self);
        [self.subModel setKeyword:model.value];
    });
    self.addCell(@"ZZFDTextFieldCell").toSection(ZZFDSEVCSectionTypeKeyword).withDataModel(keywordModel);
    
    // 作者等级
    self.addSection(ZZFDSEVCSectionTypeLevel).sectionInsets(UIEdgeInsetsMake(15, 0, 0, 0));
    ZZFLEXEditModel *levelModel = createFLEXEditModel(0, @"作者等级", @"0", (subModel.minLevel.integerValue == 0 ? nil : subModel.minLevel), subModel, ^NSError *(ZZFLEXEditModel *model) {
        if ([model.value stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]].length > 0) {
            return [NSError errorWithDomain:ZZFLEXEditErrorDomain code:-1 userInfo:@{@"msg" : @"最小等级只支持0-10之间的数字哦"}];
        }
        if ([model.value1 stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]].length > 0) {
            return [NSError errorWithDomain:ZZFLEXEditErrorDomain code:-1 userInfo:@{@"msg" : @"最大等级只支持0-10之间的数字哦"}];
        }
        
        NSInteger minLevel = [model.value integerValue];
        NSInteger maxLevel = [model.value1 length] > 0 ? [model.value1 integerValue] : 10;
        if (minLevel < 0 || minLevel > 10) {
            return [NSError errorWithDomain:ZZFLEXEditErrorDomain code:-1 userInfo:@{@"msg" : @"最小等级范围为0-10"}];
        }
        if (maxLevel < 0 || maxLevel > 10) {
            return [NSError errorWithDomain:ZZFLEXEditErrorDomain code:-1 userInfo:@{@"msg" : @"最大等级范围为0-10"}];
        }
        if (minLevel > maxLevel) {
            return [NSError errorWithDomain:ZZFLEXEditErrorDomain code:-1 userInfo:@{@"msg" : @"最小等级应小于最大等级"}];
        }
        return nil;
    }, ^(ZZFLEXEditModel *model) {
        @strongify(self);
        [self.subModel setMinLevel:[model.value length] > 0 ? model.value : @"0"];
        [self.subModel setMaxLevel:[model.value1 length] > 0 ? model.value1 : @"10"];
    });
    [levelModel setPlaceholderModel1:@"10"];
    [levelModel setValue1:(subModel.maxLevel.length == 0 || subModel.maxLevel.integerValue == 10) ? nil : subModel.maxLevel];
    self.addCell(@"ZZFDAuthLevelCell").toSection(ZZFDSEVCSectionTypeLevel).withDataModel(levelModel);
    
    // 通知
    self.addSection(ZZFDSEVCSectionTypeNoti).sectionInsets(UIEdgeInsetsMake(15, 0, 0, 0));
    ZZFLEXEditModel *notiModel = createFLEXEditModel(0, @"通知", nil, @(subModel.noti), subModel, nil, ^(ZZFLEXEditModel *model) {
        @strongify(self);
        BOOL on = [model.value boolValue];
        [self.subModel setNoti:on];
    });
    self.addCell(@"ZZFDSwitchCell").toSection(ZZFDSEVCSectionTypeNoti).withDataModel(notiModel);
    
    [self reloadView];
}

- (void)loadPlatformModuleWithModel:(ZZFDSubscriptionModel *)subModel
{
    @weakify(self);
    self.sectionForTag(ZZFDSEVCSectionTypePlatform).clear();
    
    // 选择平台
    ZZFLEXEditModel *platformModel = createFLEXEditModel(0, @"平台", @"请选择", subModel.platformName, subModel, ^NSError *(ZZFLEXEditModel *model) {
        if ([model.value length] == 0) {
            return [NSError errorWithDomain:ZZFLEXEditErrorDomain code:-1 userInfo:@{@"msg" : @"请选择平台"}];
        }
        return nil;
    }, nil);
    self.addCell(@"ZZFDPageSelectCell").toSection(ZZFDSEVCSectionTypePlatform).withDataModel(platformModel).selectedAction(^(ZZFLEXEditModel *model) {
        @strongify(self);
        ZZFDPlatformSelectViewController *platformSelectVC = [[ZZFDPlatformSelectViewController alloc] initWithSelectPlatform:self.subModel.platform selectedAction:^(ZZFDSubscriptionPlatform platform) {
            @strongify(self);
            self.subModel.platform = platform;
            [self loadPlatformModuleWithModel:self.subModel];
        }];
        PushVC(platformSelectVC);
    });
    
    // 语言
    if (subModel.languageArray.count > 0) {
        NSString *title = subModel.language.length > 0 ? subModel.language : @"全部";
        ZZFLEXEditModel *languageModel = createFLEXEditModel(0, @"语言", @"请选择", title, subModel, nil, nil);
        self.addCell(@"ZZFDPageSelectCell").toSection(ZZFDSEVCSectionTypePlatform).withDataModel(languageModel).selectedAction(^(ZZFLEXEditModel *model) {
            @strongify(self);
            ZZFDLanguageSelectViewController *platformSelectVC = [[ZZFDLanguageSelectViewController alloc] initWithLanguageArray:subModel.languageArray selectLanguage:title selectedAction:^(NSString *language) {
                @strongify(self);
                subModel.language = language;
                [self loadPlatformModuleWithModel:self.subModel];
            }];
            PushVC(platformSelectVC);
        });
    }
    
    // 分类
    if (subModel.cateArray.count > 0) {
        self.sectionForTag(ZZFDSEVCSectionTypeCate).sectionInsets(UIEdgeInsetsMake(15, 0, 0, 0)).clear();
        NSMutableArray *data = [[NSMutableArray alloc] init];
        for (NSString *title in subModel.cateArray) {
            BOOL selected = [subModel.cate containsObject:title];
            ZZFDPlatformItemModel *model = __createPlatformItemModel(0, title, selected);
            [data addObject:model];
        }
        
        ZZFLEXEditModel *cateModel = createFLEXEditModel(0, data, nil, nil, subModel, ^NSError *(ZZFLEXEditModel *model) {
            NSMutableArray *selectedData = [[NSMutableArray alloc] init];
            for (ZZFDPlatformItemModel *model in data) {
                if (model.selected) {
                    [selectedData addObject:model.title];
                }
            }
            if (selectedData.count == 0) {
                return [NSError errorWithDomain:ZZFLEXEditErrorDomain code:-1 userInfo:@{@"msg" : @"至少选择一个分类"}];
            }
            return nil;
        }, ^(ZZFLEXEditModel *editModel) {
            @strongify(self);
            NSMutableArray *selectedData = [[NSMutableArray alloc] init];
            for (ZZFDPlatformItemModel *model in data) {
                if (model.selected) {
                    [selectedData addObject:model.title];
                }
            }
            [self.subModel setCate:selectedData];
        });
        self.addCell(@"ZZFDCateCell").toSection(ZZFDSEVCSectionTypeCate).withDataModel(cateModel);
    }
    else {
        self.sectionForTag(ZZFDSEVCSectionTypeCate).sectionInsets(UIEdgeInsetsZero).clear();
    }
    
    [self reloadView];
}

@end
