//
//  ZZFDLanguageSelectViewController.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2018/2/5.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "ZZFDLanguageSelectViewController.h"
#import "ZZFDPlatformItemModel.h"

@interface ZZFDLanguageSelectViewController ()

@property (nonatomic, strong) ZZFDPlatformItemModel *allModel;

@property (nonatomic, strong) NSArray *itemsArray;

@property (nonatomic, copy) void (^selectedAction)(NSString *language);

@end

@implementation ZZFDLanguageSelectViewController

- (instancetype)initWithLanguageArray:(NSArray *)languageArray selectLanguage:(NSString *)language selectedAction:(void (^)(NSString *language))selectedAction
{
    if (self = [super init]) {
        self.selectedAction = selectedAction;
        
        NSMutableArray *data = [[NSMutableArray alloc] init];
        for (NSString *item in languageArray) {
            [data addObject:__createPlatformItemModel(0, item, [language isEqualToString:item])];
        }
        self.itemsArray = data;
        
        self.allModel = __createPlatformItemModel(0, @"全部", [language isEqualToString:@"全部"]);
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    [self setTitle:@"语言选择"];
    [self.collectionView setBackgroundColor:[UIColor colorGrayBG]];
    
    [self loadUI];
}

- (void)loadUI
{
    @weakify(self);
    self.clear();
    
    void (^ selectedAction)(ZZFDPlatformItemModel *model) = ^(ZZFDPlatformItemModel *model){
        @strongify(self);
        for (ZZFDPlatformItemModel *item in self.itemsArray) {
            item.selected = (item == model);
        }
        self.allModel.selected = (model == self.allModel);
        
        [self reloadView];
        [self.collectionView setUserInteractionEnabled:NO];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.selectedAction) {
                self.selectedAction(model.title);
            }
            [self.navigationController popViewControllerAnimated:YES];
        });
    };
    
    self.addSection(0).sectionInsets(UIEdgeInsetsMake(15, 0, 0, 0));
    self.addCell(@"ZZFDPlatformItemCell").toSection(0).withDataModel(self.allModel).selectedAction(selectedAction);
    
    self.addSection(1).sectionInsets(UIEdgeInsetsMake(15, 0, 0, 0));
    self.addCells(@"ZZFDPlatformItemCell").toSection(1).withDataModelArray(self.itemsArray).selectedAction(selectedAction);
    
    [self reloadView];
}

@end
