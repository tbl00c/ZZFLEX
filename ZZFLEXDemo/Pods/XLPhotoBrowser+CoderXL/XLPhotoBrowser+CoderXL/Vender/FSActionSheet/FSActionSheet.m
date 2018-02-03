//
//  FSActionSheet.m
//  FSActionSheet
//
//  Created by Steven on 6/7/16.
//  Copyright © 2016年 Steven. All rights reserved.
//

#import "FSActionSheet.h"
#import "FSActionSheetCell.h"

CGFloat const kFSActionSheetSectionHeight = 10; ///< 分区间距

@interface FSActionSheet () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *cancelTitle;
@property (nonatomic, copy) NSArray<FSActionSheetItem *> *items;
@property (nonatomic, copy) FSActionSheetHandler selectedHandler;

@property (nonatomic, strong) UIWindow *popupWindow;
@property (nonatomic, weak)   UIViewController *popupVC;
@property (nonatomic, weak)   UIView *controllerView;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, weak)   UILabel *titleLabel;

@property (nonatomic, strong) NSLayoutConstraint *heightConstraint; ///< 内容高度约束

@end

static NSString * const kFSActionSheetCellIdentifier = @"kFSActionSheetCellIdentifier";

@implementation FSActionSheet

- (instancetype)init {
    return [self initWithTitle:nil cancelTitle:nil items:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*! @brief 单文本选项快速初始化 */
- (instancetype)initWithTitle:(NSString *)title delegate:(id<FSActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle highlightedButtonTitle:(NSString *)highlightedButtonTitle otherButtonTitles:(NSArray<NSString *> *)otherButtonTitles {
    if (!(self = [super init])) return nil;
    
    [self commonInit];
    
    NSMutableArray *titleItems = [@[] mutableCopy];
    // 普通按钮
    for (NSString *otherTitle in otherButtonTitles) {
        if (otherTitle && otherTitle.length > 0) {
            [titleItems addObject:FSActionSheetTitleItemMake(FSActionSheetTypeNormal, otherTitle)];
        }
    }
    // 高亮按钮, 高亮按钮放在最下面.
    if (highlightedButtonTitle && highlightedButtonTitle.length > 0) {
        [titleItems addObject:FSActionSheetTitleItemMake(FSActionSheetTypeHighlighted, highlightedButtonTitle)];
    }
    
    self.title = title?:@"";
    self.delegate = delegate;
    self.cancelTitle = (cancelButtonTitle && cancelButtonTitle.length != 0)?cancelButtonTitle:@"取消";
    self.items = titleItems;
    
    [self addSubview:self.tableView];
    
    return self;
}

- (instancetype)initWithTitle:(NSString *)title delegate:(id<FSActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle highlightedButtonTitle:(NSString *)highlightedButtonTitle otherButtonTitles:(NSArray<NSString *> *)otherButtonTitles sourceWindow:(UIWindow *)sourceWindow
{
    if (!(self = [super init])) return nil;
    _popupWindow = sourceWindow;
    _popupVC = sourceWindow.rootViewController;
    _controllerView = sourceWindow.rootViewController.view;
    
    [self commonInit];
    
    NSMutableArray *titleItems = [@[] mutableCopy];
    // 普通按钮
    for (NSString *otherTitle in otherButtonTitles) {
        if (otherTitle && otherTitle.length > 0) {
            [titleItems addObject:FSActionSheetTitleItemMake(FSActionSheetTypeNormal, otherTitle)];
        }
    }
    // 高亮按钮, 高亮按钮放在最下面.
    if (highlightedButtonTitle && highlightedButtonTitle.length > 0) {
        [titleItems addObject:FSActionSheetTitleItemMake(FSActionSheetTypeHighlighted, highlightedButtonTitle)];
    }
    
    self.title = title?:@"";
    self.delegate = delegate;
    self.cancelTitle = (cancelButtonTitle && cancelButtonTitle.length != 0)?cancelButtonTitle:@"取消";
    self.items = titleItems;
    
    [self addSubview:self.tableView];
    
    return self;
}

/*! @brief 在外部组装选项按钮item */
- (instancetype)initWithTitle:(NSString *)title cancelTitle:(NSString *)cancelTitle items:(NSArray<FSActionSheetItem *> *)items {
    if (!(self = [super init])) return nil;
    
    [self commonInit];
    
    self.title = title?:@"";
    self.cancelTitle = (cancelTitle && cancelTitle.length != 0)?cancelTitle:@"取消";
    self.items = items?:@[];
    
    [self addSubview:self.tableView];
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.tableView.frame = self.bounds;
}

// 默认设置
- (void)commonInit {
    self.backgroundColor = FSActionSheetColorWithString(FSActionSheetBackColor);
    self.translatesAutoresizingMaskIntoConstraints = NO; // 允许约束
    
    _contentAlignment = FSContentAlignmentCenter; // 默认样式为居中
    _hideOnTouchOutside = YES; // 默认点击半透明层隐藏弹窗
    
    self.popupWindow.bounds = [UIScreen mainScreen].bounds;
    
    // 监听屏幕旋转
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(orientationDidChange:) name:UIDeviceOrientationDidChangeNotification  object:nil];
}

// 屏幕旋转通知回调
- (void)orientationDidChange:(NSNotification *)notification {
    if (_title.length > 0) {
        // 更新头部标题的高度
        CGFloat newHeaderHeight = [self heightForHeaderView];
        CGRect newHeaderRect = _tableView.tableHeaderView.frame;
        newHeaderRect.size.height = newHeaderHeight;
        _tableView.tableHeaderView.frame = newHeaderRect;
        self.tableView.tableHeaderView = self.tableView.tableHeaderView;
        // 适配当前内容高度
        [self fixContentHeight];
    }
}

#pragma mark - private
// 计算title在设定宽度下的富文本高度
- (CGFloat)heightForHeaderView {
    CGFloat labelHeight = [_titleLabel.attributedText boundingRectWithSize:CGSizeMake([self currentScreenWidth] - FSActionSheetDefaultMargin*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil].size.height;
    CGFloat headerHeight = ceil(labelHeight)+FSActionSheetDefaultMargin*2;
    
    return headerHeight;
}

// 整个弹窗内容的高度
- (CGFloat)contentHeight {
    CGFloat titleHeight = (_title.length > 0)?[self heightForHeaderView]:0;
    CGFloat rowHeightSum = (_items.count+1)*FSActionSheetRowHeight+kFSActionSheetSectionHeight;
    CGFloat contentHeight = titleHeight+rowHeightSum;
    
    return contentHeight;
}

// 适配屏幕高度, 弹出窗高度不应该高于屏幕的设定比例
- (void)fixContentHeight {
    CGFloat contentMaxHeight = [self currentScreenHeight] * FSActionSheetContentMaxScale;
    CGFloat contentHeight = [self contentHeight];
    if (contentHeight > contentMaxHeight) {
        contentHeight = contentMaxHeight;
        self.tableView.scrollEnabled = YES;
    } else {
        self.tableView.scrollEnabled = NO;
    }
    
    _heightConstraint.constant = contentHeight;
}

/// 屏幕当前宽度
- (CGFloat)currentScreenWidth {
    CGFloat currentScreenWidth;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat screenWidth = fmin(screenSize.width, screenSize.height);  // 该值为屏幕竖屏下的屏幕宽度
    CGFloat screenHeight = fmax(screenSize.width, screenSize.height); // 该值为屏幕竖屏下的屏幕高度
    // 判断屏幕方向
    UIInterfaceOrientation orientation = [_popupVC preferredInterfaceOrientationForPresentation];
    // 横屏
    if (orientation == UIInterfaceOrientationLandscapeLeft  || orientation == UIInterfaceOrientationLandscapeRight) {
        currentScreenWidth = screenHeight;
    } else {
        currentScreenWidth = screenWidth;
    }
    
    return currentScreenWidth;
}

/// 屏幕当前高度
- (CGFloat)currentScreenHeight {
    CGFloat currentScreenHeight;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat screenWidth = fmin(screenSize.width, screenSize.height);  // 该值为屏幕竖屏下的屏幕宽度
    CGFloat screenHeight = fmax(screenSize.width, screenSize.height); // 该值为屏幕竖屏下的屏幕高度
    // 判断屏幕方向
    UIInterfaceOrientation orientation = [_popupVC preferredInterfaceOrientationForPresentation];
    // 横屏
    if (orientation == UIInterfaceOrientationLandscapeLeft  || orientation == UIInterfaceOrientationLandscapeRight) {
        currentScreenHeight = screenWidth;
    } else {
        currentScreenHeight = screenHeight;
    }
    
    return currentScreenHeight;
}

// 适配标题偏移方向
- (void)updateTitleAttributeText {
    if (_title.length == 0 || !_titleLabel) return;
    
    // 富文本相关配置
    NSRange  attributeRange = NSMakeRange(0, _title.length);
    UIFont  *titleFont      = [UIFont systemFontOfSize:14];
    UIColor *titleTextColor = FSActionSheetColorWithString(FSActionSheetTitleColor);
    CGFloat  lineSpacing = FSActionSheetTitleLineSpacing;
    CGFloat  kernSpacing = FSActionSheetTitleKernSpacing;
    
    NSMutableAttributedString *titleAttributeString = [[NSMutableAttributedString alloc] initWithString:_title];
    NSMutableParagraphStyle *titleStyle = [[NSMutableParagraphStyle alloc] init];
    // 行距
    titleStyle.lineSpacing = lineSpacing;
    // 内容偏移样式
    switch (_contentAlignment) {
        case FSContentAlignmentLeft: {
            titleStyle.alignment = NSTextAlignmentLeft;
            break;
        }
        case FSContentAlignmentCenter: {
            titleStyle.alignment = NSTextAlignmentCenter;
            break;
        }
        case FSContentAlignmentRight: {
            titleStyle.alignment = NSTextAlignmentRight;
            break;
        }
    }
    [titleAttributeString addAttribute:NSParagraphStyleAttributeName value:titleStyle range:attributeRange];
    // 字距
    [titleAttributeString addAttribute:NSKernAttributeName value:@(kernSpacing) range:attributeRange];
    // 字体
    [titleAttributeString addAttribute:NSFontAttributeName value:titleFont range:attributeRange];
    // 颜色
    [titleAttributeString addAttribute:NSForegroundColorAttributeName value:titleTextColor range:attributeRange];
    _titleLabel.attributedText = titleAttributeString;
}

// 点击背景半透明遮罩层隐藏
- (void)backViewGesture {
    [self hideWithCompletion:nil];
}

// 隐藏
- (void)hideWithCompletion:(void(^)())completion {
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _backView.alpha   = 0;
        CGRect newFrame   = self.frame;
        newFrame.origin.y = CGRectGetMaxY(_controllerView.frame);
        self.frame        = newFrame;
    } completion:^(BOOL finished) {
        [[[UIApplication sharedApplication].delegate window] makeKeyWindow];
        if (completion) completion();
        [_backView removeFromSuperview];
        _backView = nil;
        [_tableView removeFromSuperview];
        _tableView = nil;
        [self removeFromSuperview];
        self.popupWindow = nil;
        self.selectedHandler = nil;
    }];
}

#pragma mark - public
/*! @brief 单展示, 不绑定block回调 */
- (void)show {
    [self showWithSelectedCompletion:NULL];
}

/*! @brief 展示并绑定block回调 */
- (void)showWithSelectedCompletion:(FSActionSheetHandler)selectedHandler {
    self.selectedHandler = selectedHandler;
    
    _backView = [[UIView alloc] init];
    _backView.alpha = 0;
    _backView.backgroundColor = [UIColor blackColor];
    _backView.userInteractionEnabled = _hideOnTouchOutside;
    _backView.translatesAutoresizingMaskIntoConstraints = NO;
    [_backView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backViewGesture)]];
    [_controllerView addSubview:_backView];
    [_controllerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_backView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_backView)]];
    [_controllerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_backView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_backView)]];
    
    [self.tableView reloadData];
    // 内容高度
    CGFloat contentHeight = self.tableView.contentSize.height;
    // 适配屏幕高度
    CGFloat contentMaxHeight = CGRectGetHeight(self.popupWindow.frame)*FSActionSheetContentMaxScale;
    if (contentHeight > contentMaxHeight) {
        self.tableView.scrollEnabled = YES;
        contentHeight = contentMaxHeight;
    }
    [_controllerView addSubview:self];
    
    CGFloat selfW = CGRectGetWidth(_controllerView.frame);
    CGFloat selfH = contentHeight;
    CGFloat selfX = 0;
    CGFloat selfY = CGRectGetMaxY(_controllerView.frame);
    self.frame = CGRectMake(selfX, selfY, selfW, selfH);
    
    [self.popupWindow makeKeyAndVisible];
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _backView.alpha   = 0.38;
        CGRect newFrame   = self.frame;
        newFrame.origin.y = CGRectGetMaxY(_controllerView.frame)-selfH;
        self.frame        = newFrame;
    } completion:^(BOOL finished) {
        // constraint
        [_controllerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[self]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)]];
        [_controllerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[self]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)]];
        self.heightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:contentHeight];
        [_controllerView addConstraint:_heightConstraint];
    }];
}

#pragma mark - getter
- (UIWindow *)popupWindow {
    if (_popupWindow) return _popupWindow;
    
    _popupWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _popupWindow.windowLevel = UIWindowLevelStatusBar+1;
    _popupWindow.rootViewController = [[UIViewController alloc] init];
    _popupVC = _popupWindow.rootViewController;
    _controllerView = _popupVC.view;
    
    return _popupWindow;
}
- (UITableView *)tableView {
    if (_tableView) return _tableView;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = self.backgroundColor;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    [_tableView registerClass:[FSActionSheetCell class] forCellReuseIdentifier:kFSActionSheetCellIdentifier];
    
    if (_title.length > 0) {
        _tableView.tableHeaderView = [self headerView];
    }
    
    return _tableView;
}

// tableHeaderView作为title部分
- (UIView *)headerView {
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = FSActionSheetColorWithString(FSActionSheetRowNormalColor);
    
    // 标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.numberOfLines = 0;
    titleLabel.backgroundColor = headerView.backgroundColor;
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [headerView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    // 设置富文本标题内容
    [self updateTitleAttributeText];
    
    // 标题内容边距 (ps: 要修改这个边距不要在这里修改这个labelMargin, 要到配置类中修改 FSActionSheetDefaultMargin, 不然可能出现界面适配错乱).
    CGFloat labelMargin = FSActionSheetDefaultMargin;
    // 计算内容高度
    CGFloat headerHeight = [self heightForHeaderView];
    headerView.frame = CGRectMake(0, 0, CGRectGetWidth(self.popupWindow.frame), headerHeight);
    
    // titleLabel constraint
    [headerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-labelMargin-[titleLabel]-labelMargin-|"
                                                                       options:0.0
                                                                       metrics:@{@"labelMargin" : @(labelMargin)}
                                                                         views:NSDictionaryOfVariableBindings(titleLabel)]];
    [headerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-labelMargin-[titleLabel]"
                                                                       options:0.0
                                                                       metrics:@{@"labelMargin" : @(labelMargin)}
                                                                         views:NSDictionaryOfVariableBindings(titleLabel)]];
    
    return headerView;
}

#pragma mark - setter
- (void)setContentAlignment:(FSContentAlignment)contentAlignment {
    if (_contentAlignment != contentAlignment) {
        _contentAlignment = contentAlignment;
        [self updateTitleAttributeText];
    }
}

#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (section == 1)?1:_items.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return FSActionSheetRowHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return (section == 1)?kFSActionSheetSectionHeight:CGFLOAT_MIN;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FSActionSheetCell *cell = [tableView dequeueReusableCellWithIdentifier:kFSActionSheetCellIdentifier];
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    FSActionSheetCell *sheetCell = (FSActionSheetCell *)cell;
    if (indexPath.section == 0) {
        sheetCell.item = _items[indexPath.row];
        sheetCell.hideTopLine = NO;
        // 当有标题时隐藏第一单元格的顶部线条
        if (indexPath.row == 0 && (!_title || _title.length == 0)) {
            sheetCell.hideTopLine = YES;
        }
    } else {
        // 默认取消的单元格没有附带icon
        FSActionSheetItem *cancelItem = FSActionSheetTitleItemMake(FSActionSheetTypeNormal, _cancelTitle);
        // 如果其它单元格中附带icon的话则添加上默认的取消icon.
        for (FSActionSheetItem *item in _items) {
            if (item.image) {
                cancelItem = FSActionSheetTitleWithImageItemMake(FSActionSheetTypeNormal, [UIImage imageNamed:@"FSActionSheet_cancel"], _cancelTitle);
                break;
            }
        }
        sheetCell.item = cancelItem;
        sheetCell.hideTopLine = YES;
    }
    sheetCell.contentAlignment = _contentAlignment;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 延迟0.1秒隐藏让用户既看到点击效果又不影响体验
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __weak __typeof(&*self)weakSelf = self;
        [self hideWithCompletion:^{
            if (indexPath.section == 0) {
                if (_selectedHandler) {
                    _selectedHandler(indexPath.row);
                }
                if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(FSActionSheet:selectedIndex:)]) {
                    [weakSelf.delegate FSActionSheet:self selectedIndex:indexPath.row];
                }
            }
        }];
    });
}

@end
