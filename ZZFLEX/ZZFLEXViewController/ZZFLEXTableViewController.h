//
//  ZZFLEXTableViewController.h
//  ZZFLEX
//
//  Created by libokun on 2020/3/19.
//


#import <UIKit/UIKit.h>
#import "ZZFLEXAngel.h"

/**
 *  动态布局页面
 *
 *  基于UITableView和ZZFLEXAngel封装
 *
 *  注意：
 *  1、sectionTag是Section的表示，建议设置（如果涉及UI的刷新则必须设置），同时建议SectionTag唯一
 *  2、viewTag为cell/header/footer的标识，需要时设置，能够结合SectionTag取到DataModel，可以不唯一
 */

@interface ZZFLEXTableViewController : UIViewController <
UITableViewDelegate,
UITableViewDataSource,
ZZFLEXAngelAPIProtocol
>

/// tableView风格，仅在loadView前设置有效
@property (nonatomic, assign) UITableViewStyle tableViewStyle;

/// 列表
@property (nonatomic, strong, readonly) UITableView *tableView;

/// 数据源
@property (nonatomic, strong, readonly) NSMutableArray *data;

/// 天使，数据源控制器
@property (nonatomic, strong, readonly) ZZFLEXAngel *angel;

@end
