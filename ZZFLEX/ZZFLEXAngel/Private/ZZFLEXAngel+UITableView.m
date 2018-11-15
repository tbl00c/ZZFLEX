//
//  ZZFLEXAngel+UITableView.m
//  ZZFLEXDemo
//
//  Created by lbk on 2017/12/18.
//  Copyright © 2017年 lbk. All rights reserved.
//

#import "ZZFLEXAngel+UITableView.h"
#import "ZZFLEXAngel+Private.h"
#import "ZZFlexibleLayoutSectionModel.h"
#import "ZZFlexibleLayoutViewProtocol.h"
#import "ZZFLEXTableViewEmptyCell.h"
#import "ZZFLEXMacros.h"

@implementation ZZFLEXAngel (UITableView)

//MARK: UICollectionViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:section];
    return [sectionModel count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:indexPath.section];
    ZZFlexibleLayoutViewModel *model = [sectionModel objectAtIndex:indexPath.row];
    
    UITableViewCell<ZZFlexibleLayoutViewProtocol> *cell;
    if (!model || !model.viewClass) {
        ZZFLEXLog(@"!!!!! tableViewCell不存在，将使用空白Cell：%@", model.className);
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZZFLEXTableViewEmptyCell class]) forIndexPath:indexPath];
        [cell setTag:model.viewTag];
        return cell;
    }
    
    cell = [tableView dequeueReusableCellWithIdentifier:model.className forIndexPath:indexPath];
    
    if ([cell respondsToSelector:@selector(setViewDataModel:)]) {
        [cell setViewDataModel:model.dataModel];
    }
    if ([cell respondsToSelector:@selector(setViewDelegate:)]) {
        [cell setViewDelegate:model.delegate ? model.delegate : self];
    }
    if ([cell respondsToSelector:@selector(setViewEventAction:)]) {
        [cell setViewEventAction:model.eventAction];
    }
    if ([cell respondsToSelector:@selector(viewIndexPath:sectionItemCount:)]) {
        [cell viewIndexPath:indexPath sectionItemCount:sectionModel.count];
    }
    [cell setTag:model.viewTag];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView<ZZFlexibleLayoutViewProtocol> *view = nil;
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:section];
    ZZFlexibleLayoutViewModel *viewModel = sectionModel.headerViewModel;
    if (viewModel && viewModel.viewClass) {
        view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:viewModel.className];
        
        if ([view respondsToSelector:@selector(setViewDataModel:)]) {
            [view setViewDataModel:viewModel.dataModel];
        }
        if ([view respondsToSelector:@selector(setViewEventAction:)]) {
            [view setViewEventAction:viewModel.eventAction];
        }
        if ([view respondsToSelector:@selector(setViewDelegate:)]) {
            [view setViewDelegate:viewModel.delegate ? viewModel.delegate : self];
        }
        if ([view respondsToSelector:@selector(viewIndexPath:sectionItemCount:)]) {
            [view viewIndexPath:nil sectionItemCount:sectionModel.count];
        }
        [view setTag:viewModel.viewTag];
    }
    
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UITableViewHeaderFooterView<ZZFlexibleLayoutViewProtocol> *view = nil;
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:section];
    ZZFlexibleLayoutViewModel *viewModel = sectionModel.footerViewModel;
    if (viewModel && viewModel.viewClass) {
        view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:viewModel.className];
        
        if ([view respondsToSelector:@selector(setViewDataModel:)]) {
            [view setViewDataModel:viewModel.dataModel];
        }
        if ([view respondsToSelector:@selector(setViewEventAction:)]) {
            [view setViewEventAction:viewModel.eventAction];
        }
        if ([view respondsToSelector:@selector(setViewDelegate:)]) {
            [view setViewDelegate:viewModel.delegate ? viewModel.delegate : self];
        }
        if ([view respondsToSelector:@selector(viewIndexPath:sectionItemCount:)]) {
            [view viewIndexPath:nil sectionItemCount:sectionModel.count];
        }
        [view setTag:viewModel.viewTag];
    }
    
    return view;
}
//MARK: UICollectionViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    ZZFlexibleLayoutViewModel *viewModel = [self viewModelAtIndexPath:indexPath];
    if (viewModel.selectedAction) {
        viewModel.selectedAction(viewModel.dataModel);
    }
}

//MARK: ZZFlexibleLayoutFlowLayoutDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZZFlexibleLayoutViewModel *model = [self viewModelAtIndexPath:indexPath];
    CGFloat height = model ? model.viewSize.height : 0;
    height = height < 0 ? tableView.frame.size.height * -height : height;
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:section];
    ZZFlexibleLayoutViewModel *model = sectionModel.headerViewModel;
    CGFloat height = model ? model.viewSize.height : 0;
    height = height < 0 ? tableView.frame.size.height * -height : height;
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:section];
    ZZFlexibleLayoutViewModel *model = sectionModel.footerViewModel;
    CGFloat height = model ? model.viewSize.height : 0;
    height = height < 0 ? tableView.frame.size.height * -height : height;
    return height;
}

@end
