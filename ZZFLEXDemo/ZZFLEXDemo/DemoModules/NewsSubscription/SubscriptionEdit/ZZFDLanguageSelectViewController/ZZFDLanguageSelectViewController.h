//
//  ZZFDLanguageSelectViewController.h
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2018/2/5.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "ZZFlexibleLayoutViewController.h"

@interface ZZFDLanguageSelectViewController : ZZFlexibleLayoutViewController

- (instancetype)initWithLanguageArray:(NSArray *)languageArray selectLanguage:(NSString *)language selectedAction:(void (^)(NSString *language))selectedAction;

@end
