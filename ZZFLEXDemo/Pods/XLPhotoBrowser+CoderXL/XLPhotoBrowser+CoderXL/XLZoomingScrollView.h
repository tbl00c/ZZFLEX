//
//  XLZoomingScrollView.h
//  XLPhotoBrowserDemo
//
//  Created by Liushannoon on 16/7/15.
//  Copyright © 2016年 LiuShannoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+XLExtension.h"

@class XLZoomingScrollView;

@protocol XLZoomingScrollViewDelegate <NSObject>

/**
 *  单击图像时调用
 *
 *  @param zoomingScrollView 图片缩放视图
 *  @param singleTap             用户单击手势
 */
- (void)zoomingScrollView:(XLZoomingScrollView *)zoomingScrollView singleTapDetected:(UITapGestureRecognizer *)singleTap;

@optional
/**
 *  图片加载进度
 *
 *  @param zoomingScrollView 图片缩放视图
 *  @param progress 加载进度 , 0 - 1.0
 */
- (void)zoomingScrollView:(XLZoomingScrollView *)zoomingScrollView imageLoadProgress:(CGFloat)progress;

@end


@interface XLZoomingScrollView : UIView

/**
 *  zoomingScrollViewdelegate
 */
@property (nonatomic , weak) id <XLZoomingScrollViewDelegate> zoomingScrollViewdelegate;
/**
 *  图片加载进度
 */
@property (nonatomic, assign) CGFloat progress;
/**
 *  展示的图片
 */
@property (nonatomic , strong , readonly) UIImage  *currentImage;
/**
 *  展示图片的UIImageView视图  ,  回缩的动画用
 */
@property (nonatomic , weak , readonly) UIImageView *imageView;
@property (nonatomic , strong , readonly) UIScrollView *scrollview;

/**
 *  显示图片
 *
 *  @param url         图片的高清大图链接
 *  @param placeholder 占位的缩略图 / 或者是高清大图都可以
 */
- (void)setShowHighQualityImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;
/**
 *  显示图片
 *
 *  @param image 图片
 */
- (void)setShowImage:(UIImage *)image;
/**
 *  调整尺寸
 */
- (void)setMaxAndMinZoomScales;
/**
 *  重用，清理资源
 */
- (void)prepareForReuse;

@end
