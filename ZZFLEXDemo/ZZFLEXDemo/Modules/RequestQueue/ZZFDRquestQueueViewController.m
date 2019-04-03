//
//  ZZFDRquestQueueViewController.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2018/1/24.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "ZZFDRquestQueueViewController.h"
#import "ZZFDRQRequest.h"
#import "ZZFDRQFailedCell.h"
#import "ZZFDRQTitleCell.h"
#import "ZZFDRQNavTilteView.h"

#define     RQVC_HEIGHT_TEXTVIEW            MIN(200, SCREEN_HEIGHT * 0.35)

typedef NS_ENUM(NSInteger, ZZFDRquestQueueVCSectionType) {
    ZZFDRquestQueueVCSectionType1 = 1,
    ZZFDRquestQueueVCSectionType2,
    ZZFDRquestQueueVCSectionType3,
    ZZFDRquestQueueVCSectionType4,
    ZZFDRquestQueueVCSectionType5
};

@interface ZZFDRquestQueueViewController ()

@property (nonatomic, strong) ZZFDRQNavTilteView *titleView;
@property (nonatomic, strong) ZZFLEXRequestQueue *requestQueue;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) ZZFLEXAngel *angel;
@property (nonatomic, strong) UITextView *textView;

@end

@implementation ZZFDRquestQueueViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.requestQueue = [[ZZFLEXRequestQueue alloc] init];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    self.titleView = [[ZZFDRQNavTilteView alloc] init];
    [self.navigationItem setTitleView:self.titleView];
    [self p_showLoading:NO];
    
    self.textView = self.view.addTextView(1)
    .backgroundColor([UIColor blackColor]).editable(NO)
    .textColor([UIColor whiteColor]).font([UIFont systemFontOfSize:15])
    .masonry(^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(0);
        make.height.mas_equalTo(RQVC_HEIGHT_TEXTVIEW);
    })
    .view;
    
    self.collectionView = self.view.addCollectionView(2)
    .backgroundColor([UIColor colorGrayBG])
    .masonry(^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.textView.mas_top);
    })
    .view;
    [self.collectionView setNeverAdjustmentContentInset:YES];
    self.angel = [[ZZFLEXAngel alloc] initWithHostView:self.collectionView];
    
    @weakify(self);
    [self addRightBarButtonWithTitle:@"刷新" actionBlick:^{
        @strongify(self);
        [self refreshData];
    }];

    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.zz_make.frame(CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBAR_HEIGHT - STATUSBAR_HEIGHT - RQVC_HEIGHT_TEXTVIEW)).userInteractionEnabled(YES)
    .text(@"点击开始\n队列请求模拟").numberOfLines(0).textAlignment(NSTextAlignmentCenter).textColor([UIColor grayColor]);
    [self.collectionView showTipView:tipLabel retryAction:^(id userData) {
        @strongify(self);
        [self refreshData];
    }];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.requestQueue cancelAllRequests];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGFloat top = self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(top);
    }];
    [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(RQVC_HEIGHT_TEXTVIEW);
    }];
    [self.collectionView reloadData];
}

#pragma mark - # Request
- (void)refreshData
{
    [self.collectionView removeTipView];
    [self.textView setText:nil];
    self.angel.clear();
    [self.collectionView reloadData];
    
    // 停止并清空请求队列
    if (self.requestQueue.isRuning) {
        [self.requestQueue cancelAllRequests];
    }
    // 向请求队列中添加请求模型
    [self.requestQueue addRequestModel:[self createRequestModelWithType:ZZFDRquestQueueVCSectionType1]];
    [self.requestQueue addRequestModel:[self createRequestModelWithType:ZZFDRquestQueueVCSectionType2]];
    [self.requestQueue addRequestModel:[self createRequestModelWithType:ZZFDRquestQueueVCSectionType3]];
    [self.requestQueue addRequestModel:[self createRequestModelWithType:ZZFDRquestQueueVCSectionType4]];
    [self.requestQueue addRequestModel:[self createRequestModelWithType:ZZFDRquestQueueVCSectionType5]];
    
    [self p_showLoading:YES];
    [self p_addLog:[NSString stringWithFormat:@"==> 请求队列开始执行，共%ld个请求", self.requestQueue.requestCount] color:[UIColor whiteColor]];
    
    @weakify(self);
    [self.requestQueue runAllRequestsWithCompleteAction:^(NSArray *data, NSInteger successCount, NSInteger failureCount) {
        @strongify(self);
        [self p_showLoading:NO];
        [self p_addLog:[NSString stringWithFormat:@"==> 所有请求完成，成功%ld个，失败%ld个", successCount, failureCount]  color:[UIColor whiteColor]];
    }];
}

#pragma mark - # UI
- (void)loadSectionUIWithType:(ZZFDRquestQueueVCSectionType)type success:(BOOL)success data:(id)data
{
    [self p_addLog:[NSString stringWithFormat:@"开始刷新模块：%ld", type] color:[UIColor orangeColor]];
    
    if (self.angel.hasSection(type)) {
        self.angel.sectionForTag(type).clear();
    }
    else {
        self.angel.addSection(type).sectionInsets(UIEdgeInsetsMake(0, 0, 12, 0));
    }
    
    @weakify(self);
    if (success) {
        NSString *title = [NSString stringWithFormat:@"模块%ld", type];
        self.angel.addCell(@"ZZFDRQTitleCell").toSection(type).withDataModel([ZZFDRQTitleModel createModelWithTitle:title]).eventAction(^ id(NSInteger eventType, ZZFDRQFailedModel *data) {
            @strongify(self);
            self.angel.sectionForTag(type).deleteCellByTag(10001001);
            self.angel.addCell(@"ZZFDRQFailedCell").toSection(type).withDataModel([ZZFDRQFailedModel createModelWithLoading:YES]);
            [self.collectionView reloadData];
                        
            [self p_addLog:@"=> 开始局部刷新" color:[UIColor whiteColor]];
            [[self createRequestModelWithType:type] executeRequestMethod];

            return nil;
        });
        self.angel.addCell(@"ZZFDRQSuccessCell").toSection(type).withDataModel(data).viewTag(10001001);
    }
    else {
        self.angel.addCell(@"ZZFDRQFailedCell").toSection(type).withDataModel([ZZFDRQFailedModel createModelWithLoading:NO]).eventAction(^ id(NSInteger eventType, ZZFDRQFailedModel *data) {
            @strongify(self);
            [self p_addLog:@"=> 开始局部刷新" color:[UIColor whiteColor]];
            [[self createRequestModelWithType:type] executeRequestMethod];
            return nil;
        });
    }
    
    [self.collectionView reloadData];
}

#pragma mark - # Private Methods
- (ZZFLEXRequestModel *)createRequestModelWithType:(ZZFDRquestQueueVCSectionType)type
{
    @weakify(self);
    ZZFLEXRequestModel *requestModel = [ZZFLEXRequestModel requestModelWithTag:type requestAction:^(ZZFLEXRequestModel *requestModel) {
        @strongify(self);
        [self p_addLog:[NSString stringWithFormat:@"开始接口请求：%ld", type] color:[UIColor whiteColor]];
        [ZZFDRQRequest requestWithType:type success:^(id data) {
            @strongify(self);
            [self p_addLog:[NSString stringWithFormat:@"接口%ld请求成功", type] color:[UIColor cyanColor]];
            [requestModel executeRequestCompleteMethodWithSuccess:YES data:data];
        } failure:^(id errMsg) {
            @strongify(self);
            [self p_addLog:[NSString stringWithFormat:@"接口%ld请求失败", type] color:[UIColor cyanColor]];
            [requestModel executeRequestCompleteMethodWithSuccess:NO data:errMsg];
        }];
    } requestCompleteAction:^(ZZFLEXRequestModel *requestModel) {
        @strongify(self);
        [self loadSectionUIWithType:requestModel.tag success:requestModel.success data:requestModel.data];
    }];
    return requestModel;
}

- (void)p_showLoading:(BOOL)show
{
    if (show) {
        [self.titleView setTitle:@"加载中..."];
        [self.titleView setShowActivity:YES];
    }
    else {
        [self.titleView setTitle:@"请求队列"];
        [self.titleView setShowActivity:NO];
    }
}

- (void)p_addLog:(NSString *)log color:(UIColor *)color
{
    NSMutableAttributedString *attrStr = self.textView.attributedText.mutableCopy;
    
    // 时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"hh:mm:ss.SSS"];
    NSString *date = [formatter stringFromDate:[NSDate date]];
    NSString *time = [NSString stringWithFormat:@"%@  ", date];
    [attrStr appendAttributedString:[[NSAttributedString alloc] initWithString:time attributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],
                                                                                                 NSFontAttributeName : [UIFont systemFontOfSize:14]
                                                                                                 }]];
    
    // log
    NSString *str = [NSString stringWithFormat:@"%@\n", log];
    [attrStr appendAttributedString:[[NSAttributedString alloc] initWithString:str attributes:@{NSForegroundColorAttributeName : color,
                                                                                                NSFontAttributeName : [UIFont systemFontOfSize:14]
                                                                                                }]];
    
    // 行距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:4];
    [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attrStr.string.length)];
    
    [self.textView setAttributedText:attrStr];
    dispatch_async(dispatch_get_main_queue(), ^{
        CGFloat y = self.textView.contentSize.height - self.textView.frame.size.height;
        y = MAX(0, y);
        [self.textView setContentOffset:CGPointMake(0, y) animated:YES];
    });
}

@end
