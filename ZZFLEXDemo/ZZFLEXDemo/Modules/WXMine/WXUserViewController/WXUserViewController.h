//
//  WXUserViewController.h
//  WXUser
//
//  Created by libokun on 2020/1/7.
//

#import <UIKit/UIKit.h>
#import "TLUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface WXUserViewController : ZZFlexibleLayoutViewController 

@property (nonatomic, strong) TLUser *userModel;

- (instancetype)initWithUserModel:(TLUser *)userModel;

@end

NS_ASSUME_NONNULL_END
