//
//  ZZFLEXAngelCellImageView.h
//  Masonry
//
//  Created by 李伯坤 on 2020/2/3.
//

#import <UIKit/UIKit.h>
#import "ZZFLEXAngelItemImage.h"

@interface ZZFLEXAngelCellImageView : UIView

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong, readonly) ZZFLEXAngelItemImage *imageModel;

- (void)setImageModel:(ZZFLEXAngelItemImage *)imageModel defaultStyle:(ZZFLEXAngelItemImageStyle *)defaultStyle;

@end
