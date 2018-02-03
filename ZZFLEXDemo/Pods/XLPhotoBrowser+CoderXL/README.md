## 1.XLPhotoBrowser描述
一个简单实用的图片浏览器,效果类似微信图片浏览器,支持弹出动画和回缩动画,支持多图浏览,支持本地和网络图片浏览,支持多种属性自定义(支持横竖屏浏览)

### 支持多种图片浏览样式
* 类似微信图片浏览样式XLPhotoBrowserStylePageControl , 底部有个pagecontrol显示图片索引
* 类似微博图片浏览样式XLPhotoBrowserStyleIndexLabel , 上面有个UILabel显示图片索引
* 简单样式XLPhotoBrowserStyleSimple , 上面有UILabel显示图片索引,左下部分有个保存按钮,可以保存当前图片

![首页](http://upload-images.jianshu.io/upload_images/1455933-a62df375111ab953.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)![XLPhotoBrowserStylePageControl](http://upload-images.jianshu.io/upload_images/1455933-b07d243342f25e77.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)![XLPhotoBrowserStyleIndexLabel](http://upload-images.jianshu.io/upload_images/1455933-2800147a8423a6e2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)![XLPhotoBrowserStyleSimple](http://upload-images.jianshu.io/upload_images/1455933-7acc97cad1d5e72d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 支持长按手势弹出多功能选择框,类似微博微信中的效果
![长按图片弹出多功能选择框](http://upload-images.jianshu.io/upload_images/1455933-13cc70c17b279ace.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
###	其他效果图:
![XLPhotoBrowserDemo.gif](http://upload-images.jianshu.io/upload_images/1455933-597296ec3f5594a0.gif?imageMogr2/auto-orient/strip)![XLPhotoBrowserDemo2.gif](http://upload-images.jianshu.io/upload_images/1455933-1b3f77d0f122d42e.gif?imageMogr2/auto-orient/strip)

## 2. 安装方法
#### 2.1 第一种方法:  使用cocoapods自动安装

```
pod 'XLPhotoBrowser+CoderXL'

```

#### 2.2 第二种方法 :

*  2.2.1 下载示例Demo
*  2.2.2 把里面的XLPhotoBrowser文件夹拖到你的项目中(注意: 里面用到了一些第三方的类库,如果你的项目中已经使用了这些库,视情况删除)
*  2.2.3 如果你的项目中没有用到SDWebImage框架,把图中SDWebImage文件夹也一起拖到你的工程中


![Paste_Image.png](http://upload-images.jianshu.io/upload_images/1455933-526e4542398d4597.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


#### 注意:
*  XLPhotoBrowser依赖于SDWebImage框架4.0.0版本,`由于SDWebImage4.0版本对API进行了修改,所以不兼容SDWebImage4.0以下版本`


## 3. 使用说明
### 3.1基本使用(提供2种传递数据的方法:图片以数组形式批量传递 和 数据源方法分开传递每一个位置的图片数据)
##### 方法一:一行代码进入图片浏览器 在某些场景,例如只是想浏览一组本地/网络图片,你可以这样使用:
```
    // 传入图片数据源,直接进行图片浏览
    // 传入图片数据源数组self.images 可以是UIImage对象数组 ,可以是ALAsset对象, 也可以是图片的NSURL链接 , 或者是可以变成NSURL链接的NSString对象数组

    [XLPhotoBrowser showPhotoBrowserWithImages:self.images currentImageIndex:0];

```

##### 方法二：如果上面直接提供图片数组的方式不适合,你可以考虑实现数据源方法,提供数据
*	数据源方法提供了三个,不同的需求效果需要搭配不同的方法使用.根据每个方法的注释说明和项目的需求来决定具体要实现哪几个方法

```
/**
 进入图片浏览器
 */
- (void)clickImage:(UITapGestureRecognizer *)tap
{
    [XLPhotoBrowser showPhotoBrowserWithCurrentImageIndex:tap.view.tag imageCount:self.images.count datasource:self];
}

#pragma mark    -   XLPhotoBrowserDatasource

/**
 *  返回这个位置的占位图片 , 也可以是原图
 *  如果不实现此方法,会默认使用placeholderImage
 *
 *  @param browser 浏览器
 *  @param index   位置索引
 *
 *  @return 占位图片
 */
- (UIImage *)photoBrowser:(XLPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return self.images[index];
}

/**
 *  返回指定位置图片的UIImageView,用于做图片浏览器弹出放大和消失回缩动画等
 *  如果没有实现这个方法,没有回缩动画,如果传过来的view不正确,可能会影响回缩动画效果
 *
 *  @param browser 浏览器
 *  @param index   位置索引
 *
 *  @return 展示图片的容器视图,如UIImageView等
 */
- (UIView *)photoBrowser:(XLPhotoBrowser *)browser sourceImageViewForIndex:(NSInteger)index
{
    return self.scrollView.subviews[index];
}

/**
 *  返回指定位置的高清图片URL
 *  如果你要显示更高质量的图片,可以通过这个方法传递网络/本地图片路径实现效果
 *
 *  @param browser 浏览器
 *  @param index   位置索引
 *
 *  @return 返回高清大图索引
 */
- (NSURL *)photoBrowser:(XLPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    return [NSURL URLWithString:self.urlStrings[index]];
}
```
#### ps:下面的示例代码中如非必要,统一用第一种方式传递图片数组来展示

### 3.2进阶使用说明(自定义多种属性等)

*	如何进行网络图片浏览
一行代码进入浏览,传递网络图片的地址数组进去即可

```
    // 1. NSURL数组
//    NSMutableArray *URLArray = [NSMutableArray array];
//    for (NSString *urlString in self.urlStrings) {
//        NSURL *URL = [NSURL URLWithString:urlString];
//        [URLArray addObject:URL];
//    }
//    [XLPhotoBrowser showPhotoBrowserWithImages:URLArray currentImageIndex:0];

    // 2.可以变成NSURL链接的NSString对象数组
    [XLPhotoBrowser showPhotoBrowserWithImages:self.urlStrings currentImageIndex:0];

```

或者用数据源方式,实现photoBrowser: highQualityImageURLForIndex:方法

```
- (void)clickImage:(UITapGestureRecognizer *)tap
{
    [XLPhotoBrowser showPhotoBrowserWithCurrentImageIndex:tap.view.tag imageCount:self.images.count datasource:self];
}

#pragma mark    -   XLPhotoBrowserDatasource

// 可以不实现此方法
- (UIImage *)photoBrowser:(XLPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return self.images[index];
}

- (NSURL *)photoBrowser:(XLPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    return [NSURL URLWithString:self.urlStrings[index]];
}

```

* 	如何添加长按手势并自定义选择菜单
	*	获取XLPhotoBrowser实例对象,调用setActionSheetWithTitle:delegate:cancelButtonTitle:deleteButtonTitle:otherButtonTitles:方法
	*	同时在 XLPhotoBrowserDelegate代理方法中监听到用户的选择

```
/**
 *  浏览图片
 *
 */
- (void)clickImage:(UITapGestureRecognizer *)tap
{
    XLPhotoBrowser *browser = [XLPhotoBrowser showPhotoBrowserWithImages:self.images currentImageIndex:tap.view.tag];
    browser.browserStyle = XLPhotoBrowserStyleIndexLabel; // 微博样式
    
    // 设置长按手势弹出的地步ActionSheet数据,不实现此方法则没有长按手势
    [browser setActionSheetWithTitle:@"这是一个类似微信/微博的图片浏览器组件" delegate:self cancelButtonTitle:nil deleteButtonTitle:@"删除" otherButtonTitles:@"发送给朋友",@"保存图片",@"收藏",@"投诉",nil];
}

#pragma mark    -   XLPhotoBrowserDelegate

- (void)photoBrowser:(XLPhotoBrowser *)browser clickActionSheetIndex:(NSInteger)actionSheetindex currentImageIndex:(NSInteger)currentImageIndex
{
    // do something yourself
    switch (actionSheetindex) {
        case 4: // 删除
        {
            NSLog(@"点击了actionSheet索引是:%zd , 当前展示的图片索引是:%zd",actionSheetindex,currentImageIndex);
            [self.images removeObjectAtIndex:currentImageIndex];
            [self resetScrollView];
        }
            break;
        case 1: // 保存
        {
            NSLog(@"点击了actionSheet索引是:%zd , 当前展示的图片索引是:%zd",actionSheetindex,currentImageIndex);
            [browser saveCurrentShowImage];
        }
            break;
        default:
        {
            NSLog(@"点击了actionSheet索引是:%zd , 当前展示的图片索引是:%zd",actionSheetindex,currentImageIndex);
        }
            break;
    }
}

```

*  如何选择浏览器样式
	*	获取到实例对象以后,设置browserStyle属性即可

```
    XLPhotoBrowser *browser = [XLPhotoBrowser showPhotoBrowserWithImages:self.images currentImageIndex:tap.view.tag];
    browser.browserStyle = XLPhotoBrowserStyleIndexLabel; // 微博样式

```

*  如何修改pagecontrol为缩放动画样式 
	*  仅在XLPhotoBrowserStylePageControl样式中有效, 在XLPhotoBrowserStyleIndexLabel样式无效

```
    // 自定义pageControl的一些属性
    browser.pageDotColor = [UIColor purpleColor]; ///< 此属性针对动画样式的pagecontrol无效
    browser.currentPageDotColor = [UIColor greenColor];
    browser.pageControlStyle = XLPhotoBrowserPageControlStyleClassic;///< 修改底部pagecontrol的样式为系统样式,默认是弹性动画的样式

```

*  如何实现类似微信那样点击图片进入浏览器时的图片放大和退出浏览时图片缩放的过渡动画
	*	实现数据源方法中的photoBrowser:sourceImageViewForIndex:方法,传递图片的容器视图,才可以做过渡动画  
		
```
#pragma mark    -   XLPhotoBrowserDatasource

- (UIImage *)photoBrowser:(XLPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return self.images[index];
}

- (UIView *)photoBrowser:(XLPhotoBrowser *)browser sourceImageViewForIndex:(NSInteger)index
{
    return self.scrollView.subviews[index];
}

```

*  如何使用XLPhotoBrowserConfig,
	*  如何开启调试模式,输出格式化的提示信息
		* 打开在XLPhotoBrowserConfig中的这个代码即可 //#define XLPhotoBrowserDebug 1  
	*  还可以在这里修改很多样式属性,如:修改浏览器的背景色/图片间隔等 ,使用方式很简单,具体的使用就不在这里赘述

## 4. 更新日志
    *   1.2.0
        *   1. 支持横竖屏适配(设备没有锁定方向,且项目配置支持横屏才可以触发横屏浏览模式)
        *   2. 更新SDWebImage到4.0.0 , 由于SDWebImage4.0版本对API进行了修改,所以不兼容SDWebImage4.0以下版本
        *   3. 修复图片下载进度条等已知bug
    *   1.1.0 
        *   1. 优化框架结构，XLPhotoBrowser内部维护一个优先级为maxfloat的UIWindow，避免不同的项目会因为窗口问题造成XLPhotoBrowser显示不正确等问题
        *   2. 修改FSActionSheet源码，修复长按弹出ActionSheet显示在图片后面等问题
        *   3. 优化图片放大缩小处理逻辑，修复已知bug


## 5. 喜欢的话,就给作者一个star ,你可以通过下面的方式联系到我
*  QQ群 : 579572313 (有什么问题,欢迎进群讨论提问)
*  邮箱 : coder_xl@163.com

## 6. 常见问题，可以参考这篇帖子[XLPhotoBrowser常见问题汇总](http://www.jianshu.com/p/2be8e90ff0dc)

