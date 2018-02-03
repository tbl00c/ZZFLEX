//
//  XLPhotoBrowserTypeDefine.h
//  XLPhotoBrowserDemo
//
//  Created by XL on 2017/5/22.
//  Copyright © 2017年 LiuShannoon. All rights reserved.
//

/**
 *  图片浏览器的样式
 */
typedef NS_ENUM(NSUInteger, XLPhotoBrowserStyle){
    /**
     *  长按图片弹出功能组件,底部一个PageControl
     */
    XLPhotoBrowserStylePageControl = 1,
    /**
     * 长按图片弹出功能组件,顶部一个索引UILabel
     */
    XLPhotoBrowserStyleIndexLabel = 2,
    /**
     * 没有长按图片弹出的功能组件,顶部一个索引UILabel,底部一个保存图片按钮
     */
    XLPhotoBrowserStyleSimple = 3
};

/**
 *  pageControl的位置
 */
typedef NS_ENUM(NSUInteger, XLPhotoBrowserPageControlAliment){
    /**
     * pageControl在右边
     */
    XLPhotoBrowserPageControlAlimentRight = 1,
    /**
     *  pageControl 中间
     */
    XLPhotoBrowserPageControlAlimentCenter = 2,
    XLPhotoBrowserPageControlAlimentLeft = 3
};

/**
 *  pageControl的样式
 */
typedef NS_ENUM(NSUInteger, XLPhotoBrowserPageControlStyle){
    /**
     * 系统自带经典样式
     */
    XLPhotoBrowserPageControlStyleClassic = 1,
    /**
     *  动画效果pagecontrol
     */
    XLPhotoBrowserPageControlStyleAnimated = 2,
    /**
     *  不显示pagecontrol
     */
    XLPhotoBrowserPageControlStyleNone = 3
    
};
