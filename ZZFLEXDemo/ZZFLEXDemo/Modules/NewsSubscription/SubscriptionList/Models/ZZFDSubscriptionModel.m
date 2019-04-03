//
//  ZZFDSubscriptionModel.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2018/2/4.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "ZZFDSubscriptionModel.h"

ZZFDSubscriptionListShowModel *__createSubListShowModel(NSString *title, NSString *detail)
{
    ZZFDSubscriptionListShowModel *model = [[ZZFDSubscriptionListShowModel alloc] init];
    model.title = title;
    model.detail = detail;
    return model;
}

@implementation ZZFDSubscriptionModel

- (void)setPlatform:(ZZFDSubscriptionPlatform)platform
{
    if (_platform == platform) {
        return;
    }
    _platform = platform;
    self.language = @"全部";
    self.cate = nil;
}

- (NSString *)platformName
{
    return [[self class] getPlatformNameByType:self.platform];
}

- (NSArray<ZZFDSubscriptionListShowModel *> *)listShowModelArray
{
    NSMutableArray *data = [[NSMutableArray alloc] init];
    [data addObject:__createSubListShowModel(@"平台", self.platformName)];
    if (self.languageArray.count > 0) {
        [data addObject:__createSubListShowModel(@"语言", self.language)];
    }
    if (self.cateString.length > 0) {
        [data addObject:__createSubListShowModel(@"关注类别", self.cateString)];
    }
    [data addObject:__createSubListShowModel(@"关键词", self.keyword)];
    [data addObject:__createSubListShowModel(@"作者等级", self.levelString)];
    [data addObject:__createSubListShowModel(@"通知", self.noti ? @"已开启" : @"未开启")];
    return data;
}

- (NSString *)levelString
{
    NSString *levelString;
    if (self.minLevel.integerValue > 0) {
        if (self.minLevel.integerValue == self.maxLevel.integerValue) {
            levelString = [NSString stringWithFormat:@"%@级", self.minLevel];
        }
        else if (self.maxLevel.integerValue < 10) {
            levelString = [NSString stringWithFormat:@"%@-%@级", self.minLevel, self.maxLevel];
        }
        else {
            levelString = [NSString stringWithFormat:@"%@级以上", self.minLevel];
        }
    }
    else if (self.maxLevel.integerValue < 10) {
        levelString = [NSString stringWithFormat:@"%@级以下", self.maxLevel];
    }
    else {
        levelString = @"不限制";
    }
    return levelString;
}

+ (NSString *)getPlatformNameByType:(ZZFDSubscriptionPlatform)type
{
    switch (type) {
        case ZZFDSubscriptionPlatformIOS:
            return @"iOS";
            break;
        case ZZFDSubscriptionPlatformAndroid:
            return @"Android";
            break;
        case ZZFDSubscriptionPlatformWeb:
            return @"Web";
            break;
        case ZZFDSubscriptionPlatformServer:
            return @"Server";
            break;
        default:
            break;
    }
    return @"";
}

- (NSArray *)languageArray
{
    switch (self.platform) {
        case ZZFDSubscriptionPlatformIOS:
            return @[@"Objective-C", @"Swift"];
            break;
        case ZZFDSubscriptionPlatformServer:
            return @[@"Java", @"Python", @"PHP", @"Ruby"];
            break;
        default:
            break;
    }
    return nil;
}

- (NSString *)cateString
{
    if (self.cate.count > 0) {
        NSString *cate = [self.cate componentsJoinedByString:@", "];
        return cate;
    }
    return @"";
}

- (NSArray *)cateArray
{
    switch (self.platform) {
        case ZZFDSubscriptionPlatformIOS:
            return @[@"瀑布流", @"图文轮排", @"手势交互", @"菜单", @"键盘", @"音频视频", @"数据持久化", @"分段选择", @"进度条", @"标签", @"网络", @"搜索框", @"地图", @"网页", @"选择器", @"滑杆", @"特效"];
            break;
        case ZZFDSubscriptionPlatformAndroid:
            return @[@"对话框", @"侧滑返回", @"GirdView", @"列表", @"视图切换", @"Layouts", @"多页切换", @"菜单", @"SurfaceView", @"多媒体", @"通知", @"网络", @"数据库", @"地图", @"网页", @"引导页", @"特效",  @"图文轮排", @"进度条", @"其他"];
            break;
        case ZZFDSubscriptionPlatformServer:
            return @[@"大数据", @"分布式", @"人工智能", @"搜索", @"消息队列", @"运维系统", @"微架构"];
            break;
        case ZZFDSubscriptionPlatformWeb:
            return @[@"浏览器兼容", @"性能优化", @"Http协议", @"Javascript", @"HTML5", @"CSS3", @"安全", @"调试工具"];
            break;
        default:
            break;
    }
    return nil;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    ZZFDSubscriptionModel *model = [[ZZFDSubscriptionModel allocWithZone:zone] init];
    model.subId = self.subId;
    model.platform = self.platform;
    model.language = self.language;
    model.cate = self.cate;
    model.keyword = self.keyword;
    model.minLevel = self.minLevel;
    model.maxLevel = self.maxLevel;
    model.noti = self.noti;
    return model;
}

@end

@implementation ZZFDSubscriptionListShowModel

@end
