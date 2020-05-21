## ZZFLEX更新记录

### 1.0
1、addCell时，类型由类名字符串变更为class；

```objective-c
self.addCell([ACell class]).toSection(sectionTag)
```

2、ZZFLEXViewExtension新增圆角支持;

```objective-c
self.setCornor(ZZCornerPositionAll).radius(cornorRadius);
```

3、UICollectionView支持卡片类型支持（设置sectionEdge后，在cell中根据位置设置圆角即可）；

4、ZZFLEXViewExtension中Masonry设置方法，加增view参数，便于设置与自身关系；

```objective-c
UIImageView *imageView = self.addImageView(0)
.masonry(^ (UIView *senderView, MASConstraintMaker *make) {
    make.top.left.bottom.mas_equalTo(0);
    make.height.mas_equalTo(senderView);
})
.view;
```

5、新增ZZFLEXFoundationExtension，支持NSAttributeString的链式调用;

```objective-c
NSAttributedString *attrTitle = NSMutableAttributedString.zz_create(@"Hello world").font([UIFont boldSystemFontOfSize:17]).foregroundColor([UIColor redColor]).object;
```

6、ZZFLEXViewExtension中```zz_make```属性更名为```zz_setup```;

7、ZZFlexibleLayoutViewProtocol中，cell位置通知方法名变给为

```objective-c
- (void)onViewPositionUpdatedWithIndexPath:(NSIndexPath *)indexPath sectionItemCount:(NSInteger)count;
```

8、ZZFLEXRequestQueue支持progress；

9、强依赖Masonry；

10、ZZFLEXCollectionViewController重构，使用ZZFlexAngel核心逻辑；

11、更多逻辑性能优化、BUG修复；

### 0.3.0

1、增加XIB支持。

### 0.2.4

1、ZZFlexVC、ZZFLEXAngel新增```clearAllItems()``` 方法，不删除section，仅清空section内容；

2、ZZFlexVC、ZZFLEXAngel新增```updateAllItems()``` 方法;

3、Section管理新增clearItems、updateItems API。

### 0.2.2
1、ZZFlexVC新增```isEmpty()```方法

2、ZZFLEXRequestQueue BUG修复

### 0.2.1
1、新增已有列表页不修改cell代码、迁移至ZZFLEX列表页方案

```
self.addCells([ZZFDAlbumCell class]).toSection(sectionType).withDataModelArray(data)
.configAction(^(ZZFDAlbumCell *cell, ZZFDAlbumModel *model) {   // 配置cell，等价于cellForRowAtIndexPath时的配置逻辑
    [cell setModel:model];
})
.viewSize(CGSizeMake(itemWidth, itemWidth))         // 设置大小
.selectedAction(^ (ZZFDAlbumModel *model) {         // 点击事件，等价于didSelectRowAtIndexPath时的逻辑
    [XLPhotoBrowser showPhotoBrowserWithImages:@[model.image] currentImageIndex:0];
});
```

2、UITextFiled增加enable api

### 0.2.0
1、addCell新增```configAction(__kindof UIView *itemView, id dataModel)```方法，可以使用传统方式配置cell属性，示例：

```
self.addCell([ACell class]).toSection(sectionTag).configAction(^(UITableViewCell *cell, id model) {
    [cell.textLabel setText:model.name];
    [cell.detailTextLabel setText:model.phoneNumber];
    [cell setBackgroundColor:model.bgColor];
});
```
