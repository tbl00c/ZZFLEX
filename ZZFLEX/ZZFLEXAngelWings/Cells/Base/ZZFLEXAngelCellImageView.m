//
//  ZZFLEXAngelCellImageView.m
//  Masonry
//
//  Created by 李伯坤 on 2020/2/3.
//

#import "ZZFLEXAngelCellImageView.h"
#import "ZZFLEXViewExtension.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "ZZFLEXAngeWingAppearance.h"

@implementation ZZFLEXAngelCellImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.imageView = self.addImageView(0)
        .masonry(^ (__kindof UIView *view, MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        })
        .view;
    }
    return self;
}

- (void)setImageModel:(ZZFLEXAngelItemImage *)imageModel defaultStyle:(ZZFLEXAngelItemImageStyle *)defaultStyle
{
    _imageModel = imageModel;
    if (imageModel.enable) {
        if (imageModel.image) {
            [self.imageView setImage:imageModel.image];
        }
        else if (imageModel.imageName) {
            [self.imageView setImage:[UIImage imageNamed:imageModel.imageName]];
        }
        else if (imageModel.imageUrl) {
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageModel.imageUrl]];
        }
        
        ZZFLEXAngelItemImageStyle *style = imageModel.style;
        self.imageView.zz_setup.hidden(NO)
        .cornerRadius(style.cornorRadius ? style.cornorRadius.doubleValue : defaultStyle.cornorRadius.doubleValue)
        .updateMasonry(^(__kindof UIView *sender, MASConstraintMaker *make) {
            if (!CGSizeEqualToSize(CGSizeZero, style.size)) {
                make.size.mas_equalTo(style.size);
            }
            else {
                make.size.mas_equalTo(defaultStyle.size);
            }
        });
    }
    else {
        self.imageView.zz_setup.hidden(YES)
        .updateMasonry(^(__kindof UIView *sender, MASConstraintMaker *make) {
            make.size.mas_equalTo(0);
        });
    }
}

@end
