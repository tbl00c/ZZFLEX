//
//  ZZTextFieldChainModel.m
//  ZZFLEXDemo
//
//  Created by lbk on 2017/12/9.
//  Copyright © 2017年 lbk. All rights reserved.
//

#import "ZZTextFieldChainModel.h"
#import "UIControl+ZZEvent.h"

#define     ZZFLEXC_TF_IMP(ZZParamType, methodName)      ZZFLEXC_IMP(ZZTextFieldChainModel, UITextField, ZZParamType, methodName)
#define     ZZFLEXC_TF_EVENT_IMP(methodName, eventType) \
- (ZZTextFieldChainModel *(^)(void (^eventBlock)(id sender)))methodName     \
{   \
    return ^ZZTextFieldChainModel *(void (^eventBlock)(id sender)) {    \
        [(UIControl *)self.view addControlEvents:eventType handler:eventBlock]; \
        return self;    \
    };  \
}

@implementation ZZTextFieldChainModel

+ (Class)viewClass
{
    return [UITextField class];
}

ZZFLEXC_TF_IMP(NSString *, text)
ZZFLEXC_TF_IMP(NSAttributedString *, attributedText)

ZZFLEXC_TF_IMP(UIFont *, font)
ZZFLEXC_TF_IMP(UIColor *, textColor)

ZZFLEXC_TF_IMP(NSTextAlignment, textAlignment)
ZZFLEXC_TF_IMP(UITextBorderStyle, borderStyle)

ZZFLEXC_TF_IMP(NSDictionary *, defaultTextAttributes)

ZZFLEXC_TF_IMP(NSString *, placeholder)
ZZFLEXC_TF_IMP(NSAttributedString *, attributedPlaceholder)

ZZFLEXC_TF_IMP(UIKeyboardType, keyboardType)

ZZFLEXC_TF_IMP(BOOL, clearsOnBeginEditing)
ZZFLEXC_TF_IMP(BOOL, adjustsFontSizeToFitWidth)
ZZFLEXC_TF_IMP(CGFloat, minimumFontSize)

ZZFLEXC_TF_IMP(id<UITextFieldDelegate>, delegate)

ZZFLEXC_TF_IMP(UIImage *, background)
ZZFLEXC_TF_IMP(UIImage *, disabledBackground)

ZZFLEXC_TF_IMP(BOOL, allowsEditingTextAttributes)
ZZFLEXC_TF_IMP(NSDictionary *, typingAttributes)

ZZFLEXC_TF_IMP(UITextFieldViewMode, clearButtonMode)
ZZFLEXC_TF_IMP(UIView *, leftView)
ZZFLEXC_TF_IMP(UITextFieldViewMode, leftViewMode)
ZZFLEXC_TF_IMP(UIView *, rightView)
ZZFLEXC_TF_IMP(UITextFieldViewMode, rightViewMode)

ZZFLEXC_TF_IMP(UIView *, inputView)
ZZFLEXC_TF_IMP(UIView *, inputAccessoryView)

ZZFLEXC_TF_IMP(BOOL, enabled)

- (ZZTextFieldChainModel *(^)(UIControlEvents controlEvents, void (^eventBlock)(id sender)))eventBlock
{
    return ^ZZTextFieldChainModel *(UIControlEvents controlEvents, void (^eventBlock)(id sender)) {
        [(UIControl *)self.view addControlEvents:controlEvents handler:eventBlock];
        return self;
    };
}
ZZFLEXC_TF_EVENT_IMP(eventEditingDidBegin, UIControlEventEditingDidBegin)
ZZFLEXC_TF_EVENT_IMP(eventEditingChanged, UIControlEventEditingChanged)
ZZFLEXC_TF_EVENT_IMP(eventEditingDidEnd, UIControlEventEditingDidEnd)
ZZFLEXC_TF_EVENT_IMP(eventEditingDidEndEditingDidEndOnExit, UIControlEventEditingDidEndOnExit)

@end

ZZFLEX_EX_IMP(ZZTextFieldChainModel, UITextField)
