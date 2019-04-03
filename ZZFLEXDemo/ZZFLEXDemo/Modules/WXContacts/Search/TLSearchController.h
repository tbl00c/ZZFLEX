//
//  TLSearchController.h
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2018/2/3.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLSearchController : UISearchController

+ (TLSearchController *)createWithResultVC:(UIViewController<UISearchResultsUpdating> *)searchResultVC;

@end
