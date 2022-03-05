//
//  ZZTextViewChainModel.h
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2018/1/24.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "ZZScrollViewChainModel.h"

@interface _ZZTextViewChainModel<ObjcType> : _ZZScrollViewChainModel <ObjcType>

ZZFLEXC_API(id<UITextViewDelegate>, delegate)

ZZFLEXC_API(NSString *, text)
ZZFLEXC_API(UIFont *, font)
ZZFLEXC_API(UIColor *, textColor)

ZZFLEXC_API(NSTextAlignment, textAlignment)
ZZFLEXC_API(NSRange, selectedRange)
ZZFLEXC_API(BOOL, editable)
ZZFLEXC_API(BOOL, selectable)
ZZFLEXC_API(UIDataDetectorTypes, dataDetectorTypes)

ZZFLEXC_API(UIKeyboardType, keyboardType)

ZZFLEXC_API(BOOL, allowsEditingTextAttributes)
ZZFLEXC_API(NSAttributedString *, attributedText)
ZZFLEXC_API(NSDictionary *, typingAttributes)

ZZFLEXC_API(BOOL, clearsOnInsertion)

ZZFLEXC_API(UIEdgeInsets, textContainerInset)
ZZFLEXC_API(NSDictionary *, linkTextAttributes)

@end

ZZFLEX_EX_API(ZZTextViewChainModel, UITextView)
