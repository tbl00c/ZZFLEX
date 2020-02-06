//
//  ZZFLEXAngelBaseCell.h
//  Masonry
//
//  Created by 李伯坤 on 2020/2/3.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "ZZFLEXViewExtension.h"
#import "ZZFLEXAngelItem.h"
#import "ZZFlexibleLayoutViewProtocol.h"
#import "ZZFLEXAngeWingAppearance.h"

@interface ZZFLEXAngelBaseCell : UICollectionViewCell <ZZFlexibleLayoutViewProtocol>

@property (nonatomic, strong) ZZFLEXAngelItem *item;

@property (nonatomic, strong, readonly) UIView *angelView;

@end
