//
//  ZZFLEXAngelCellLabel.h
//  Masonry
//
//  Created by 李伯坤 on 2020/2/3.
//

#import <UIKit/UIKit.h>
#import "ZZFLEXAngelItemText.h"

@interface ZZFLEXAngelCellLabel : UIView

@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong, readonly) ZZFLEXAngelItemText *textModel;

- (void)setTextModel:(ZZFLEXAngelItemText *)textModel defaultStyle:(ZZFLEXAngelItemTextStyle *)defaultStyle;

@end
