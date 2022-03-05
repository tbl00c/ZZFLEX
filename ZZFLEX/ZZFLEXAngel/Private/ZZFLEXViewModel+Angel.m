//
//  ZZFLEXViewModel+Angel.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2019/1/20.
//  Copyright © 2019 李伯坤. All rights reserved.
//

#import "ZZFLEXViewModel+Angel.h"
#import "ZZFLEXAngel.h"

@implementation ZZFLEXViewModel (Angel)

- (CGSize)visableSizeForHostView:(__kindof UIView *)hostView angel:(ZZFLEXAngel *)angel sectionInsets:(UIEdgeInsets)sectionInsets {
    CGFloat width = self.viewSize.width;
    if (width < 0) {
        CGFloat viewWidth = hostView.frame.size.width  - sectionInsets.left - sectionInsets.right;
        width = viewWidth * -width;
    }
    width = MAX(width, 0.00001);
    
    CGFloat height = self.viewSize.height;
    if (height < 0) {
        height = hostView.frame.size.height * -height;
    }
    height = MAX(height, 0.00001);
    return CGSizeMake((NSInteger)width, (NSInteger)height);
}

- (void)excuteConfigActionForHostView:(__kindof UIView *)hostView itemView:(__kindof UIView<ZZFlexibleLayoutViewProtocol> *)itemView sectionCount:(NSInteger)sectionCount indexPath:(NSIndexPath *)indexPath {
    if ([itemView respondsToSelector:@selector(setViewDataModel:)]) {
        [itemView setViewDataModel:self.dataModel];
    }
    if ([itemView respondsToSelector:@selector(setViewDelegate:)]) {
        [itemView setViewDelegate:self.delegate];
    }
    if ([itemView respondsToSelector:@selector(setViewEventAction:)]) {
        [itemView setViewEventAction:self.eventAction];
    }
    if ([itemView respondsToSelector:@selector(onViewPositionUpdatedWithIndexPath:sectionItemCount:)]) {
        [itemView onViewPositionUpdatedWithIndexPath:indexPath sectionItemCount:sectionCount];
    }
    [itemView setTag:self.viewTag];
    if (self.configAction) {
        self.configAction(itemView, self.dataModel);
    }
}

- (void)excuteSelectedActionForHostView:(__kindof UIView *)hostView {
    if (self.selectedAction) {
        self.selectedAction(self.dataModel);
    }
}

@end
