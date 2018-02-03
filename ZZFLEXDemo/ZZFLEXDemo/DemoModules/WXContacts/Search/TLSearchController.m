//
//  TLSearchController.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2018/2/3.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "TLSearchController.h"

@implementation TLSearchController

+ (TLSearchController *)createWithResultVC:(UIViewController<UISearchResultsUpdating> *)searchResultVC
{
    TLSearchController *searchController = [[TLSearchController alloc] initWithSearchResultsController:searchResultVC];
    [searchController setSearchResultsUpdater:searchResultVC];
    return searchController;
}

- (instancetype)initWithSearchResultsController:(UIViewController *)searchResultsController
{
    if (self = [super initWithSearchResultsController:searchResultsController]) {
        self.definesPresentationContext = YES;
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
        [self.searchBar setPlaceholder:LOCSTR(@"搜索")];
        [self.searchBar setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SEARCHBAR_HEIGHT)];
        [self.searchBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorGrayBG]]];
        [self.searchBar setBarTintColor:[UIColor colorGrayBG]];
        [self.searchBar setTintColor:[UIColor blackColor]];
        [self.searchBar setTranslucent:NO];
        UITextField *tf = [[[self.searchBar.subviews firstObject] subviews] lastObject];
        [tf.layer setMasksToBounds:YES];
        [tf.layer setBorderWidth:BORDER_WIDTH_1PX];
        [tf.layer setBorderColor:[UIColor colorGrayLine].CGColor];
        [tf.layer setCornerRadius:5.0f];
        
        for (UIView *view in self.searchBar.subviews[0].subviews) {
            if ([view isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
                UIView *bg = [[UIView alloc] init];
                [bg setBackgroundColor:[UIColor colorGrayBG]];
                [view addSubview:bg];
                [bg mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.mas_equalTo(0);
                }];
                
                UIView *line = [[UIView alloc] init];
                [line setBackgroundColor:[UIColor colorGrayLine]];
                [view addSubview:line];
                [line mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.and.right.and.bottom.mas_equalTo(0);
                    make.height.mas_equalTo(BORDER_WIDTH_1PX);
                }];
                break;
            }
        }
    }
    
    return self;
}

@end
