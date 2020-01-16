//
//  WXUserHeaderCell.h
//  WXUser
//
//  Created by libokun on 2020/1/7.
//

#import <UIKit/UIKit.h>
#import "TLUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface WXUserHeaderCell : UICollectionViewCell <ZZFlexibleLayoutViewProtocol>

@property (nonatomic, strong) TLUser *user;

@end

NS_ASSUME_NONNULL_END
