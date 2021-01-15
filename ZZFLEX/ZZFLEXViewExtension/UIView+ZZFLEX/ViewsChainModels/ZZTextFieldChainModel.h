//
//  ZZTextFieldChainModel.h
//  ZZFLEXDemo
//
//  Created by lbk on 2017/12/9.
//  Copyright © 2017年 lbk. All rights reserved.
//

#import "ZZBaseViewChainModel.h"

#define     ZZFLEXC_TF_API(ZZParamType, methodName)      ZZFLEXC_API(ZZTextFieldChainModel, ZZParamType, methodName)

typedef void (^ZZChainTFEventBlock)(id sender);

@class ZZTextFieldChainModel;
@interface ZZTextFieldChainModel : ZZBaseViewChainModel <ZZTextFieldChainModel *>

ZZFLEXC_TF_API(NSString *, text)
ZZFLEXC_TF_API(NSAttributedString *, attributedText)

ZZFLEXC_TF_API(UIFont *, font)
ZZFLEXC_TF_API(UIColor *, textColor)

ZZFLEXC_TF_API(NSTextAlignment, textAlignment)
ZZFLEXC_TF_API(UITextBorderStyle, borderStyle)

ZZFLEXC_TF_API(NSDictionary *, defaultTextAttributes)

ZZFLEXC_TF_API(NSString *, placeholder)
ZZFLEXC_TF_API(NSAttributedString *, attributedPlaceholder)

ZZFLEXC_TF_API(UIKeyboardType, keyboardType)

ZZFLEXC_TF_API(BOOL, clearsOnBeginEditing)
ZZFLEXC_TF_API(BOOL, adjustsFontSizeToFitWidth)
ZZFLEXC_TF_API(CGFloat, minimumFontSize)

ZZFLEXC_TF_API(id<UITextFieldDelegate>, delegate)

ZZFLEXC_TF_API(UIImage *, background)
ZZFLEXC_TF_API(UIImage *, disabledBackground)

ZZFLEXC_TF_API(BOOL, allowsEditingTextAttributes)
ZZFLEXC_TF_API(NSDictionary *, typingAttributes)

ZZFLEXC_TF_API(UITextFieldViewMode, clearButtonMode)
ZZFLEXC_TF_API(UIView *, leftView)
ZZFLEXC_TF_API(UITextFieldViewMode, leftViewMode)
ZZFLEXC_TF_API(UIView *, rightView)
ZZFLEXC_TF_API(UITextFieldViewMode, rightViewMode)

ZZFLEXC_TF_API(UIView *, inputView)
ZZFLEXC_TF_API(UIView *, inputAccessoryView)

ZZFLEXC_TF_API(BOOL, enabled)

ZZFLEXC_PROPERTY ZZTextFieldChainModel *(^ eventBlock)(UIControlEvents controlEvents, ZZChainTFEventBlock eventBlock);
ZZFLEXC_TF_API(ZZChainTFEventBlock, eventEditingDidBegin)
ZZFLEXC_TF_API(ZZChainTFEventBlock, eventEditingChanged)
ZZFLEXC_TF_API(ZZChainTFEventBlock, eventEditingDidEnd)
ZZFLEXC_TF_API(ZZChainTFEventBlock, eventEditingDidEndEditingDidEndOnExit)

@end

ZZFLEX_EX_API(ZZTextFieldChainModel, UITextField)
