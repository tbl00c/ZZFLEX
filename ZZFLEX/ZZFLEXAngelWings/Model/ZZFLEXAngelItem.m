//
//  ZZFLEXAngelItem.m
//  ZZFLEX
//
//  Created by 李伯坤 on 2020/1/31.
//

#import "ZZFLEXAngelItem.h"

@implementation ZZFLEXAngelItem

- (void)setIconUrl:(NSString *)iconUrl
{
    if (!_iconModel) {
        _iconModel = zzflex_createAngelWebImage(iconUrl);
    }
    else {
        _iconModel.imageUrl = iconUrl;
    }
}
- (NSString *)iconUrl
{
    return _iconModel.imageUrl;
}

- (void)setIconName:(NSString *)iconName
{
    if (!_iconModel) {
        _iconModel = zzflex_createAngelImage(iconName);
    }
    else {
        _iconModel.imageName = iconName;
    }
}
- (NSString *)iconName
{
    return _iconModel.imageName;
}

- (void)setTitle:(NSString *)title
{
    if (!_titleModel) {
        _titleModel = zzflex_createAngelText(title);
    }
    else {
        _titleModel.text = title;
    }
}
- (NSString *)title
{
    return _titleModel.text;
}

- (void)setSubTitle:(NSString *)subTitle
{
    if (!_subTitleModel) {
        _subTitleModel = zzflex_createAngelText(subTitle);
    }
    else {
        _subTitleModel.text = subTitle;
    }
}
- (NSString *)subTitle
{
    return _subTitleModel.text;
}

- (void)setMessage:(NSString *)message
{
    if (!_messageModel) {
        _messageModel = zzflex_createAngelText(message);
    }
    else {
        _messageModel.text = message;
    }
}
- (NSString *)message
{
    return _messageModel.text;
}

- (void)setImageUrl:(NSString *)imageUrl
{
    if (!_imageModel) {
        _imageModel = zzflex_createAngelImage(imageUrl);
    }
    else {
        _imageModel.imageUrl = imageUrl;
    }
}
- (NSString *)imageUrl
{
    return _imageModel.imageUrl;
}

- (ZZFLEXAngelItemStyle *)style
{
    if (!_style) {
        _style = [[ZZFLEXAngelItemStyle alloc] init];
    }
    return _style;
}

@end
