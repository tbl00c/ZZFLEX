//
//  ZZFLEXAngel+UICollectionView.m
//  ZZFLEXDemo
//
//  Created by lbk on 2017/12/14.
//  Copyright © 2017年 lbk. All rights reserved.
//

#import "ZZFLEXAngel+UICollectionView.h"
#import "ZZFLEXViewModel+Angel.h"
#import "ZZFLEXAngel+Private.h"
#import "ZZFLEXSectionModel.h"
#import "ZZFlexibleLayoutSeperatorCell.h"
#import "ZZFLEXMacros.h"

@implementation ZZFLEXAngel (UICollectionView)

//MARK: UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.data.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    ZZFLEXSectionModel *sectionModel = [self sectionModelAtIndex:section];
    return [sectionModel count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZZFLEXSectionModel *sectionModel = [self sectionModelAtIndex:indexPath.section];
    ZZFLEXViewModel *viewModel = [sectionModel objectAtIndex:indexPath.row];

    // 创建\获取cell
    UICollectionViewCell<ZZFlexibleLayoutViewProtocol> *cell;
    if (!viewModel || !viewModel.viewClass) {
        ZZFLEXLog(@"!!!!! CollectionViewCell不存在，将使用空白Cell：%@", viewModel.className);
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZZFlexibleLayoutSeperatorCell" forIndexPath:indexPath];
        [cell setTag:viewModel.viewTag];
        return cell;
    }
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:viewModel.className forIndexPath:indexPath];
    
    // 配置cell
    [viewModel excuteConfigActionForHostView:collectionView itemView:cell sectionCount:sectionModel.count indexPath:indexPath];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView<ZZFlexibleLayoutViewProtocol> *view = nil;
    ZZFLEXSectionModel *sectionModel = [self sectionModelAtIndex:indexPath.section];
    ZZFLEXViewModel *viewModel = [kind isEqual:UICollectionElementKindSectionHeader] ? sectionModel.headerViewModel : sectionModel.footerViewModel;
    if (viewModel) {
        view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:viewModel.className forIndexPath:indexPath];
        [viewModel excuteConfigActionForHostView:collectionView itemView:view sectionCount:indexPath.section indexPath:indexPath];
        return view;
    }
    else {
        view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ZZFlexibleLayoutEmptyHeaderFooterView" forIndexPath:indexPath];
    }
    
    return view;
}

//MARK: UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    ZZFLEXViewModel *viewModel = [self viewModelAtIndexPath:indexPath];
    [viewModel excuteSelectedActionForHostView:collectionView];
}

//MARK: ZZFlexibleLayoutFlowLayoutDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZZFLEXViewModel *viewModel = [self viewModelAtIndexPath:indexPath];
    CGSize size = [viewModel visableSizeForHostView:collectionView];
    return size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    ZZFLEXSectionModel *sectionModel = [self sectionModelAtIndex:section];
    ZZFLEXViewModel *viewModel = sectionModel.headerViewModel;
    CGSize size = [viewModel visableSizeForHostView:collectionView];
    return size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    ZZFLEXSectionModel *sectionModel = [self sectionModelAtIndex:section];
    ZZFLEXViewModel *viewModel = sectionModel.footerViewModel;
    CGSize size = [viewModel visableSizeForHostView:collectionView];
    return size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    ZZFLEXSectionModel *sectionModel = [self sectionModelAtIndex:section];
    return sectionModel.minimumLineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    ZZFLEXSectionModel *sectionModel = [self sectionModelAtIndex:section];
    return sectionModel.minimumInteritemSpacing;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    ZZFLEXSectionModel *sectionModel = [self sectionModelAtIndex:section];
    return sectionModel.sectionInsets;
}

#pragma mark - # ZZFlexibleLayoutFlowLayout
- (UIColor *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout colorForSectionAtIndex:(NSInteger)section
{
    ZZFLEXSectionModel *sectionModel = [self sectionModelAtIndex:section];
    return sectionModel.backgroundColor ? sectionModel.backgroundColor : collectionView.backgroundColor;
}

- (BOOL)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didSectionHeaderPinToVisibleBounds:(NSInteger)section
{
    return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didSectionFooterPinToVisibleBounds:(NSInteger)section
{
    return NO;
}

@end
