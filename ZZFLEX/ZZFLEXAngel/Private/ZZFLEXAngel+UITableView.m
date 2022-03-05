//
//  ZZFLEXAngel+UITableView.m
//  ZZFLEXDemo
//
//  Created by lbk on 2017/12/18.
//  Copyright © 2017年 lbk. All rights reserved.
//

#import "ZZFLEXAngel+UITableView.h"
#import "ZZFLEXAngel+Private.h"
#import "ZZFLEXViewModel+Angel.h"
#import "ZZFLEXSectionModel.h"
#import "ZZFlexibleLayoutViewProtocol.h"
#import "ZZFLEXTableViewEmptyCell.h"
#import "ZZFLEXMacros.h"

@implementation ZZFLEXAngel (UITableView)

//MARK: UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ZZFLEXSectionModel *sectionModel = [self sectionModelAtIndex:section];
    return [sectionModel count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZFLEXSectionModel *sectionModel = [self sectionModelAtIndex:indexPath.section];
    ZZFLEXViewModel *viewModel = [sectionModel objectAtIndex:indexPath.row];
    UITableViewCell<ZZFlexibleLayoutViewProtocol> *cell;
    if (!viewModel.viewClass) {
        ZZFLEXLog(@"!!!!! tableViewCell不存在，将使用空白Cell");
        cell = [tableView dequeueReusableCellWithIdentifier:@"ZZFLEXTableViewEmptyCell" forIndexPath:indexPath];
        [cell setTag:viewModel.viewTag];
        return cell;
    }
    
    cell = [tableView dequeueReusableCellWithIdentifier:viewModel.reuseIdentifier forIndexPath:indexPath];
    [viewModel excuteConfigActionForHostView:tableView itemView:cell sectionCount:sectionModel.count indexPath:indexPath];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ZZFLEXSectionModel *sectionModel = [self sectionModelAtIndex:section];
    ZZFLEXViewModel *viewModel = sectionModel.headerViewModel;
    UITableViewHeaderFooterView *view = [self _headerFooterViewForTableView:tableView viewModel:viewModel section:section];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    ZZFLEXSectionModel *sectionModel = [self sectionModelAtIndex:section];
    ZZFLEXViewModel *viewModel = sectionModel.footerViewModel;
    UITableViewHeaderFooterView *view = [self _headerFooterViewForTableView:tableView viewModel:viewModel section:section];
    return view;
}

- (UITableViewHeaderFooterView *)_headerFooterViewForTableView:(UITableView *)tableView viewModel:(ZZFLEXViewModel *)viewModel section:(NSInteger)section {
    UITableViewHeaderFooterView<ZZFlexibleLayoutViewProtocol> *view;
    if (!viewModel.viewClass) {
        view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ZZFLEXTableViewHeaderFooterView"];
        return view;
    }
    view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:viewModel.reuseIdentifier];
    [viewModel excuteConfigActionForHostView:tableView itemView:view sectionCount:section indexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
    return view;
}

//MARK: UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    ZZFLEXViewModel *viewModel = [self viewModelAtIndexPath:indexPath ];
    [viewModel excuteSelectedActionForHostView:tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZFLEXSectionModel *sectionModel = [self sectionModelAtIndex:indexPath.section];
    ZZFLEXViewModel *model = [sectionModel objectAtIndex:indexPath.row];
    CGFloat height = [model visableSizeForHostView:tableView angel:self sectionInsets:sectionModel.sectionInsets].height;
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    ZZFLEXSectionModel *sectionModel = [self sectionModelAtIndex:section];
    ZZFLEXViewModel *model = sectionModel.headerViewModel;
    CGFloat height = [model visableSizeForHostView:tableView angel:self sectionInsets:sectionModel.sectionInsets].height;
    if (height < 0.0001) {
        height = sectionModel.sectionInsets.top;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    ZZFLEXSectionModel *sectionModel = [self sectionModelAtIndex:section];
    ZZFLEXViewModel *model = sectionModel.footerViewModel;
    CGFloat height = [model visableSizeForHostView:tableView angel:self sectionInsets:sectionModel.sectionInsets].height;
    if (height < 0.0001) {
        height = sectionModel.sectionInsets.bottom;
    }
    return height;
}

@end
