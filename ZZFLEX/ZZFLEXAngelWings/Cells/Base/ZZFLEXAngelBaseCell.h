//
//  ZZFLEXAngelBaseCell.h
//  Masonry
//
//  Created by 李伯坤 on 2020/2/3.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "ZZFLEXMacros.h"
#import "ZZFLEXViewExtension.h"
#import "ZZFLEXAngelItem.h"
#import "ZZFlexibleLayoutViewProtocol.h"
#import "ZZFLEXAngeWingAppearance.h"

@interface ZZFLEXAngelBaseCell : UICollectionViewCell <ZZFlexibleLayoutViewProtocol>

@property (nonatomic, strong) ZZFLEXAngelItem *item;

@property (nonatomic, strong, readonly) UIView *angelView;

@property (nonatomic, copy) id (^viewEventAction)(NSInteger eventType, ZZFLEXAngelItem *item);

@end
