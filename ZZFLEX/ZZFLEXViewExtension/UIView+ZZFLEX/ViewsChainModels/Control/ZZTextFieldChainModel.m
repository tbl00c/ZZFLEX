//
//  ZZTextFieldChainModel.m
//  ZZFLEXDemo
//
//  Created by lbk on 2017/12/9.
//  Copyright © 2017年 lbk. All rights reserved.
//

#import "ZZTextFieldChainModel.h"
#import "UIControl+ZZEvent.h"

#define     ZZFLEXC_IMP_VIEW_TYPE   UITextField

@implementation _ZZTextFieldChainModel

+ (Class)viewClass {
    return [UITextField class];
}

ZZFLEXC_IMP(NSString *, text)
ZZFLEXC_IMP(NSAttributedString *, attributedText)

ZZFLEXC_IMP(UIFont *, font)
ZZFLEXC_IMP(UIColor *, textColor)

ZZFLEXC_IMP(NSTextAlignment, textAlignment)
ZZFLEXC_IMP(UITextBorderStyle, borderStyle)

ZZFLEXC_IMP(NSDictionary *, defaultTextAttributes)

ZZFLEXC_IMP(NSString *, placeholder)
ZZFLEXC_IMP(NSAttributedString *, attributedPlaceholder)

ZZFLEXC_IMP(UIKeyboardType, keyboardType)

ZZFLEXC_IMP(BOOL, clearsOnBeginEditing)
ZZFLEXC_IMP(BOOL, adjustsFontSizeToFitWidth)
ZZFLEXC_IMP(CGFloat, minimumFontSize)

ZZFLEXC_IMP(id<UITextFieldDelegate>, delegate)

ZZFLEXC_IMP(UIImage *, background)
ZZFLEXC_IMP(UIImage *, disabledBackground)

ZZFLEXC_IMP(BOOL, allowsEditingTextAttributes)
ZZFLEXC_IMP(NSDictionary *, typingAttributes)

ZZFLEXC_IMP(UITextFieldViewMode, clearButtonMode)
ZZFLEXC_IMP(UIView *, leftView)
ZZFLEXC_IMP(UITextFieldViewMode, leftViewMode)
ZZFLEXC_IMP(UIView *, rightView)
ZZFLEXC_IMP(UITextFieldViewMode, rightViewMode)

ZZFLEXC_IMP(UIView *, inputView)
ZZFLEXC_IMP(UIView *, inputAccessoryView)

ZZFLEXC_IMP(UIReturnKeyType, returnKeyType)

@end

ZZFLEX_EX_IMP(ZZTextFieldChainModel)
