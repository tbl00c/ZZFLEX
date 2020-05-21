//
//  ZZFLEXTableViewController.m
//  ZZFLEX
//
//  Created by libokun on 2020/3/19.
//

#import "ZZFLEXTableViewController.h"
#import "ZZFLEXMacros.h"
#import "UIView+ZZFLEX.h"
#import "ZZFLEXAngel+UITableView.h"

#define     ZZFLEXVC_ANGEL_CHAIN_METHOD(methodName, returnType, paramType)  \
- (returnType (^)(paramType))methodName \
{   \
    return self.angel.methodName;   \
}

#define     ZZFLEXVC_ANGEL_METHOD(methodName, returnType)  \
- (returnType)methodName \
{   \
    return [self.angel methodName];   \
}

@interface ZZFLEXTableViewController ()

@end

@implementation ZZFLEXTableViewController

- (instancetype)init
{
    if (self = [super init]) {
        _tableViewStyle = UITableViewStylePlain;
        _angel = [[ZZFLEXAngel alloc] init];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:self.tableViewStyle];
    [self.angel setHostView:_tableView];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.view addSubview:self.tableView];
}

- (void)dealloc
{
    ZZFLEXLog(@"Dealloc: %@", NSStringFromClass([self class]));
}

#pragma mark 页面刷新
/// 刷新页面
- (void)reloadView
{
    [self.angel reloadView];
}

#pragma mark - # 整体
ZZFLEXVC_ANGEL_CHAIN_METHOD(clear, BOOL, void)
ZZFLEXVC_ANGEL_CHAIN_METHOD(clearAllItems, BOOL, void)
ZZFLEXVC_ANGEL_CHAIN_METHOD(clearAllCells, BOOL, void)
ZZFLEXVC_ANGEL_CHAIN_METHOD(upadte, BOOL, void)
ZZFLEXVC_ANGEL_CHAIN_METHOD(upadteAllItems, BOOL, void)
ZZFLEXVC_ANGEL_CHAIN_METHOD(upadteAllCells, BOOL, void)
ZZFLEXVC_ANGEL_CHAIN_METHOD(isEmpty, BOOL, void)

#pragma mark - # Section操作
ZZFLEXVC_ANGEL_CHAIN_METHOD(addSection, ZZFLEXAngelSectionChainModel *, NSInteger)
ZZFLEXVC_ANGEL_CHAIN_METHOD(insertSection, ZZFLEXAngelSectionInsertChainModel *, NSInteger)
ZZFLEXVC_ANGEL_CHAIN_METHOD(sectionForTag, ZZFLEXAngelSectionEditChainModel *, NSInteger)
ZZFLEXVC_ANGEL_CHAIN_METHOD(deleteSection, BOOL, NSInteger)
ZZFLEXVC_ANGEL_CHAIN_METHOD(hasSection, BOOL, NSInteger)

#pragma mark - # Section View 操作
ZZFLEXVC_ANGEL_CHAIN_METHOD(setHeader, ZZFLEXAngelViewChainModel *, Class)
ZZFLEXVC_ANGEL_CHAIN_METHOD(setXibHeader, ZZFLEXAngelViewChainModel *, Class)

ZZFLEXVC_ANGEL_CHAIN_METHOD(setFooter, ZZFLEXAngelViewChainModel *, Class)
ZZFLEXVC_ANGEL_CHAIN_METHOD(setXibFooter, ZZFLEXAngelViewChainModel *, Class)

#pragma mark - # Cell 操作
ZZFLEXVC_ANGEL_CHAIN_METHOD(addCell, ZZFLEXAngelViewChainModel *, Class)
ZZFLEXVC_ANGEL_CHAIN_METHOD(addXibCell, ZZFLEXAngelViewChainModel *, Class)

ZZFLEXVC_ANGEL_CHAIN_METHOD(addCells, ZZFLEXAngelViewBatchChainModel *, Class)
ZZFLEXVC_ANGEL_CHAIN_METHOD(addXibCells, ZZFLEXAngelViewBatchChainModel *, Class)

- (ZZFLEXAngelViewChainModel *(^)(CGSize size, UIColor *color))addSeperatorCell;
{
    return self.angel.addSeperatorCell;
}

ZZFLEXVC_ANGEL_CHAIN_METHOD(insertCell, ZZFLEXAngelViewInsertChainModel *, Class)
ZZFLEXVC_ANGEL_CHAIN_METHOD(insertXibCell, ZZFLEXAngelViewInsertChainModel *, Class)

ZZFLEXVC_ANGEL_CHAIN_METHOD(insertCells, ZZFLEXAngelViewBatchInsertChainModel *, Class)
ZZFLEXVC_ANGEL_CHAIN_METHOD(insertXibCells, ZZFLEXAngelViewBatchInsertChainModel *, Class)

ZZFLEXVC_ANGEL_METHOD(deleteCell, ZZFLEXAngelViewEditChainModel *)
ZZFLEXVC_ANGEL_METHOD(deleteCells, ZZFLEXAngelViewBatchEditChainModel *)

ZZFLEXVC_ANGEL_METHOD(updateCell, ZZFLEXAngelViewEditChainModel *)
ZZFLEXVC_ANGEL_METHOD(updateCells, ZZFLEXAngelViewBatchEditChainModel *)

ZZFLEXVC_ANGEL_METHOD(hasCell, ZZFLEXAngelViewEditChainModel *)

#pragma mark - # DataModel 数据源获取
ZZFLEXVC_ANGEL_METHOD(dataModel, ZZFLEXAngelViewEditChainModel *)
ZZFLEXVC_ANGEL_METHOD(dataModelArray, ZZFLEXAngelViewBatchEditChainModel *)

#pragma mark - # View & data
ZZFLEXVC_ANGEL_METHOD(hostView, __kindof UIScrollView *)
ZZFLEXVC_ANGEL_METHOD(data, NSMutableArray *)

#pragma mark - ## Kernel
//MARK: UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.angel numberOfSectionsInTableView:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.angel tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.angel tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self.angel tableView:tableView viewForHeaderInSection:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [self.angel tableView:tableView viewForFooterInSection:section];
}

//MARK: UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.angel tableView:tableView didSelectRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.angel tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [self.angel tableView:tableView heightForHeaderInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return [self.angel tableView:tableView heightForFooterInSection:section];
}

@end
