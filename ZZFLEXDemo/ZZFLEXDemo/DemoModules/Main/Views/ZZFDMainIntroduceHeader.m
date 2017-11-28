//
//  ZZFDMainIntroduceHeader.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/11/28.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFDMainIntroduceHeader.h"
#import "UIView+ZZFLEX.h"

#define     FOUNT_INTRO_TITLE           [UIFont systemFontOfSize:13]

NSAttributedString *__zz_create_main_introduce_title(NSString *title)
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:title
                                                                                         attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13],
                                                                                                      NSForegroundColorAttributeName : [UIColor grayColor]
                                                                                                      }];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:4];
    [paragraphStyle setParagraphSpacing:6];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedString.string.length)];
    return attributedString;
}

@interface ZZFDMainIntroduceHeader ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ZZFDMainIntroduceHeader

#pragma mark - # ZZFlexibleLayoutViewProtocol
+ (CGSize)viewSizeByDataModel:(NSString *)dataModel
{
    if (!dataModel) {
        return CGSizeZero;
    }
    // 此方法在Cell添加后，只会执行一次，除非你调用刷新高度的方法。
    NSAttributedString *attrStr = __zz_create_main_introduce_title(dataModel);
    CGFloat height = [attrStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 25, MAXFLOAT)
                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                           context:nil].size.height;
    return CGSizeMake(SCREEN_WIDTH, height + 30);
}

- (void)setViewDataModel:(id)dataModel
{
    if (dataModel) {
        NSAttributedString *attrStr = __zz_create_main_introduce_title(dataModel);
        [self.titleLabel setAttributedText:attrStr];
    }
}

#pragma mark - # Cell Init
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {        
        self.titleLabel = self.addLabel(1)
        .numberOfLines(0)
        .masonry(^ (MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.bottom.mas_equalTo(-10);
            make.right.mas_lessThanOrEqualTo(-10);
        })
        .view;
    }
    return self;
}


@end
