//
//  WXMessage.m
//  WXChat
//
//  Created by libokun on 2020/1/7.
//

#import "WXMessage.h"

@implementation WXMessage

- (instancetype)initWithUserModel:(TLUser *)formUserModel content:(id)content
{
    if (self = [self init]) {
        self.formUserModel = formUserModel;
        self.content = content;
    }
    return self;
}

@end
