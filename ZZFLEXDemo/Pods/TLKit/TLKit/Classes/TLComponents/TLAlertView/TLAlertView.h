//
//  TLAlertView.h
//  TLKit
//
//  Created by 李伯坤 on 2020/1/27.
//

#import <UIKit/UIKit.h>

#pragma mark - # TLAlertViewItem
@class TLAlertView;
@class TLAlertViewItem;
typedef void (^TLAlertViewItemClickAction)(TLAlertView *alertView, TLAlertViewItem *item, NSInteger index);
typedef void (^TLAlertViewTextFieldConfigAction)(TLAlertView *alertView, UITextField *textField);

typedef NS_ENUM(NSInteger, TLAlertViewItemType) {
    TLAlertViewItemTypeNormal = 0,
    TLAlertViewItemTypeCancel = 1,
    TLAlertViewItemTypeDestructive = 2,
};

@interface TLAlertViewItem : NSObject

/// 类型
@property (nonatomic, assign) TLAlertViewItemType type;

/// 标题
@property (nonatomic, strong) NSString *title;

/// 点击事件
@property (nonatomic, copy) TLAlertViewItemClickAction clickAction;

/// 倒计时
@property (nonatomic, strong, readonly) NSNumber *countdownTime;
/// 倒计时结束事件
@property (nonatomic, copy) TLAlertViewItemClickAction countdownAction;
- (void)startCountDown:(NSNumber *)countdownTime countdownAction:(TLAlertViewItemClickAction)countdownAction;
- (void)stopCountDown;

/// 不可点击
@property (nonatomic, assign) BOOL disable;

/// 禁用点击后AlertView自动消失
@property (nonatomic, assign) BOOL disableDismissAfterClick;

#pragma mark - 自定义项
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *titleColorDisable;
@property (nonatomic, strong) UIFont *titleFont;

- (instancetype)initWithTitle:(NSString *)title clickAction:(TLAlertViewItemClickAction)clickAction;

- (instancetype)initWithTitle:(NSString *)title clickAction:(TLAlertViewItemClickAction)clickAction countdownTime:(NSNumber *)countdownTime countdownAction:(TLAlertViewItemClickAction)countdownAction;

@end

#pragma mark - # TLAlertView
@interface TLAlertView : UIView
/// 标题
@property (nonatomic, strong) NSString *title;
/// 正文
@property (nonatomic, strong) NSString *message;
/// 按钮（不包含取消按钮）
@property (nonatomic, strong, readonly) NSArray<TLAlertViewItem *> *items;

@property (nonatomic, strong) __kindof UIView *customView;

@property (nonatomic, strong, readonly) UITextField *textField;

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message;
- (instancetype)initWithCustomView:(__kindof UIView *)customView;

- (void)addTextFieldWithConfigAction:(TLAlertViewTextFieldConfigAction)configAction;

- (void)addItemWithTitle:(NSString *)title clickAction:(TLAlertViewItemClickAction)clickAction;
- (void)addDestructiveItemWithTitle:(NSString *)title clickAction:(TLAlertViewItemClickAction)clickAction;
- (void)addCancelItemTitle:(NSString *)title clickAction:(TLAlertViewItemClickAction)clickAction;

- (void)addItem:(TLAlertViewItem *)item;

- (void)show;
- (void)dismiss;

#pragma mark - 自定义项
@property (nonatomic, strong) UIColor *shadowColor;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *messageColor;
@property (nonatomic, strong) UIFont *messageFont;

#pragma mark - 兼容旧版本API
+ (void)showWithTitle:(NSString *)title message:(NSString *)message;
+ (void)showWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle;
+ (void)showWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle actionHandler:(void (^)(NSInteger buttonIndex))actionHandler;
+ (void)showWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles actionHandler:(void (^)(NSInteger buttonIndex))actionHandler;

@end

