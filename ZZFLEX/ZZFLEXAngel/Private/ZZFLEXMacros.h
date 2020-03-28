//
//  ZZFLEXMacros.h
//  ZZFLEXDemo
//
//  Created by lbk on 2017/11/27.
//  Copyright © 2017年 lbk. All rights reserved.
//

#ifndef ZZFLEXMacros_h
#define ZZFLEXMacros_h

#define     ZZFLEXLog(fmt, ...)                 NSLog((@"【ZZFLEX】" fmt), ##__VA_ARGS__)
#define     ZZFLEXBundle                        [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"ZZFLEX" ofType:@"bundle"]]
#define     ZZFLEXImage(imageName)              [UIImage imageNamed:imageName inBundle:ZZFLEXBundle compatibleWithTraitCollection:nil]
#define     ZZFLEXFileUrl(name, type)           [ZZFLEXBundle URLForResource:name withExtension:type]
#define     ZZFLEXFilePath(name, type)          [ZZFLEXBundle pathForResource:name ofType:type]

#define     BORDER_WIDTH_1PX                    ([[UIScreen mainScreen] scale] > 0.0 ? 1.0 / [[UIScreen mainScreen] scale] : 1.0)

#endif /* ZZFLEXMacros_h */
