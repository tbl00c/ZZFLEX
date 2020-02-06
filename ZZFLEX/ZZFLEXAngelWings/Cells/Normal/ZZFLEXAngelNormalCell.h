//
//  ZZFLEXAngelNormalCell.h
//  Masonry
//
//  Created by 李伯坤 on 2020/2/3.
//

#import "ZZFLEXAngelBaseCell.h"
#import "ZZFLEXAngelCellImageView.h"
#import "ZZFLEXAngelCellLabel.h"

@interface ZZFLEXAngelNormalCell : ZZFLEXAngelBaseCell

@property (nonatomic, strong) ZZFLEXAngelCellImageView *iconView;
@property (nonatomic, strong) ZZFLEXAngelCellLabel *titleLabel;
@property (nonatomic, strong) ZZFLEXAngelCellLabel *subTitleLabel;
@property (nonatomic, strong) UIImageView *arrowView;

@end
