//
//  WXUserViewController.m
//  WXUser
//
//  Created by libokun on 2020/1/7.
//

#import "WXUserViewController.h"
#import <Masonry/Masonry.h>
#import <TLKit/TLKit.h>
#import "WXChatViewController.h"
#import "WXUserHeaderCell.h"
#import "WCUserButtonCell.h"

@interface WXUserViewController ()

@property (nonatomic, strong) UIView *topView;

@end

@implementation WXUserViewController

- (instancetype)initWithUserModel:(TLUser *)userModel
{
    if (self = [self init]) {
        self.userModel = userModel;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    [self.view setBackgroundColor:RGBAColor(239.0, 239.0, 244.0, 1.0)];
    
    self.topView = self.collectionView.addView(0)
    .backgroundColor([UIColor whiteColor])
    .frame(CGRectMake(0, 0, self.view.frame.size.width, 0))
    .view;
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(-1, 0, 0, 0));
    }];
    
    [self reloadUserViewUI];
}

- (void)reloadUserViewUI
{
    @weakify(self);
    self.clear();
    
    {
        NSInteger sectionType = 0;
        self.addSection(sectionType);
        self.addCell([WXUserHeaderCell class]).toSection(sectionType).withDataModel(self.userModel);
    }
    
    {
        NSInteger sectionType = 1;
        self.addSection(sectionType).sectionInsets(UIEdgeInsetsMake(10, 0, 0, 0));
        self.addCell([WCUserButtonCell class]).toSection(sectionType).withDataModel(@"发消息").selectedAction(^ (NSString *title) {
            @strongify(self);
            WXChatViewController *vc = [[WXChatViewController alloc] initWithUserModel:self.userModel];
            [self.navigationController pushViewController:vc animated:YES];
        });
    }
    
    [self reloadView];
}

#pragma mark - # Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y < 0) {
        self.topView.y = scrollView.contentOffset.y;
        self.topView.height = -scrollView.contentOffset.y + 1;
    }
}

@end
