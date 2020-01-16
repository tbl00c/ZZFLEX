//
//  WXMessage.h
//  WXChat
//
//  Created by libokun on 2020/1/7.
//

#import <Foundation/Foundation.h>
#import "TLUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface WXMessage : NSObject

@property (nonatomic, strong) TLUser *formUserModel;

@property (nonatomic, strong) id content;

- (instancetype)initWithUserModel:(TLUser *)formUserModel content:(id)content;

@end

NS_ASSUME_NONNULL_END
