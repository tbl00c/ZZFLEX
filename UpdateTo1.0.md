## ZZFLEX 0.* 升级至 1.* 攻略

* 一共四个步骤，建议每次替换前二次确认

### 一、Masonry方法增加参数

全局搜索

```
asonry(^(MASConstraintMaker *make)
asonry(^ (MASConstraintMaker *make)
// 或其他类似写法，用于替换.masonry .updateMasonry .remakeMasonry方法
```

替换为

```
asonry(^ (__kindof UIView *senderView, MASConstraintMaker *make)
```

### 二、.zz_make方法替换为.zz_setup

全局搜索

```
.zz_make
```

替换为

```
.zz_setup
```

### 三、cell位置通知方法替换

全局搜索

```
- (void)viewIndexPath:(NSIndexPath *)indexPath sectionItemCount:(NSInteger)count
```

替换为

```
- (void)onViewPositionUpdatedWithIndexPath:(NSIndexPath *)indexPath sectionItemCount:(NSInteger)count
```

### 四、cell添加方法替换

#### 4.1 前半部分替换

##### 4.1.1 addCell、insertCell方法

全局搜索
```
ell(@"
```

替换为

```
ell([
```

##### 4.1.2 addCells、insertCells方法

全局搜索
```
ells(@"
```

替换为

```
ells([
```


##### 4.1.3 setHeader方法
 全局搜索
```
.setHeader(@"
```

替换为

```
.setHeader([
```

##### 4.1.4 setFooter方法
 全局搜索
```
.setFooter(@"
```

替换为

```
.setFooter([
```

#### 4.2 后半部分替换

后半部分由于大家风格很容易不同，所以可能需要特殊处理
```
").toSection(
```

替换为

```
 class]).toSection(
```

#### 4.3 缺失头文件引入

最麻烦的一步

开始编译，哪儿报错改哪儿