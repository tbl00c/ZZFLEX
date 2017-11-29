//
//  ZZFDGoodListModel.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/11/28.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFDGoodListModel.h"

@implementation ZZFDGoodListModel

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

+ (void)requestHomePageDataWithOffset:(NSInteger)offset
                              success:(void (^)(NSArray *data))success
                              failure:(void (^)(NSString *errMsg))failure
{
    ZZFDGoodListModel *model1 = ({
        ZZFDGoodListModel *model = [[ZZFDGoodListModel alloc] init];
        model.goodId = @"1";
        model.goodTitle = @"苹果iPhone X，国行黑色256G，全新未激活，支持转转邮寄验机";
        model.goodFirstImage = @"good1";
        model.position = @"北京 | 朝阳";
        model.lastLoginIn = @"刚刚来过";
        model.price = @"8399";
        model;
    });
    
    ZZFDGoodListModel *model2 = ({
        ZZFDGoodListModel *model = [[ZZFDGoodListModel alloc] init];
        model.goodId = @"2";
        model.goodTitle = @"三星Note8，128G 9成新，不爆炸";
        model.goodFirstImage = @"good2";
        model.position = @"云南 | 大理";
        model.lastLoginIn = @"21分钟前来过";
        model.price = @"6500";
        model;
    });
    
    ZZFDGoodListModel *model3 = ({
        ZZFDGoodListModel *model = [[ZZFDGoodListModel alloc] init];
        model.goodId = @"3";
        model.goodTitle = @"Macbook pro 15寸，带touch bar，用了半年无拆无修无暗病，低价转让，不议价哦~";
        model.goodFirstImage = @"good3";
        model.position = @"甘肃 | 兰州";
        model.lastLoginIn = @"6小时前来过";
        model.price = @"5333";
        model;
    });
    
    ZZFDGoodListModel *model4 = ({
        ZZFDGoodListModel *model = [[ZZFDGoodListModel alloc] init];
        model.goodId = @"4";
        model.goodTitle = @"全新kindlevoyage一台，单位工会奖品，已拆封，未激活未使用，1050元转让，限北京同城交易";
        model.goodFirstImage = @"good4";
        model.position = @"山东 | 青岛";
        model.lastLoginIn = @"30分钟前来过";
        model.price = @"800";
        model;
    });
    
    ZZFDGoodListModel *model5 = ({
        ZZFDGoodListModel *model = [[ZZFDGoodListModel alloc] init];
        model.goodId = @"5";
        model.goodTitle = @"118升实用冰箱，银色。九成新！ 请走转转担保交易，喜欢的话就赶快联系我吧。";
        model.goodFirstImage = @"good5";
        model.position = @"北京 | 海淀";
        model.lastLoginIn = @"2天前来过";
        model.price = @"1288";
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
        model;
    });
        
    ZZFDGoodListModel *model7 = ({
        ZZFDGoodListModel *model = [[ZZFDGoodListModel alloc] init];
        model.goodId = @"7";
        model.goodTitle = @"蓝牙耳机,7成新，付邮赠送";
        model.goodFirstImage = @"good7";
        model.position = @"美国 | 洛杉矶";
        model.lastLoginIn = @"1小时前来过";
        model.price = @"15";
        model;
    });
    
    NSArray *list = @[model1, model2, model3, model4, model5, model6, model7];
    
    
    
    
    NSMutableArray *data = @[].mutableCopy;
    for (int i = 0; i < (offset < 40 ? 20 : 10); i++) {
        [data addObject:list[i % list.count]];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (success) {
            success(data);
        }
    });
}

@end
