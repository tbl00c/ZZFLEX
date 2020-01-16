//
//  WXChatViewController.m
//  WXChat
//
//  Created by libokun on 2020/1/7.
//

#import "WXChatViewController.h"
#import "WXMessage.h"
#import "WXChatTextMessageCell.h"
#import "WXUserViewController.h"

@interface WXChatViewController ()

@property (nonatomic, strong) NSArray *messageData;

@end

@implementation WXChatViewController

- (instancetype)initWithUserModel:(TLUser *)user
{
    if (self = [self init]) {
        self.userModel = user;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    [self setTitle:self.userModel.username];
    [self.view setBackgroundColor:RGBAColor(239.0, 239.0, 244.0, 1.0)];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self sendMessageAtIndex:0];
    });
}

- (void)sendMessageAtIndex:(NSInteger)index
{
    if (index < self.messageData.count) {
        NSString *str = self.messageData[index];
        WXMessage *message = [[WXMessage alloc] initWithUserModel:self.userModel content:str];
        [self sendMessage:message];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self sendMessageAtIndex:index + 1];
        });
    }
}


- (void)sendMessage:(WXMessage *)message
{
    @weakify(self);
    NSInteger sectionType = 0;
    if (!self.hasSection(sectionType)) {
        self.addSection(sectionType).sectionInsets(UIEdgeInsetsMake(5, 0, 10, 0));
    }
    
    self.addCell([WXChatTextMessageCell class]).toSection(sectionType).withDataModel(message).eventAction(^ id(NSInteger eventType, WXMessage *message) {
        @strongify(self);
        WXUserViewController *vc = [[WXUserViewController alloc] initWithUserModel:message.formUserModel];
        [self.navigationController pushViewController:vc animated:YES];
        return nil;
    });
    
    [self reloadView];
}

- (NSArray *)messageData
{
    if (!_messageData) {
        _messageData = @[@"嗨~", @"点击左侧头像，可以跳转到用户详情页哦"];
    }
    return _messageData;
}

@end
