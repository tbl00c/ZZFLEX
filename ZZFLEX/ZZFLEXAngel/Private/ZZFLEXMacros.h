//
//  ZZFLEXMacros.h
//  ZZFLEXDemo
//
//  Created by lbk on 2017/11/27.
//  Copyright © 2017年 lbk. All rights reserved.
//

#ifndef ZZFLEXMacros_h
#define ZZFLEXMacros_h

#define     ZZFLEXLog(fmt, ...)     NSLog((@"[ZZFLEX]" fmt), ##__VA_ARGS__)

#define     BORDER_WIDTH_1PX        ([[UIScreen mainScreen] scale] > 0.0 ? 1.0 / [[UIScreen mainScreen] scale] : 1.0)

/*
 *  注册Cell 到 hostView
 */
static inline void RegisterHostViewCell(__kindof UIScrollView *hostView, Class viewClass, NSString *reuseIdentifier) {
    if ([hostView isKindOfClass:[UITableView class]]) {
        [(UITableView *)hostView registerClass:viewClass forCellReuseIdentifier:reuseIdentifier];
    } else if ([hostView isKindOfClass:[UICollectionView class]]) {
        [(UICollectionView *)hostView registerClass:viewClass forCellWithReuseIdentifier:reuseIdentifier];
    }
}

/*
 *  注册XibCell 到 hostView
 */
static inline void RegisterHostViewXibCell(__kindof UIScrollView *hostView, Class viewClass, NSString *reuseIdentifier) {
    UINib *nib = [UINib nibWithNibName:reuseIdentifier bundle:[NSBundle bundleForClass:viewClass]];
    if ([hostView isKindOfClass:[UITableView class]]) {
        [(UITableView *)hostView registerNib:nib forCellReuseIdentifier:reuseIdentifier];
    } else if ([hostView isKindOfClass:[UICollectionView class]]) {
        [(UICollectionView *)hostView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
    }
}

/*
 *  注册ReusableView 到 hostView
 */
static inline void RegisterHostViewReusableView(__kindof UIScrollView *hostView, NSString *kind, Class viewClass, NSString *reuseIdentifier) {
    if ([hostView isKindOfClass:[UITableView class]]) {
        [(UITableView *)hostView registerClass:viewClass forHeaderFooterViewReuseIdentifier:reuseIdentifier];
    } else if ([hostView isKindOfClass:[UICollectionView class]]) {
        [(UICollectionView *)hostView registerClass:viewClass forSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifier];
    }
}

/*
 *  注册XibReusableView 到 hostView
 */
static inline void RegisterHostViewXibReusableView(__kindof UIScrollView *hostView, NSString *kind, Class viewClass, NSString *reuseIdentifier) {
    UINib *nib = [UINib nibWithNibName:reuseIdentifier bundle:[NSBundle bundleForClass:viewClass]];
    if ([hostView isKindOfClass:[UITableView class]]) {
        [(UITableView *)hostView registerNib:nib forHeaderFooterViewReuseIdentifier:reuseIdentifier];
    } else if ([hostView isKindOfClass:[UICollectionView class]]) {
        [(UICollectionView *)hostView registerNib:nib forSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifier];
    }
}

#endif /* ZZFLEXMacros_h */
