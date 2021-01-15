//
//  ZZCollectionViewChainModel.m
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZCollectionViewChainModel.h"
#import "ZZFlexibleLayoutFlowLayout.h"

#define     ZZFLEXC_CV_IMP(ZZParamType, methodName)      ZZFLEXC_IMP(ZZCollectionViewChainModel, UICollectionView, ZZParamType, methodName)
#define     ZZFLEXC_SV_IMP(ZZParamType, methodName)      ZZFLEXC_IMP(ZZCollectionViewChainModel, UICollectionView, ZZParamType, methodName)

@implementation ZZCollectionViewChainModel

+ (Class)viewClass
{
    return [UICollectionView class];
}

ZZFLEXC_CV_IMP(UICollectionViewLayout *, collectionViewLayout)
ZZFLEXC_CV_IMP(id<UICollectionViewDelegate>, delegate)
ZZFLEXC_CV_IMP(id<UICollectionViewDataSource>, dataSource)

ZZFLEXC_CV_IMP(BOOL, allowsSelection)
ZZFLEXC_CV_IMP(BOOL, allowsMultipleSelection)

#pragma mark - UIScrollView
ZZFLEXC_SV_IMP(CGSize, contentSize)
ZZFLEXC_SV_IMP(CGPoint, contentOffset)
ZZFLEXC_SV_IMP(UIEdgeInsets, contentInset)

ZZFLEXC_SV_IMP(BOOL, bounces)
ZZFLEXC_SV_IMP(BOOL, alwaysBounceVertical)
ZZFLEXC_SV_IMP(BOOL, alwaysBounceHorizontal)

ZZFLEXC_SV_IMP(BOOL, pagingEnabled)
ZZFLEXC_SV_IMP(BOOL, scrollEnabled)

ZZFLEXC_SV_IMP(BOOL, showsHorizontalScrollIndicator)
ZZFLEXC_SV_IMP(BOOL, showsVerticalScrollIndicator)

ZZFLEXC_SV_IMP(BOOL, scrollsToTop)

@end

@implementation UICollectionView (ZZFLEX_EX)

+ (ZZCollectionViewChainModel *(^)(NSInteger tag))zz_create
{
    return ^ZZCollectionViewChainModel *(NSInteger tag){
        ZZFlexibleLayoutFlowLayout *layout = [[ZZFlexibleLayoutFlowLayout alloc] init];
        layout.minimumInteritemSpacing = layout.minimumLineSpacing = 0;
        layout.headerReferenceSize = layout.footerReferenceSize = CGSizeZero;
        layout.sectionInset = UIEdgeInsetsZero;
        UICollectionView *view = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        return [[ZZCollectionViewChainModel alloc] initWithTag:tag andView:view];
    };
}

- (ZZCollectionViewChainModel *)zz_setup
{
    return [[ZZCollectionViewChainModel alloc] initWithTag:self.tag andView:self];
}

@end
