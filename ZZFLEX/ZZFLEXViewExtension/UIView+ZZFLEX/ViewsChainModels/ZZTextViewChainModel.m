//
//  ZZTextViewChainModel.m
//  ZZFLEXDemo
//
//  Created by lbk on 2018/1/24.
//  Copyright © 2018年 lbk. All rights reserved.
//

#import "ZZTextViewChainModel.h"

#define     ZZFLEXC_TEXTVIEW_IMP(ZZParamType, methodName)      ZZFLEXC_IMP(ZZTextViewChainModel, UITextView, ZZParamType, methodName)
#define     ZZFLEXC_SV_IMP(ZZParamType, methodName)      ZZFLEXC_IMP(ZZTextViewChainModel, UITextView, ZZParamType, methodName)

@implementation ZZTextViewChainModel

+ (Class)viewClass
{
    return [UITextView class];
}

ZZFLEXC_TEXTVIEW_IMP(id<UITextViewDelegate>, delegate)

ZZFLEXC_TEXTVIEW_IMP(NSString *, text)
ZZFLEXC_TEXTVIEW_IMP(UIFont *, font)
ZZFLEXC_TEXTVIEW_IMP(UIColor *, textColor)

ZZFLEXC_TEXTVIEW_IMP(NSTextAlignment, textAlignment)
ZZFLEXC_TEXTVIEW_IMP(NSRange, selectedRange)
ZZFLEXC_TEXTVIEW_IMP(BOOL, editable)
ZZFLEXC_TEXTVIEW_IMP(BOOL, selectable)
ZZFLEXC_TEXTVIEW_IMP(UIDataDetectorTypes, dataDetectorTypes)

ZZFLEXC_TEXTVIEW_IMP(UIKeyboardType, keyboardType)

ZZFLEXC_TEXTVIEW_IMP(BOOL, allowsEditingTextAttributes)
ZZFLEXC_TEXTVIEW_IMP(NSAttributedString *, attributedText)
ZZFLEXC_TEXTVIEW_IMP(NSDictionary *, typingAttributes)

ZZFLEXC_TEXTVIEW_IMP(BOOL, clearsOnInsertion)

ZZFLEXC_TEXTVIEW_IMP(UIEdgeInsets, textContainerInset)
ZZFLEXC_TEXTVIEW_IMP(NSDictionary *, linkTextAttributes)

#pragma mark - UIScrollView
ZZFLEXC_SV_IMP(CGSize, contentSize)
ZZFLEXC_SV_IMP(CGPoint, contentOffset)
ZZFLEXC_SV_IMP(UIEdgeInsets, contentInset)

ZZFLEXC_SV_IMP(BOOL, bounces)
ZZFLEXC_SV_IMP(BOOL, alwaysBounceVertical)
ZZFLEXC_SV_IMP(BOOL, alwaysBounceHorizontal)

ZZFLEXC_SV_IMP(BOOL, pagingEnabled)
ZZFLEXC_SV_IMP(BOOL, scrollEnabled)

ZZFLEXC_SV_IMP(BOOL, showsHorizontalScrollIndicator)
ZZFLEXC_SV_IMP(BOOL, showsVerticalScrollIndicator)

ZZFLEXC_SV_IMP(BOOL, scrollsToTop)

@end

ZZFLEX_EX_IMP(ZZTextViewChainModel, UITextView)
