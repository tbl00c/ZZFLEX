//
//  ZZFDAlbumCell.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2019/3/20.
//  Copyright © 2019 李伯坤. All rights reserved.
//

#import "ZZFDAlbumCell.h"
#import "UIView+ZZFLEX.h"

@interface ZZFDAlbumCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ZZFDAlbumCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setClipsToBounds:YES];
        self.imageView = self.contentView.addImageView(0)
        .contentMode(UIViewContentModeScaleAspectFill)
        .masonry(^ (MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        })
        .view;
    }
    return self;
}

- (void)setModel:(ZZFDAlbumModel *)model
{
    _model = model;
    @weakify(self);
    [model requestImage:^(ZZFDAlbumModel *model, UIImage *image) {
        @strongify(self);
        if (self.model == model) {
            [self.imageView setImage:image];
        }
    }];
}

@end
