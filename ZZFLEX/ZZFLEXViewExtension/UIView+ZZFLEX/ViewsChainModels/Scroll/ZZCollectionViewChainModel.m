//
//  ZZCollectionViewChainModel.m
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZCollectionViewChainModel.h"
#import "ZZFlexibleLayoutFlowLayout.h"

#define     ZZFLEXC_IMP_VIEW_TYPE   UICollectionView

@implementation _ZZCollectionViewChainModel

+ (Class)viewClass {
    return [UICollectionView class];
}

ZZFLEXC_IMP(UICollectionViewLayout *, collectionViewLayout)
ZZFLEXC_IMP(id<UICollectionViewDelegate>, delegate)
ZZFLEXC_IMP(id<UICollectionViewDataSource>, dataSource)

ZZFLEXC_IMP(BOOL, allowsSelection)
ZZFLEXC_IMP(BOOL, allowsMultipleSelection)

@end

@implementation ZZCollectionViewChainModel

@end

@implementation UICollectionView (ZZFLEX_EX)

+ (ZZCollectionViewChainModel *(^)(NSInteger tag))zz_create {
    return ^ZZCollectionViewChainModel *(NSInteger tag){
        ZZFlexibleLayoutFlowLayout *layout = [[ZZFlexibleLayoutFlowLayout alloc] init];
        layout.minimumInteritemSpacing = layout.minimumLineSpacing = 0;
        layout.headerReferenceSize = layout.footerReferenceSize = CGSizeZero;
        layout.sectionInset = UIEdgeInsetsZero;
        UICollectionView *view = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        return [[ZZCollectionViewChainModel alloc] initWithTag:tag andView:view];
    };
}

- (ZZCollectionViewChainModel *)zz_setup {
    return [[ZZCollectionViewChainModel alloc] initWithTag:self.tag andView:self];
}

@end
