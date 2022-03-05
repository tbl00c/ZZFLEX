//
//  ZZTextViewChainModel.m
//  ZZFLEXDemo
//
//  Created by lbk on 2018/1/24.
//  Copyright © 2018年 lbk. All rights reserved.
//

#import "ZZTextViewChainModel.h"

#define     ZZFLEXC_IMP_VIEW_TYPE   UITextView

@implementation _ZZTextViewChainModel

+ (Class)viewClass {
    return [UITextView class];
}

ZZFLEXC_IMP(id<UITextViewDelegate>, delegate)

ZZFLEXC_IMP(NSString *, text)
ZZFLEXC_IMP(UIFont *, font)
ZZFLEXC_IMP(UIColor *, textColor)

ZZFLEXC_IMP(NSTextAlignment, textAlignment)
ZZFLEXC_IMP(NSRange, selectedRange)
ZZFLEXC_IMP(BOOL, editable)
ZZFLEXC_IMP(BOOL, selectable)
ZZFLEXC_IMP(UIDataDetectorTypes, dataDetectorTypes)

ZZFLEXC_IMP(UIKeyboardType, keyboardType)

ZZFLEXC_IMP(BOOL, allowsEditingTextAttributes)
ZZFLEXC_IMP(NSAttributedString *, attributedText)
ZZFLEXC_IMP(NSDictionary *, typingAttributes)

ZZFLEXC_IMP(BOOL, clearsOnInsertion)

ZZFLEXC_IMP(UIEdgeInsets, textContainerInset)
ZZFLEXC_IMP(NSDictionary *, linkTextAttributes)

@end

ZZFLEX_EX_IMP(ZZTextViewChainModel)
