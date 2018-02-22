# ZZFLEX
一个iOS UI敏捷开发框架，基于UIKit实现，主要包含常用控件的链式API拓展、一个数据驱动的列表框架、一个事件处理队列。

## 功能模块

目前ZZFLEX主要包含以下5个功能模块：

* **UIView+ZZFLEX**：为UIKit中常用的控件增加了链式API拓展；
* **ZZFlexibleLayoutViewController**：基于UICollectionView的数据驱动的列表页框架；
* **ZZFLEXAngel**：ZZFlexibleLayoutViewController核心逻辑抽离出的一个列表控制器，更加轻量，支持tableView、collectionView；
* **ZZFLEXEditExtension**：为ZZFLEXAngel和ZZFlexibleLayoutViewController增加了处理编辑类页面的能力；
* **ZZFLEXRequestQueue**：一个事件处理队列，设计的初衷为解决复杂页面多接口请求时、UI刷新顺序的问题。

### UIView+ZZFLEX

通常，我们往视图上添加一个按钮的流程是这样的：

```
UIButton *button = [[UIButton alloc] init];
// 设置样式
[button setBackgroundColor:[UIColor orangeColor]];
[button setTitle:@"hello" forState:UIControlStateNormal];
[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
[button setTitle:@"world" forState:UIControlStateHighlighted];
[button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
// 设置事件（需要额外的事件处理方法）
[button addTarget:self action:@selector(buttonDown) forControlEvents:UIControlEventTouchDown];
[button addTarget:self action:@selector(buttonUp) forControlEvents:UIControlEventTouchUpInside];
// 设置圆角和边线
[button.layer setMasksToBounds:YES];
[button.layer setCornerRadius:3.0f];
[button.layer setBorderWidth:1.0f];
[button.layer setBorderColor:[UIColor redColor].CGColor];
// 添加到视图
[self.view addSubview:button];
// 设置约束
[button mas_makeConstraints:^(MASConstraintMaker *make) {
    make.size.mas_equalTo(CGSizeMake(80, 35));
    make.center.mas_equalTo(0);
}];
```

UIView+ZZFLEX对这些API进行了链式封装，使用链式API可以更加连贯快捷的进行控件的属性设置、Masonry布局和事件处理

```
UIButton *button = self.view.addButton(1001)
// 设置样式
.title(@"hello").titleColor([UIColor blackColor])
.titleHL(@"world").titleColorHL([UIColor redColor])
// 设置圆角和边线
.cornerRadius(3.0f).border(1, [UIColor redColor])
// 设置约束
.masonry(^(MASConstraintMaker *make) {
    make.size.mas_equalTo(CGSizeMake(80, 35));
    make.center.mas_equalTo(0);
})
// 设置事件
.eventBlock(UIControlEventTouchDown, ^(UIButton *sender){
    NSLog(@"touch down");
})
.eventBlock(UIControlEventTouchUpInside, ^(UIButton *sender){
    NSLog(@"touch up");
})
.view;
```

如需对控件的属性进行编辑，可以这样写：

```
button.zz_make.frame(CGRectMake(0, 0, 100, 40)).title(@"hi").titleColor(@"how are u");
```

如需单独创建一个控件，不添加到视图上：

```
UIButton *button = UIButton.zz_create(1001).title(@"hello").titleHL(@"world");
```

目前，UIView+ZZFLEX已添加链式API的控件有：

* UIView
* UIImageView
* UILabel
* UIControl
* UITextField
* UIButton
* UISwitch
* UIScrollView
* UITextView
* UITableView
* UICollectionView

### ZZFlexibleLayoutViewController

ZZFlexibleLayoutViewController继承自UIViewController，是一个基于collectionView实现的数据驱动的列表页框架，可大幅降低复杂列表界面实现和维护的难度。

我们知道collectionView在使用过程中，各种代理方法重复度高，并且越复杂的界面各种代理方法中的代码就越复杂、越难以维护，一旦设计不好还容易出现性能问题。很多设计模式和第三方库从代码结构和数据缓存等各个角度做出了优化，也取得了一定的效果。但ZZFLEX不同的是，它将从根源解决这一个问题。

首先，和之前不同的是，使用它，我们在实现列表的cell、header、footer时，需要额外实现一个协议—ZZFlexibleLayoutViewProtocol：


```
/**
 * 所有要加入ZZFlexibleLayoutViewController、ZZFLEXAngel的view/cell都要实现此协议
 * 
 * 除获取大小/高度两个方法需要二选一之外，其余都可按需选择实现
 */

@protocol ZZFlexibleLayoutViewProtocol <NSObject>

@optional;
/**
 * 获取cell/view大小，除非手动调用update方法，否则只调用一次，与viewHeightByDataModel二选一
 */
+ (CGSize)viewSizeByDataModel:(id)dataModel;
/**
 * 获取cell/view高度，除非手动调用update方法，否则只调用一次，与viewSizeByDataModel二选一
 */
+ (CGFloat)viewHeightByDataModel:(id)dataModel;


/**
 *  设置cell/view的数据源
 */
- (void)setViewDataModel:(id)dataModel;

/**
 *  设置cell/view的delegate对象
 */
- (void)setViewDelegate:(id)delegate;

/**
 *  设置cell/view的actionBlock
 */
- (void)setViewEventAction:(id (^)(NSInteger actionType, id data))eventAction;

/**
 * 当前视图的indexPath，所在section元素数（目前仅cell调用）
 */
- (void)viewIndexPath:(NSIndexPath *)indexPath sectionItemCount:(NSInteger)count;

@end
```

cell/view实现这个协议带来的好处就是，我们无需再关心collectionView中的的各种代理方法了，框架自动处理了这一切。即collectionView各种回调中，将通过调用ZZFlexibleLayoutViewProtocol协议中的方法，与cell进行通信。

它使得一个复杂界面的构建就如同拼图一般，我们只需一件件的add需要的模块，即可绘制出我们想要的界面。

```
// 清空所有数据
self.clear();

// 添加section
self.addSection(ZZFDGoodSectionTypeHeader)
// section样式设置
.sectionInsets(UIEdgeInsetsMake(15, 15, 15, 15))
.minimumLineSpacing(15).minimumInteritemSpacing(15)
// section背景色支持
.backgrounColor([UIColor orangeColor]);
    
// 添加cell
self.addCell(NSStringFromClass([ZZFDGoodAreaCell class]))
.toSection(ZZFDGoodSectionTypeHeader).withDataModel(listModel)
// 内部事件，也可通过delegate的模式
// .delegate(self)
.eventAction(^ id(NSInteger eventType, id data) {
    NSLog(@"cell 内部事件，类型：%ld", eventType);
    return nil;
})
// cell选中事件
.selectedAction(^ (id data) {
    NSLog(@"cell 选中事件");
});

// 刷新界面
[self reloadView];
```

目前主要支持的功能：
 
| | 添加 | 插入 | 获取 | 批量添加 | 批量插入 | 批量获取 | 编辑 | 删除 | 清空子数据 | 更新高度 |
|:-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: |
| section | ✔️ | ✔️ | ✔️ | | | | ✔️ | ✔️ | ✔️ | ✔️ |
| cell | ✔️ | ✔️ | ✔️ | ✔️ | ✔️ | ✔️ |  | ✔️ |  | ✔️ |
| header/footer | ✔️ | | ✔️ | | | |  | ✔️ | | ✔️ |

使用方法简述：

```
NSInteger sectionTag = 1001;
NSInteger cellTag = 100101;
NSArray *data = @[@"1", @"2", @"3", @"4"];
    
// 插入section，条件可以是beforeSection、afterSection、toIndex
self.insertSection(sectionTag).beforeSection(1001).minimumInteritemSpacing(5).minimumLineSpacing(5);
    
// 批量添加cell
self.addCells(@"ACell").withDataModelArray(data).toSection(sectionTag).delegate(self.dataModel).viewTag(cellTag);
    
// 批量插入cell，条件可以是beforeCell、afterCell、toIndex
self.insertCells(@"BCell").withDataModelArray(data).toSection(sectionTag).beforeCell(cellTag);
    
// 获取并编辑section
self.sectionForTag(sectionTag).backgrounColor([UIColor yellowColor]);
    
// 删除指定section中的某一个cell
self.sectionForTag(sectionTag).deleteCellByTag(cellTag);
// 批量删除指定section中的符合条件的cell
self.sectionForTag(sectionTag).deleteAllCellsByTag(cellTag);
    
// 删除全局符合条件的cell，条件可以是cellTag、dataModel、viewCclassName、indexPath
self.deleteCell.byViewTag(cellTag);
// 批量删除全局符合条件的cell，条件可以是cellTag、dataModel、viewCclassName
self.deleteCells.byDataModel(data[0]);
    
// 更新指定section中items的高度
self.sectionForTag(sectionTag).update();
// 全局更新指定条件的cell，条件可以是cellTag、dataModel、viewCclassName、indexPath
self.updateCell.atIndexPath([NSIndexPath indexPathForRow:0 inSection:0]);
    
// 清空指定section中的items
self.sectionForTag(sectionTag).clear();
// 清空指定section中的cells，保留headerFooter
self.sectionForTag(sectionTag).clearCells();
```

### ZZFLEXAngel

ZZFlexibleLayoutViewController为列表页的开发带来的优异的拓展性和可维护性，但它是一个VC级别的实现，在一些业务场景下还是不够灵活的。

ZZFLEXAngel是ZZFlexibleLayoutViewController核心思想和设计提炼而成的一个“列表控制中心”，它与页面和列表控件是完全解耦的。

使用它，我们只需通过任意collectionView或tableView来初始化一个ZZFLEXAngel实例（本质是将列表页的dataSource和delegate指向ZZFLEXAngel或其子类的实例），然后就可以通过这个实例、和ZZFlexibleLayoutViewController中一样，使用那些好用的API了。

```
// 创建列表视图
UITableView *tableView = self.view.addTableView(1)
.frame(self.view.bounds)
.backgroundColor([UIColor colorGrayBG])
.tableFooterView([UIView new])
.view;

// 根据列表视图初始化angel，hostView支持UITableView和UICollectionView
ZZFLEXAngel *angel = [[ZZFLEXAngel alloc] initWithHostView:self.tableView];

// 添加列表元素
angel.addSection(1);
angel.addCell(@"ACell").toSection(1);

// 刷新列表
[tableView reloadData];

```

### ZZFLEXEditExtension

此拓展使得ZZFlexibleLayoutViewController和ZZFLEXAngel具有了处理编辑页面的能力，其主要原理为规范了编辑类页面处理流程，并使用一个额外的模型来控制它：

初始标准数据模型 -> 经ZZFLEXEditModel封装的数据 -> UI展现 -> 用户编辑 -> 输入合法性判断 -> 标准数据模型 -> 导出数据

详见Demo。

### ZZFLEXRequestQueue

一些复杂的页面中会存在多个异步数据请求（net、db等），然而同时发起的异步请求，其结果的返回顺序是不确定的，这样会导致UI展示顺序的不确定性，很多情况下这是我们不希望看到的。

ZZFLEXRequestQueue的核心思想是“将一次数据请求的过程封装成对象”，它可以保证在此业务场景下，按队列顺序加载展示UI。

详见Demo。

## 如何使用
### 1、直接导入方式
将项目下载到本地后，把ZZFlexibleLayoutFramework拖入到你的项目中，即可正常使用。

### 2、CocoaPods方式

```
Pod 'ZZFLEX', :git => 'git@github.com:tbl00c/ZZFLEX.git'
```

## 其他

使用中的任何问题，欢迎提issure，也可与我交流：libokun@126.com
