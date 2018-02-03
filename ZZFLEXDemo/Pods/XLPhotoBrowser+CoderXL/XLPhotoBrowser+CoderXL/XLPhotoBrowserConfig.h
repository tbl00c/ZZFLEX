//
//  XLPhotoBrowserConfig.h
//  XLPhotoBrowserDemo
//
//  Created by Liushannoon on 16/7/16.
//  Copyright © 2016年 LiuShannoon. All rights reserved.
//

#import "UIView+XLExtension.h"
#import "UIImage+XLExtension.h"
#import "XLPhotoBrowserTypeDefine.h"

#import <SDWebImage/UIImageView+WebCache.h>

#define XLPhotoBrowserDebug 1
//是否开启断言调试模式
#define IsOpenAssertDebug 1
#define XLPhotoBrowserVersion @"1.2.0"

/**
 *  进度视图类型类型
 */
typedef NS_ENUM(NSUInteger, XLProgressViewMode){
    /**
     *  圆环形
     */
    XLProgressViewModeLoopDiagram = 1,
    /**
     *  圆饼型
     */
    XLProgressViewModePieDiagram = 2
};

// 图片保存成功提示文字
#define XLPhotoBrowserSaveImageSuccessText @" ^_^ 保存成功 ";
// 图片保存失败提示文字
#define XLPhotoBrowserSaveImageFailText @" >_< 保存失败 ";
// 网络图片加载失败的提示文字
#define XLPhotoBrowserLoadNetworkImageFail @">_< 图片加载失败"
#define XLPhotoBrowserLoadingImageText @" >_< 图片加载中,请稍后 ";

// browser背景颜色
#define XLPhotoBrowserBackgrounColor [UIColor colorWithRed:0 green:0 blue:0 alpha:0.95]
// browser 图片间的margin
#define XLPhotoBrowserImageViewMargin 10
// browser中显示图片动画时长
#define XLPhotoBrowserShowImageAnimationDuration 0.4f
// browser中显示图片动画时长
#define XLPhotoBrowserHideImageAnimationDuration 0.4f

// 图片下载进度指示进度显示样式（XLProgressViewModeLoopDiagram 环形，XLProgressViewModePieDiagram 饼型）
#define XLProgressViewProgressMode XLProgressViewModeLoopDiagram
// 图片下载进度指示器背景色
#define XLProgressViewBackgroundColor [UIColor clearColor]
// 图片下载进度指示器圆环/圆饼颜色
#define XLProgressViewStrokeColor [UIColor whiteColor]
// 图片下载进度指示器内部控件间的间距
#define XLProgressViewItemMargin 10
// 圆环形图片下载进度指示器 环线宽度
#define XLProgressViewLoopDiagramLineWidth 8

#define XLPBLog(...) XLFormatLog(__VA_ARGS__)

#if XLPhotoBrowserDebug
#define XLFormatLog(...)\
{\
NSString *string = [NSString stringWithFormat:__VA_ARGS__];\
NSLog(@"\n===========================\n===========================\n=== XLPhotoBrowser' Log ===\n提示信息:%@\n所在方法:%s\n所在行数:%d\n===========================\n===========================",string,__func__,__LINE__);\
}

#define XLLogFunc NSLog(@"%s",__func__)

#else
#define XLFormatLog(...)
#define XLLogFunc 
#endif



