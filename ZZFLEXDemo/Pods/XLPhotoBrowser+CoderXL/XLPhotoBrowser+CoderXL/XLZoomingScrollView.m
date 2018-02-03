//
//  XLZoomingScrollView.m
//  XLPhotoBrowserDemo
//
//  Created by Liushannoon on 16/7/15.
//  Copyright © 2016年 LiuShannoon. All rights reserved.
//

#import "XLZoomingScrollView.h"
#import "XLProgressView.h"
#import "SDImageCache.h"

@interface XLZoomingScrollView () <UIScrollViewDelegate>
{
   UIScrollView *_scrollview;
}

@property (nonatomic , strong) UIImageView  *photoImageView;
@property (nonatomic , strong) XLProgressView *progressView;
@property (nonatomic , strong) UILabel *stateLabel;
@property (nonatomic, assign) BOOL hasLoadedImage;
@property (nonatomic , strong) NSURL  *imageURL;

@end

@implementation XLZoomingScrollView

#pragma mark    -   set / get

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    self.progressView.progress = progress;
    if ([self.zoomingScrollViewdelegate respondsToSelector:@selector(zoomingScrollView:imageLoadProgress:)]) {
        [self.zoomingScrollViewdelegate zoomingScrollView:self imageLoadProgress:progress];
    }
}

- (UIImageView *)imageView
{
    return self.photoImageView;
}

- (UIImage *)currentImage
{
    return self.photoImageView.image;
}

- (UIImageView *)photoImageView
{
    if (_photoImageView == nil) {
        _photoImageView = [[UIImageView alloc] init];
        _photoImageView.backgroundColor = [UIColor clearColor];
    }
    
    return _photoImageView;
}

- (UIScrollView *)scrollview
{
    if (!_scrollview) {
        _scrollview = [[UIScrollView alloc] init];
        [_scrollview addSubview:self.photoImageView];
        _scrollview.delegate = self;
        _scrollview.clipsToBounds = YES;
        _scrollview.showsVerticalScrollIndicator = NO;
        _scrollview.showsHorizontalScrollIndicator = NO;
    }
    return _scrollview;
}

- (UILabel *)stateLabel
{
    if (_stateLabel == nil) {
        _stateLabel = [[UILabel alloc] init];
        _stateLabel.text = XLPhotoBrowserLoadNetworkImageFail;
        _stateLabel.font = [UIFont systemFontOfSize:16];
        _stateLabel.textColor = [UIColor whiteColor];
        _stateLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        _stateLabel.layer.cornerRadius = 5;
        _stateLabel.clipsToBounds = YES;
        _stateLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _stateLabel;
}

- (XLProgressView *)progressView
{
    if (_progressView == nil) {
        _progressView = [[XLProgressView alloc] init];
    }
    return _progressView;
}

#pragma mark    -   initial UI

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initial];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initial];
    }
    return self;
}

/**
 *  初始化
 */
- (void)initial
{
    [self addSubview:self.scrollview];

    UITapGestureRecognizer *singleTapBackgroundView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapBackgroundView:)];
    UITapGestureRecognizer *doubleTapBackgroundView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapBackgroundView:)];
    doubleTapBackgroundView.numberOfTapsRequired = 2;
    [singleTapBackgroundView requireGestureRecognizerToFail:doubleTapBackgroundView];
    [self addGestureRecognizer:singleTapBackgroundView];
    [self addGestureRecognizer:doubleTapBackgroundView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.stateLabel.bounds = CGRectMake(0, 0, 160, 30);
    self.stateLabel.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    self.progressView.bounds = CGRectMake(0, 0, 100, 100);
    self.progressView.xl_centerX = self.xl_width * 0.5;
    self.progressView.xl_centerY = self.xl_height * 0.5;
    self.scrollview.frame = self.bounds;
    
    [self setMaxAndMinZoomScales];
}

#pragma mark    -   UIScrollViewDelegate
    
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    self.photoImageView.center = [self centerOfScrollViewContent:scrollView];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.photoImageView;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
    self.scrollview.scrollEnabled = YES;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    self.scrollview.userInteractionEnabled = YES;
}

#pragma mark    -   private method - 手势处理,缩放图片

- (CGPoint)centerOfScrollViewContent:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    CGPoint actualCenter = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                       scrollView.contentSize.height * 0.5 + offsetY);
    return actualCenter;
}

- (CGRect)zoomRectForScale:(CGFloat)scale withCenter:(CGPoint)center
{
    CGFloat height = self.frame.size.height / scale;
    CGFloat width  = self.frame.size.width / scale;
    CGFloat x = center.x - width * 0.5;
    CGFloat y = center.y - height * 0.5;
    return CGRectMake(x, y, width, height);
}

- (void)singleTapBackgroundView:(UITapGestureRecognizer *)singleTap
{
    if (self.zoomingScrollViewdelegate && [self.zoomingScrollViewdelegate respondsToSelector:@selector(zoomingScrollView:singleTapDetected:)]) {
        [self.zoomingScrollViewdelegate zoomingScrollView:self singleTapDetected:singleTap];
    }
}

- (void)doubleTapBackgroundView:(UITapGestureRecognizer *)doubleTap
{
    if (!self.hasLoadedImage) {
        return;
    }
    self.scrollview.userInteractionEnabled = NO;
    
    
    if (self.scrollview.zoomScale > self.scrollview.minimumZoomScale) {
        [self.scrollview setZoomScale:self.scrollview.minimumZoomScale animated:YES];
    } else {
        CGPoint point = [doubleTap locationInView:doubleTap.view];
        CGFloat touchX = point.x;
        CGFloat touchY = point.y;
        touchX *= 1/self.scrollview.zoomScale;
        touchY *= 1/self.scrollview.zoomScale;
        touchX += self.scrollview.contentOffset.x;
        touchY += self.scrollview.contentOffset.y;
        CGRect zoomRect = [self zoomRectForScale:self.scrollview.maximumZoomScale withCenter:CGPointMake(touchX, touchY)];
        [self.scrollview zoomToRect:zoomRect animated:YES];
    }
}

- (void)resetZoomScale
{
    self.scrollview.maximumZoomScale = 1.0;
    self.scrollview.minimumZoomScale = 1.0;
}

#pragma mark    -   public method

/**
 *  显示图片
 *
 *  @param image 图片
 */
- (void)setShowImage:(UIImage *)image
{
    self.photoImageView.image = image;
    [self setMaxAndMinZoomScales];
    [self setNeedsLayout];
    self.progress = 1.0;
    self.hasLoadedImage = YES;
}

/**
 *  显示图片
 *
 *  @param url         图片的高清大图链接
 *  @param placeholder 占位的缩略图 / 或者是高清大图都可以
 */
- (void)setShowHighQualityImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    if (!url) {
        [self setShowImage:placeholder];
        return;
    }
    
    UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[url absoluteString]];
    if (cacheImage) {
        [self setShowImage:cacheImage];
        return;
    }
    
    self.photoImageView.image = placeholder;
    [self setMaxAndMinZoomScales];
    
    __weak typeof(self) weakSelf = self;

    [self addSubview:self.progressView];;
    self.progressView.mode = XLProgressViewProgressMode;
    self.imageURL = url;

    // TODO 失败点击重新下载功能
    [weakSelf.photoImageView sd_setImageWithURL:url placeholderImage:placeholder options:SDWebImageRetryFailed| SDWebImageLowPriority| SDWebImageHandleCookies progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            if ([strongSelf.imageURL isEqual:targetURL] && expectedSize > 0) {
                strongSelf.progress = (CGFloat)receivedSize / expectedSize ;
//                NSLog(@"targetURL %@ , strongSelf %@ , strongSelf.imageURL = %@ , progress = %f",targetURL , strongSelf , strongSelf.imageURL,strongSelf.progress);
            }
        });
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf.progressView removeFromSuperview];
        if (error) {
            [strongSelf setMaxAndMinZoomScales];
            [strongSelf addSubview:strongSelf.stateLabel];
            XLPBLog(@"加载图片失败 , 图片链接imageURL = %@ , 错误信息: %@ ,检查是否开启允许HTTP请求",imageURL,error);
        } else {
            [strongSelf.stateLabel removeFromSuperview];
            [UIView animateWithDuration:0.25 animations:^{
                [strongSelf setShowImage:image];
                [strongSelf.photoImageView setNeedsDisplay];
                [strongSelf setMaxAndMinZoomScales];
            }];
        }
    }];
}

/**
 *  根据图片和屏幕比例关系,调整最大和最小伸缩比例
 */
- (void)setMaxAndMinZoomScales
{
    // self.photoImageView的初始位置
    UIImage *image = self.photoImageView.image;
    if (image == nil || image.size.height==0) {
        return;
    }
    CGFloat imageWidthHeightRatio = image.size.width / image.size.height;
    self.photoImageView.xl_width = self.xl_width;
    self.photoImageView.xl_height = self.xl_width / imageWidthHeightRatio;
    self.photoImageView.xl_x = 0;
    if (self.photoImageView.xl_height > XLScreenH) {
        self.photoImageView.xl_y = 0;
        self.scrollview.scrollEnabled = YES;
    } else {
        self.photoImageView.xl_y = (XLScreenH - self.photoImageView.xl_height ) * 0.5;
        self.scrollview.scrollEnabled = NO;
    }
    self.scrollview.maximumZoomScale = MAX(XLScreenH / self.photoImageView.xl_height, 3.0);
    self.scrollview.minimumZoomScale = 1.0;
    self.scrollview.zoomScale = 1.0;
    self.scrollview.contentSize = CGSizeMake(self.photoImageView.xl_width, MAX(self.photoImageView.xl_height, XLScreenH));
}

/**
 *  重用，清理资源
 */
- (void)prepareForReuse
{
//    NSLog(@"prepareForReuse: strongSelf %@ , strongSelf.imageURL = %@ , progress = %f" , self , self.imageURL,self.progress);
    [self setMaxAndMinZoomScales];
    self.progress = 0;
    self.photoImageView.image = nil;
    self.hasLoadedImage = NO;
    [self.stateLabel removeFromSuperview];
    [self.progressView removeFromSuperview];
}

@end
