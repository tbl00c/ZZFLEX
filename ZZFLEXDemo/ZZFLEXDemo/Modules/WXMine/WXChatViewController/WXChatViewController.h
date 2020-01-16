//
//  WXChatViewController.h
//  WXChat
//
//  Created by libokun on 2020/1/7.
//

#import <UIKit/UIKit.h>
#import "TLUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface WXChatViewController : ZZFlexibleLayoutViewController

@property (nonatomic, strong) TLUser *userModel;

- (instancetype)initWithUserModel:(TLUser *)user;

@end

NS_ASSUME_NONNULL_END
