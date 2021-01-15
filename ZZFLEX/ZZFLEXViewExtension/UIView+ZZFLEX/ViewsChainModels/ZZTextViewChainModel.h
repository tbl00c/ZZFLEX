//
//  ZZTextViewChainModel.h
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2018/1/24.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "ZZBaseViewChainModel.h"

#define     ZZFLEXC_TEXTVIEW_API(ZZParamType, methodName)      ZZFLEXC_API(ZZTextViewChainModel, ZZParamType, methodName)

@class ZZTextViewChainModel;
@interface ZZTextViewChainModel : ZZBaseViewChainModel <ZZTextViewChainModel *>

ZZFLEXC_TEXTVIEW_API(id<UITextViewDelegate>, delegate)

ZZFLEXC_TEXTVIEW_API(NSString *, text)
ZZFLEXC_TEXTVIEW_API(UIFont *, font)
ZZFLEXC_TEXTVIEW_API(UIColor *, textColor)

ZZFLEXC_TEXTVIEW_API(NSTextAlignment, textAlignment)
ZZFLEXC_TEXTVIEW_API(NSRange, selectedRange)
ZZFLEXC_TEXTVIEW_API(BOOL, editable)
ZZFLEXC_TEXTVIEW_API(BOOL, selectable)
ZZFLEXC_TEXTVIEW_API(UIDataDetectorTypes, dataDetectorTypes)

ZZFLEXC_TEXTVIEW_API(UIKeyboardType, keyboardType)

ZZFLEXC_TEXTVIEW_API(BOOL, allowsEditingTextAttributes)
ZZFLEXC_TEXTVIEW_API(NSAttributedString *, attributedText)
ZZFLEXC_TEXTVIEW_API(NSDictionary *, typingAttributes)

ZZFLEXC_TEXTVIEW_API(BOOL, clearsOnInsertion)

ZZFLEXC_TEXTVIEW_API(UIEdgeInsets, textContainerInset)
ZZFLEXC_TEXTVIEW_API(NSDictionary *, linkTextAttributes)

#pragma mark - UIScrollView
ZZFLEXC_TEXTVIEW_API(CGSize, contentSize)
ZZFLEXC_TEXTVIEW_API(CGPoint, contentOffset)
ZZFLEXC_TEXTVIEW_API(UIEdgeInsets, contentInset)

ZZFLEXC_TEXTVIEW_API(BOOL, bounces)
ZZFLEXC_TEXTVIEW_API(BOOL, alwaysBounceVertical)
ZZFLEXC_TEXTVIEW_API(BOOL, alwaysBounceHorizontal)

ZZFLEXC_TEXTVIEW_API(BOOL, pagingEnabled)
ZZFLEXC_TEXTVIEW_API(BOOL, scrollEnabled)

ZZFLEXC_TEXTVIEW_API(BOOL, showsHorizontalScrollIndicator)
ZZFLEXC_TEXTVIEW_API(BOOL, showsVerticalScrollIndicator)

ZZFLEXC_TEXTVIEW_API(BOOL, scrollsToTop)

@end

ZZFLEX_EX_API(ZZTextViewChainModel, UITextView)
