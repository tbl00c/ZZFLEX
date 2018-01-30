//
//  ZZFDCateModel.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/12/19.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFDCateModel.h"

ZZFDCateSectionModel *createSection(NSString *name, NSArray *items) {
    ZZFDCateSectionModel *section = [[ZZFDCateSectionModel alloc] init];
    section.sectionName = name;
    section.cateSectionItems = items;
    return section;
}

ZZFDCateItemModel *createItem(NSString *title, NSString *image) {
    ZZFDCateItemModel *item = [[ZZFDCateItemModel alloc] init];
    item.itemName = title;
    item.itemImageName = image;
    return item;
}

ZZFDCateModel *createCateModel(NSString *title, NSArray *items) {
    ZZFDCateModel *item = [[ZZFDCateModel alloc] init];
    item.cateName = title;
    item.cateSectionItems = items;
    return item;
}

@implementation ZZFDCateModel

+ (void)requestCateModelSuccess:(void (^)(NSArray<ZZFDCateModel *> *data))success
                        failure:(void (^)(NSString *errMsg))failure
{
    NSMutableArray *data = @[].mutableCopy;
    {
        NSArray *items;
        items = @[createItem(@"苹果", @""),
                  createItem(@"华为", @""),
                  createItem(@"三星", @""),
                  createItem(@"小米", @""),
                  createItem(@"OPPO", @""),
                  createItem(@"VIVO", @""),
                  createItem(@"魅族", @""),
                  createItem(@"酷派", @""),
                  createItem(@"金立", @""),
                  createItem(@"乐视", @""),
                  createItem(@"努比亚", @""),
                  createItem(@"锤子", @""),
                  ];
        ZZFDCateSectionModel *section1 = createSection(@"热门品牌", items);
        
        items = @[createItem(@"iPhone 6", @""),
                  createItem(@"iPhone 6s", @""),
                  createItem(@"iPhone 6p", @""),
                  createItem(@"iPhone 5s", @""),
                  createItem(@"iPhone 6sp", @""),
                  createItem(@"iPhone 7P", @""),
                  createItem(@"iPhone 7", @""),
                  createItem(@"华为P8", @""),
                  createItem(@"华为P9", @""),
                  createItem(@"华为Mate9", @""),
                  createItem(@"三星S7edge", @""),
                  createItem(@"小米5", @""),
                  ];
        ZZFDCateSectionModel *section2 = createSection(@"热门型号", items);
        
        ZZFDCateModel *model = createCateModel(@"手机", @[section1, section2]);
        [data addObject:model];
    }
    {
        NSArray *items;
        items = @[createItem(@"婴儿床", @""),
                  createItem(@"婴儿推车", @""),
                  createItem(@"宝宝餐椅", @""),
                  createItem(@"儿童玩具", @""),
                  createItem(@"学步车", @""),
                  createItem(@"安全座椅", @""),
                  ];
        ZZFDCateSectionModel *section1 = createSection(@"热门推荐", items);
        
        items = @[createItem(@"婴幼服饰", @""),
                  createItem(@"童车童床", @""),
                  createItem(@"尿裤湿巾", @""),
                  createItem(@"奶粉辅食", @""),
                  createItem(@"玩具图书", @""),
                  createItem(@"喂养用具", @""),
                  createItem(@"孕妈用品", @""),
                  createItem(@"洗护用具", @""),
                  createItem(@"安全座椅", @""),
                  createItem(@"其他", @""),
                  ];
        ZZFDCateSectionModel *section2 = createSection(@"全部母婴用品", items);
        
        ZZFDCateModel *model = createCateModel(@"母婴", @[section1, section2]);
        [data addObject:model];
    }
    {
        NSArray *items;
        items = @[createItem(@"数码相机", @""),
                  createItem(@"单反相机", @""),
                  createItem(@"运动相机", @""),
                  createItem(@"微单相机", @""),
                  createItem(@"拍立得", @""),
                  createItem(@"摄像机", @""),
                  ];
        ZZFDCateSectionModel *section1 = createSection(@"摄影摄像", items);
        
        items = @[createItem(@"入耳式耳机", @""),
                  createItem(@"头戴式耳机", @""),
                  createItem(@"蓝牙耳机", @""),
                  createItem(@"游戏耳机", @""),
                  createItem(@"音箱", @""),
                  createItem(@"蓝牙音响", @""),
                  ];
        ZZFDCateSectionModel *section2 = createSection(@"耳机音响", items);
        
        
        items = @[createItem(@"移动电源", @""),
                  createItem(@"U盘", @""),
                  createItem(@"移动硬盘", @""),
                  createItem(@"充电头", @""),
                  createItem(@"数据线", @""),
                  ];
        ZZFDCateSectionModel *section3 = createSection(@"数码配件", items);
        
        items = @[createItem(@"智能穿戴", @""),
                  createItem(@"VR眼镜", @""),
                  createItem(@"平衡车", @""),
                  ];
        ZZFDCateSectionModel *section4 = createSection(@"智能设备", items);
        
        items = @[createItem(@"游戏机", @""),
                  createItem(@"手柄", @""),
                  createItem(@"游戏键鼠", @""),
                  ];
        ZZFDCateSectionModel *section5 = createSection(@"游戏设备", items);
        
        ZZFDCateModel *model = createCateModel(@"潮流数码", @[section1, section2, section3, section4, section5]);
        [data addObject:model];
    }
    
    if (success) {
        success(data);
    }
}

@end

@implementation ZZFDCateSectionModel

@end

@implementation ZZFDCateItemModel

@end
