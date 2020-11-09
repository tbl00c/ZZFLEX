//
//  ZZFDGoodDetailViewController.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/11/28.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFDGoodDetailViewController.h"
#import <MJRefresh/MJRefresh.h>
#import <XLPhotoBrowser_CoderXL/XLPhotoBrowser.h>
#import "ZZFDGoodAreaCell.h"
#import "ZZFDGoodTitleCell.h"
#import "ZZFDGoodPriceCell.h"
#import "ZZFDGoodReadCell.h"
#import "ZZFDGoodSectionTitleCell.h"
#import "ZZFDGoodParamCell.h"
#import "ZZFDGoodDetailCell.h"
#import "ZZFDGoodBigImageCell.h"
#import "ZZFDGoodSmallImageCell.h"
#import "ZZFDImageMoreCell.h"
#import "ZZFDGoodUserCell.h"
#import "ZZFDGoodCommitEmptyCell.h"
#import "ZZFDGoodCommitInputCell.h"
#import "ZZFDGoodCommitCell.h"
#import "ZZFDGoodTitleView.h"
#import "ZZFDGoodRecCell.h"

typedef NS_ENUM(NSInteger, ZZFDGoodSectionType) {
    ZZFDGoodSectionTypeHeader,
    ZZFDGoodSectionTypeDetail,
    ZZFDGoodSectionTypeImage,
    ZZFDGoodSectionTypeUser,
    ZZFDGoodSectionTypeCommit,
    ZZFDGoodSectionTypeRec,
};

@interface ZZFDGoodDetailViewController ()

@property (nonatomic, assign) NSInteger offset;

@end

@implementation ZZFDGoodDetailViewController

- (id)initWithListModel:(ZZFDGoodListModel *)listModel
{
    if (self = [super init]) {
        self.listModel = listModel;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    [self setTitle:@"商品详情"];
    [self.view setBackgroundColor:[UIColor colorGrayBG]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadUIWithDataModel:self.listModel];
}

- (void)loadUIWithDataModel:(ZZFDGoodListModel *)listModel
{
    @weakify(self);
    self.clear();

    /// header
    self.addSection(ZZFDGoodSectionTypeHeader);
    // 标题
    self.addCell([ZZFDGoodTitleCell class]).toSection(ZZFDGoodSectionTypeHeader).withDataModel(listModel.goodTitle);
    // 价格
    self.addCell([ZZFDGoodPriceCell class]).toSection(ZZFDGoodSectionTypeHeader).withDataModel(listModel.attrPrice);
    // 阅读量
    NSString *readInfo = [NSString stringWithFormat:@"%u次阅读", arc4random() % 1000];
    self.addCell([ZZFDGoodReadCell class]).toSection(ZZFDGoodSectionTypeHeader).withDataModel(readInfo);
    // 区域
    self.addCell([ZZFDGoodAreaCell class]).toSection(ZZFDGoodSectionTypeHeader).withDataModel(listModel.position).eventAction(^ id(NSInteger eventType, id data) {
        @strongify(self);
        UIViewController *vc = [[UIViewController alloc] init];
        [vc.view setBackgroundColor:[UIColor whiteColor]];
        [vc setTitle:data];
        PushVC(vc);
        return nil;
    });
    
    /// Detail
    self.addSection(ZZFDGoodSectionTypeDetail).sectionInsets(UIEdgeInsetsMake(12, 0, 0, 0));
    // 标题
    self.addCell([ZZFDGoodSectionTitleCell class]).toSection(ZZFDGoodSectionTypeDetail).withDataModel(@"商品详情");
    // 参数
    if (listModel.params.count > 0) {
        self.addCells([ZZFDGoodParamCell class]).toSection(ZZFDGoodSectionTypeDetail).withDataModelArray(listModel.params);
        if (listModel.params.count % 2 == 1) {
            self.addCell([ZZFDGoodParamCell class]).toSection(ZZFDGoodSectionTypeDetail);
        }
        self.addSeperatorCell(CGSizeMake(-1, 8), [UIColor whiteColor]).toSection(ZZFDGoodSectionTypeDetail);
    }
    // 详细描述
    if (listModel.attrGoodDetail) {
        self.addCell([ZZFDGoodDetailCell class]).toSection(ZZFDGoodSectionTypeDetail).withDataModel(listModel.attrGoodDetail);
    }
    
    /// Image
    if (listModel.goodImages.count > 0) {
        @weakify(self);
        void (^selecteAction)(id data) = ^(id data) {
            @strongify(self);
            NSMutableArray *imagesData = @[].mutableCopy;
            for (NSString *imageName in self.listModel.goodImages) {
                UIImage *image = [UIImage imageNamed:imageName];
                [imagesData addObject:image];
            }
            NSInteger index = [self.listModel.goodImages indexOfObject:data];
            [XLPhotoBrowser showPhotoBrowserWithImages:imagesData currentImageIndex:index];
        };
        
        self.addSection(ZZFDGoodSectionTypeImage).sectionInsets(UIEdgeInsetsMake(8, 15, 20, 15)).minimumLineSpacing(10).minimumInteritemSpacing(10).backgrounColor([UIColor whiteColor]);
        if (listModel.goodImages.count <= 4) {
            self.addCells([ZZFDGoodBigImageCell class]).toSection(ZZFDGoodSectionTypeImage).withDataModelArray(listModel.goodImages).selectedAction(selecteAction);
        }
        else {
            self.addCells([ZZFDGoodBigImageCell class]).toSection(ZZFDGoodSectionTypeImage).withDataModelArray([listModel.goodImages subarrayWithRange:NSMakeRange(0, 3)]).selectedAction(selecteAction);
            if (listModel.goodImages.count <= 9) {
                self.addCells([ZZFDGoodSmallImageCell class]).toSection(ZZFDGoodSectionTypeImage).withDataModelArray([listModel.goodImages subarrayWithRange:NSMakeRange(3, listModel.goodImages.count - 3)]).selectedAction(selecteAction);
                if (listModel.goodImages.count % 2 == 0) {
                    self.addCell([ZZFDGoodSmallImageCell class]).toSection(ZZFDGoodSectionTypeImage);
                }
            }
            else {
                self.addCells([ZZFDGoodSmallImageCell class]).toSection(ZZFDGoodSectionTypeImage).withDataModelArray([listModel.goodImages subarrayWithRange:NSMakeRange(3, 6)]).selectedAction(selecteAction);
                self.addCell([ZZFDImageMoreCell class]).toSection(ZZFDGoodSectionTypeImage).selectedAction(^(id data) {
                    @strongify(self);
                    self.deleteCell.byViewTag(100101);
                    self.addCells([ZZFDGoodSmallImageCell class]).toSection(ZZFDGoodSectionTypeImage)
                    .withDataModelArray([self.listModel.goodImages subarrayWithRange:NSMakeRange(9, self.listModel.goodImages.count - 9)]).selectedAction(selecteAction);
                    if (self.listModel.goodImages.count % 2 == 0) {
                        self.addCell([ZZFDGoodSmallImageCell class]).toSection(ZZFDGoodSectionTypeImage);
                    }
                    [self reloadView];
                }).viewTag(100101);
            }
        
        }
    }
    else {
        self.addSeperatorCell(CGSizeMake(-1, 8), [UIColor whiteColor]).toSection(ZZFDGoodSectionTypeDetail);
    }
    
    /// User
    self.addSection(ZZFDGoodSectionTypeUser);
    self.addCell([ZZFDGoodUserCell class]).toSection(ZZFDGoodSectionTypeUser).withDataModel(listModel).selectedAction(^ (ZZFDGoodListModel *data) {
        @strongify(self);
        UIViewController *vc = [[UIViewController alloc] init];
        [vc.view setBackgroundColor:[UIColor whiteColor]];
        [vc setTitle:data.username];
        PushVC(vc);
    });
    
    /// Commit
    self.addSection(ZZFDGoodSectionTypeCommit);
    [self resetCommitModule];
    
    /// Rec
    self.addSection(ZZFDGoodSectionTypeRec).sectionInsets(UIEdgeInsetsMake(0, 15, 0, 15)).minimumLineSpacing(10).minimumInteritemSpacing(10);
    [self requestRecDataWithOffset:0];
    
    [self reloadView];
}

- (void)resetCommitModule
{
    self.sectionForTag(ZZFDGoodSectionTypeCommit).clear();
    self.addCell([ZZFDGoodSectionTitleCell class]).toSection(ZZFDGoodSectionTypeCommit).withDataModel(@"互动");
    @weakify(self);
    if (self.listModel.commitData.count == 0) {
        self.addCell([ZZFDGoodCommitEmptyCell class]).toSection(ZZFDGoodSectionTypeCommit).eventAction(^ id(NSInteger type, id data) {
            @strongify(self);
            [self showCommitInputAlert];
            return nil;
        });
    }
    else {
        self.addCell([ZZFDGoodCommitInputCell class]).toSection(ZZFDGoodSectionTypeCommit).eventAction(^ id(NSInteger type, id data) {
            @strongify(self);
            [self showCommitInputAlert];
            return nil;
        });
        self.addCells([ZZFDGoodCommitCell class]).toSection(ZZFDGoodSectionTypeCommit).withDataModelArray(self.listModel.commitData);
    }
    [self reloadView];
}

- (void)showCommitInputAlert
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"留言" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    __block UITextField *tf;
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        tf = textField;
    }];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"发送" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *text = tf.text;
        [self.listModel.commitData insertObject:createCommitModel(@"我", @"avatar", @"刚刚", text) atIndex:0];
        [self resetCommitModule];
    }];
    [alert addAction:ok];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)requestRecDataWithOffset:(NSInteger)offset
{
    @weakify(self);
    [ZZFDGoodListModel requestHomePageDataWithOffset:offset success:^(NSArray *data) {
        @strongify(self);
        
        // 很重要
        if (!self) {
            return ;
        }
        
        self.offset = offset + data.count;
        [TLToast dismiss];
        
        if (offset == 0) {
            self.sectionForTag(ZZFDGoodSectionTypeRec).clear();
            self.setHeader([ZZFDGoodTitleView class]).toSection(ZZFDGoodSectionTypeRec);
            
            if (!self.collectionView.mj_footer) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.collectionView setMj_footer:[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                        @strongify(self);
                        [self requestRecDataWithOffset:self.offset];
                    }]];
                });
            }
            else {
                [self.collectionView.mj_footer resetNoMoreData];
            }
        }
        else {
            if (data.count == 20) {
                [self.collectionView.mj_footer endRefreshing];
            }
            else {
                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            }
        }
        
        // 批量添加cell
        self.addCells([ZZFDGoodRecCell class]).toSection(ZZFDGoodSectionTypeRec).withDataModelArray(data).selectedAction(^ (id data) {
            @strongify(self);
            ZZFDGoodDetailViewController *vc = [[ZZFDGoodDetailViewController alloc] initWithListModel:data];
            PushVC(vc);
        });
        [self reloadView];
    } failure:^(NSString *errMsg) {
        [TLToast dismiss];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        
        [TLToast showErrorToast:errMsg];
    }];
}


@end
