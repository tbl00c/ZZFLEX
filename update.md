## ZZFLEX更新记录

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
