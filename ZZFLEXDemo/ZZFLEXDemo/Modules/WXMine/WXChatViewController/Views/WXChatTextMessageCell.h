//
//  WXChatTextMessageCell.h
//  WXChat
//
//  Created by libokun on 2020/1/7.
//

#import <UIKit/UIKit.h>
#import "WXMessage.h"

NS_ASSUME_NONNULL_BEGIN

@interface WXChatTextMessageCell : UICollectionViewCell <ZZFlexibleLayoutViewProtocol>

@property (nonatomic, strong) id (^eventAction)(NSInteger, id);

@property (nonatomic, strong) WXMessage *messageModel;

@end

NS_ASSUME_NONNULL_END
