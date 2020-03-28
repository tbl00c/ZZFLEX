//
//  ZZFLEXAngelIconTitleCell.h
//  Masonry
//
//  Created by 李伯坤 on 2020/2/6.
//

#import "ZZFLEXAngelBaseCell.h"
#import "ZZFLEXAngelCellImageView.h"
#import "ZZFLEXAngelCellLabel.h"

@interface ZZFLEXAngelIconTitleCell : ZZFLEXAngelBaseCell

@property (nonatomic, strong, readonly) UIView *titleView;
@property (nonatomic, strong, readonly) ZZFLEXAngelCellImageView *iconView;
@property (nonatomic, strong, readonly) ZZFLEXAngelCellLabel *titleLabel;

@end
