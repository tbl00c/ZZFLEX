//
//  ZZFLEXViewModel.h
//  ZZFlexibleLayoutFrameworkDemo
//
//  Created by lbk on 2016/12/27.
//  Copyright © 2016年 lbk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZZFLEXViewModelDelegate <NSObject>

- (__kindof UIScrollView *)hostView;

@end

/**
 * 仅框架内部使用
 *
 * 是对dataModel的一层封装
 * 实际给cell\view传递的仍然是dataModel
 */
@interface ZZFLEXViewModel : NSObject

/// view/cell类
@property (nonatomic, assign) Class viewClass;

@property (nonatomic, weak) id<ZZFLEXViewModelDelegate> vmDelegate;

/// 复用标识（默认无需设置，除非对同个cell进行了不同定制）
@property (nonatomic, strong) NSString *reuseIdentifier;

/// view/cell的数据Model
@property (nonatomic, strong) id dataModel;

/// view/cell的大小
@property (nonatomic, assign) CGSize viewSize;

@property (nonatomic, assign) NSInteger viewTag;

/// view/cell中的事件
@property (nonatomic, copy) id (^eventAction)(NSInteger actionType, id data);

/// 业务方指定的代理，默认nil
@property (nonatomic, weak) id delegate;

/// cell选中事件
@property (nonatomic, copy) void (^selectedAction)(id data);

/// cell配置事件
@property (nonatomic, copy) void (^configAction)(__kindof UIView *itemView, id dataModel);

/**
*  根据类名初始化viewModel
*/
- (instancetype)initWithViewClass:(Class)viewClass vmDelegate:(id<ZZFLEXViewModelDelegate>)vmDelegate;

/**
 *  根据类名和数据源初始化viewModel
 */
- (instancetype)initWithViewClass:(Class)viewClass vmDelegate:(id<ZZFLEXViewModelDelegate>)vmDelegate dataModel:(id)dataModel;
- (instancetype)initWithViewClass:(Class)viewClass reuseIdentifier:(NSString *)reuseIdentifier vmDelegate:(id<ZZFLEXViewModelDelegate>)vmDelegate dataModel:(id)dataModel viewTag:(NSInteger)viewTag;
- (instancetype)initWithViewClass:(Class)viewClass reuseIdentifier:(NSString *)reuseIdentifier vmDelegate:(id<ZZFLEXViewModelDelegate>)vmDelegate dataModel:(id)dataModel viewSize:(CGSize)viewSize viewTag:(NSInteger)viewTag;

/**
 *  重新计算视图大小
 */
- (void)updateViewSize;

@end
