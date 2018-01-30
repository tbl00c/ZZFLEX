//
//  ZZFDGoodListModel.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/11/28.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFDGoodListModel.h"

ZZFDGoodParamModel *createParamModel(NSString *key, NSString *value)
{
    ZZFDGoodParamModel *model = [[ZZFDGoodParamModel alloc] init];
    model.key = key;
    model.value = value;
    return model;
}

ZZFDGoodCommitModel *createCommitModel(NSString *name, NSString *avatar, NSString *date, NSString *detail)
{
    ZZFDGoodCommitModel *model = [[ZZFDGoodCommitModel alloc] init];
    model.userName = name;
    model.avatar = avatar;
    model.date = date;
    model.detail = detail;
    return model;
}

@implementation ZZFDGoodListModel

- (instancetype)init
{
    if (self = [super init]) {
        _commitData = @[].mutableCopy;
    }
    return self;
}

- (NSAttributedString *)attrPrice
{
    if (self.price.length == 0) {
        return nil;
    }
    
    NSString *centsPrice = [NSString stringWithFormat:@"¥ %@", self.price];
    
    NSMutableAttributedString *mutableStr = [[NSMutableAttributedString alloc] initWithString:centsPrice];
    [mutableStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 1)];
    [mutableStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:6] range:NSMakeRange(1, 2)];
    [mutableStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(2, self.price.length)];
    [mutableStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, mutableStr.length)];
    return mutableStr;
}

- (void)setGoodDetail:(NSString *)goodDetail
{
    _goodDetail = goodDetail;
    if (goodDetail.length > 0) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:goodDetail
                                                                                             attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14],
                                                                                                          NSForegroundColorAttributeName : [UIColor blackColor]
                                                                                                          }];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:3];
        [paragraphStyle setParagraphSpacing:4];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedString.string.length)];
        _attrGoodDetail = attributedString;
    }
    else {
        _attrGoodDetail = nil;
    }
}

+ (void)requestHomePageDataWithOffset:(NSInteger)offset
                              success:(void (^)(NSArray *data))success
                              failure:(void (^)(NSString *errMsg))failure
{
    ZZFDGoodListModel *model1 = ({
        ZZFDGoodListModel *model = [[ZZFDGoodListModel alloc] init];
        model.goodId = @"1";
        model.goodTitle = @"苹果iPhone X，日版256G，全新未激活，支持邮寄验机哦";
        model.goodDetail = @"托朋友从日本带回来两台iPhoneX，黑白两个颜色，其中一台转手，可任选。\n价格就是日本appstore价格加上10%消费税（不懂可自行百度），加上100代购费，大约8400左右，比国内便宜1200。\n不了解日版和行货差别请先百度，有需要的联系";
        model.goodFirstImage = @"good1";
        model.position = @"北京 | 朝阳";
        model.lastLoginIn = @"刚刚来过";
        model.price = @"8399";
        model.params = @[createParamModel(@"机身颜色", @"黑色/白色"),
                         createParamModel(@"容量", @"256G"),
                         createParamModel(@"购买渠道", @"其他")];
        model.goodImages = @[@"1-1", @"1-2", @"1-3", @"1-4", @"1-5", @"1-6", @"1-7", @"1-8", @"1-1", @"1-2", @"1-3", @"1-4"];
        model.avatar = @"avatar1";
        model.username = @"张心心";
        model.goodCount = 2;
        model.tradeCount = 1;
        model.commitCount = 90;
        model.zhimaCount = 888;
        
        model.commitData = @[createCommitModel(@"小古月", @"avatar2", @"1小时前", @"手机不错哦，楼主可以便宜一点吗，恰好想买一台白色的~~"),
                             createCommitModel(@"Kervin松", @"avatar4", @"一天前", @"Note8换吗？")].mutableCopy;
        
        model;
    });
    
    ZZFDGoodListModel *model2 = ({
        ZZFDGoodListModel *model = [[ZZFDGoodListModel alloc] init];
        model.goodId = @"2";
        model.goodTitle = @"三星Note8，128G 9成新，不爆炸";
        model.goodDetail = @"港版三星note8 128G，已刷国行版本，带蓝色全套包装发票，购于香港丰泽，带发票，限莆田涵江地区当面交易！";
        model.goodFirstImage = @"good2";
        model.position = @"莆田 | 涵江";
        model.lastLoginIn = @"21分钟前来过";
        model.price = @"6500";
        model.params = @[createParamModel(@"容量", @"128G"),];
        model.goodImages = @[@"good2", @"2-1", @"2-2"];
        model.avatar = @"avatar2";
        model.username = @"小古月";
        model.goodCount = 22;
        model.tradeCount = 108;
        model.commitCount = 49;
        model.zhimaCount = 765;
        model;
    });
    
    ZZFDGoodListModel *model3 = ({
        ZZFDGoodListModel *model = [[ZZFDGoodListModel alloc] init];
        model.goodId = @"5";
        model.goodTitle = @"118升实用冰箱，银色。九成新！ 请走转转担保交易，喜欢的话就赶快联系我吧。";
        model.goodDetail = @"搬家急售，正常使用没毛病";
        model.goodFirstImage = @"good5";
        model.position = @"北京 | 海淀";
        model.lastLoginIn = @"2天前来过";
        model.price = @"1288";
        model.goodImages = @[@"good5", @"5-1", @"5-2", @"good5", @"5-1", @"5-2"];
        model.avatar = @"avatar4";
        model.username = @"Kervin松";
        model.goodCount = 2;
        model.tradeCount = 0;
        model.commitCount = 0;
        model.zhimaCount = 650;
        model;
    });
    
    ZZFDGoodListModel *model4 = ({
        ZZFDGoodListModel *model = [[ZZFDGoodListModel alloc] init];
        model.goodId = @"4";
        model.goodTitle = @"全新kindle voyage一台，单位工会奖品，已拆封，未激活未使用，1050元转让，限青岛市南同城交易";
        model.goodDetail = @"全新的哦，JD商城2k+相当于半价出售，所以价格就不刀了，好货不等人，喜欢联系。";
        model.goodFirstImage = @"good4";
        model.position = @"山东 | 青岛";
        model.lastLoginIn = @"30分钟前来过";
        model.price = @"1001";
        model.goodImages = @[@"good4"];
        model.avatar = @"avatar2";
        model.username = @"小古月";
        model.goodCount = 22;
        model.tradeCount = 108;
        model.commitCount = 49;
        model.zhimaCount = 765;
        
        model.commitData = @[createCommitModel(@"小古月", @"avatar2", @"1小时前", @"设备还在吗？")].mutableCopy;
        
        model;
    });
    
    ZZFDGoodListModel *model5 = ({
        ZZFDGoodListModel *model = [[ZZFDGoodListModel alloc] init];
        model.goodId = @"3";
        model.goodTitle = @"Macbook pro 15.5寸，带touch bar，用了半年无拆无修无暗病，低价转让，不议价哦~";
        model.goodFirstImage = @"good3";
        model.position = @"甘肃 | 兰州";
        model.lastLoginIn = @"6小时前来过";
        model.price = @"5333";
        model.params = @[createParamModel(@"型号", @"Macbook Pro"),
                         createParamModel(@"CPU", @"Inter Core i7"),
                         createParamModel(@"内存", @"32G"),
                         createParamModel(@"硬盘", @"1TB SSD"),
                         ];
        model.goodImages = @[@"good3", @"3-1", @"3-2", @"3-3"];
        model.avatar = @"avatar5";
        model.username = @"你看这名拉风不";
        
        model.commitData = @[createCommitModel(@"张心心", @"avatar1", @"1小时前", @"哇，这么高的配置，价格还这么便宜，不太敢买哎")].mutableCopy;
        
        model;
    });
    
    ZZFDGoodListModel *model6 = ({
        ZZFDGoodListModel *model = [[ZZFDGoodListModel alloc] init];
        model.goodId = @"6";
        model.goodTitle = @"床上四件套，全新，量大从优，喜欢留言哦";
        model.goodFirstImage = @"good6";
        model.position = @"山东 | 滨州";
        model.lastLoginIn = @"上周来过";
        model.price = @"328";
        model.goodImages = @[@"good6", @"6-1", @"6-2", @"good6", @"6-1", @"6-2", @"good6"];
        model.avatar = @"avatar1";
        model.username = @"张心心";
        model.goodCount = 2;
        model.tradeCount = 1;
        model.commitCount = 90;
        model.zhimaCount = 888;
        model;
    });
        
    ZZFDGoodListModel *model7 = ({
        ZZFDGoodListModel *model = [[ZZFDGoodListModel alloc] init];
        model.goodId = @"7";
        model.goodTitle = @"蓝牙耳机,7成新，付邮赠送";
        model.goodDetail = @"来呀，快活呀";
        model.goodFirstImage = @"good7";
        model.position = @"美国 | 洛杉矶";
        model.lastLoginIn = @"1小时前来过";
        model.price = @"15";
        model.goodImages = @[@"good7", @"good7"];
        model.avatar = @"avatar3";
        model.username = @"狂飙的蜗牛";
        model;
    });
    
    NSArray *list = @[model1, model2, model3, model4, model5, model6, model7];
    
    
    NSMutableArray *data = @[].mutableCopy;
    for (int i = 0; i < (offset < 40 ? 20 : 10); i++) {
        [data addObject:[list[i % list.count] mutableCopy]];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (success) {
            success(data);
        }
    });
}

- (id)mutableCopyWithZone:(nullable NSZone *)zone
{
    ZZFDGoodListModel *model = [[ZZFDGoodListModel alloc] init];
    model.goodId = self.goodId;
    model.goodTitle = self.goodTitle;
    model.goodDetail = self.goodDetail;
    model.goodFirstImage = self.goodFirstImage;
    model.position = self.position;
    model.lastLoginIn = self.lastLoginIn;
    model.price = self.price;
    model.goodImages = self.goodImages.mutableCopy;
    model.avatar = self.avatar;
    model.username = self.username;
    model.commitData = self.commitData.mutableCopy;
    model.zhimaCount = self.zhimaCount;
    model.commitCount = self.commitCount;
    model.tradeCount = self.tradeCount;
    model.goodCount = self.goodCount;
    model.params = self.params.mutableCopy;
    return model;
}

@end

@implementation ZZFDGoodParamModel

@end

@implementation ZZFDGoodCommitModel

@end
