//
//  WXChatTextMessageCell.m
//  WXChat
//
//  Created by libokun on 2020/1/7.
//

#import "WXChatTextMessageCell.h"

#define     HEIGHT_AVATAR       42
#define     MAX_MSG_WIDTH       SCREEN_WIDTH * 0.7
#define     FONT_MSG_TEXT       [UIFont systemFontOfSize:16]

@interface WXChatTextMessageCell ()

@property (nonatomic, strong) UIButton *avatarView;

@property (nonatomic, strong) UIView *messageView;

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation WXChatTextMessageCell

+ (CGFloat)viewHeightByDataModel:(WXMessage *)dataModel
{
    CGFloat textHeight = [(NSString *)(dataModel.content) tt_sizeWithFont:FONT_MSG_TEXT constrainedToWidth:MAX_MSG_WIDTH].height;
    CGFloat height = 20 + MAX(textHeight, HEIGHT_AVATAR);
    return height;
}

- (void)setViewDataModel:(WXMessage *)dataModel
{
    self.messageModel = dataModel;
    [self.avatarView setImage:[UIImage imageNamed:dataModel.formUserModel.avatar] forState:UIControlStateNormal];
    [self.textLabel setText:dataModel.content];
}

- (void)setViewEventAction:(id (^)(NSInteger, id))eventAction
{
    self.eventAction = eventAction;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        @weakify(self);
        self.avatarView = self.addButton(0)
        .cornerRadius(4.0f)
        .eventBlock(UIControlEventTouchUpInside, ^(UIButton *sender) {
            @strongify(self);
            if (self.eventAction) {
                self.eventAction(0, self.messageModel);
            }
        })
        .view;
        [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(10);
            make.size.mas_equalTo(42);
        }];
        
        self.messageView = self.addView(1)
        .backgroundColor([UIColor whiteColor]).cornerRadius(4.0f)
        .view;
        [self.messageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.avatarView);
            make.left.mas_equalTo(self.avatarView.mas_right).mas_offset(15);
            make.width.mas_lessThanOrEqualTo(MAX_MSG_WIDTH);
            make.height.mas_greaterThanOrEqualTo(HEIGHT_AVATAR);
        }];
        
        self.textLabel = self.messageView.addLabel(2).numberOfLines(0)
        .textColor([UIColor blackColor]).font(FONT_MSG_TEXT)
        .view;
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(10, 12, 10, 12));
        }];
    }
    return self;
}

@end
