//
//  ZZControlChainModel.m
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZControlChainModel.h"
#import "UIControl+ZZEvent.h"

#define     ZZFLEXC_IMP_VIEW_TYPE   UIControl

#define     ZZFLEXC_EVENT_IMP(methodName, eventType) \
- (id (^)(ZZChainControlEventBlock))methodName {   \
    return ^id (void (^eventBlock)(__kindof UIControl * sender)) {    \
        [(UIControl *)self.view setControlEvents:eventType handler:eventBlock]; \
        return self;    \
    };  \
}

@implementation _ZZControlChainModel

+ (Class)viewClass {
    return [UIControl class];
}

ZZFLEXC_IMP(BOOL, enabled)
ZZFLEXC_IMP(BOOL, selected)
ZZFLEXC_IMP(BOOL, highlighted)

- (id (^)(UIControlEvents, ZZChainControlEventBlock))eventBlock {
    return ^id (UIControlEvents controlEvents, ZZChainControlEventBlock eventBlock) {
        [(UIControl *)self.view addControlEvents:controlEvents handler:eventBlock];
        return self;
    };
}

ZZFLEXC_EVENT_IMP(eventTouchDown, UIControlEventTouchDown);
ZZFLEXC_EVENT_IMP(eventTouchDownRepeat, UIControlEventTouchDownRepeat);
ZZFLEXC_EVENT_IMP(eventTouchUpInside, UIControlEventTouchUpInside);
ZZFLEXC_EVENT_IMP(eventTouchUpOutside, UIControlEventTouchUpOutside);
ZZFLEXC_EVENT_IMP(eventTouchCancel, UIControlEventTouchCancel);

ZZFLEXC_EVENT_IMP(eventValueChanged, UIControlEventValueChanged);

ZZFLEXC_EVENT_IMP(eventEditingDidBegin, UIControlEventEditingDidBegin)
ZZFLEXC_EVENT_IMP(eventEditingChanged, UIControlEventEditingChanged)
ZZFLEXC_EVENT_IMP(eventEditingDidEnd, UIControlEventEditingDidEnd)
ZZFLEXC_EVENT_IMP(eventEditingDidEndEditingDidEndOnExit, UIControlEventEditingDidEndOnExit)

ZZFLEXC_IMP(UIControlContentVerticalAlignment, contentVerticalAlignment)
ZZFLEXC_IMP(UIControlContentHorizontalAlignment, contentHorizontalAlignment)

@end

ZZFLEX_EX_IMP(ZZControlChainModel)
