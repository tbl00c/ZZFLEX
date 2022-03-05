//
//  ZZTextFieldChainModel.h
//  ZZFLEXDemo
//
//  Created by lbk on 2017/12/9.
//  Copyright © 2017年 lbk. All rights reserved.
//

#import "ZZControlChainModel.h"

@interface _ZZTextFieldChainModel<ObjcType> : _ZZControlChainModel <ObjcType>

ZZFLEXC_API(NSString *, text)
ZZFLEXC_API(NSAttributedString *, attributedText)

ZZFLEXC_API(UIFont *, font)
ZZFLEXC_API(UIColor *, textColor)

ZZFLEXC_API(NSTextAlignment, textAlignment)
ZZFLEXC_API(UITextBorderStyle, borderStyle)

ZZFLEXC_API(NSDictionary *, defaultTextAttributes)

ZZFLEXC_API(NSString *, placeholder)
ZZFLEXC_API(NSAttributedString *, attributedPlaceholder)

ZZFLEXC_API(UIKeyboardType, keyboardType)

ZZFLEXC_API(BOOL, clearsOnBeginEditing)
ZZFLEXC_API(BOOL, adjustsFontSizeToFitWidth)
ZZFLEXC_API(CGFloat, minimumFontSize)

ZZFLEXC_API(id<UITextFieldDelegate>, delegate)

ZZFLEXC_API(UIImage *, background)
ZZFLEXC_API(UIImage *, disabledBackground)

ZZFLEXC_API(BOOL, allowsEditingTextAttributes)
ZZFLEXC_API(NSDictionary *, typingAttributes)

ZZFLEXC_API(UITextFieldViewMode, clearButtonMode)
ZZFLEXC_API(UIView *, leftView)
ZZFLEXC_API(UITextFieldViewMode, leftViewMode)
ZZFLEXC_API(UIView *, rightView)
ZZFLEXC_API(UITextFieldViewMode, rightViewMode)

ZZFLEXC_API(UIView *, inputView)
ZZFLEXC_API(UIView *, inputAccessoryView)

ZZFLEXC_API(UIReturnKeyType, returnKeyType)

@end

ZZFLEX_EX_API(ZZTextFieldChainModel, UITextField)
