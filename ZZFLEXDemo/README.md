# ZZFLEX Demo

Demo 的最低运行版本为 iOS 15.0，使用 CocoaPods 管理依赖。此设置仅用于 Demo，不改变根目录 `ZZFLEX.podspec` 声明的库兼容范围。

在此目录执行：

```sh
pod install
open ZZFLEXDemo.xcworkspace
```

选择 `ZZFLEXDemo` scheme 和 iOS 模拟器后运行。请打开 workspace，以便一并构建 Pods。

仓库中保留的 Pods 文件可能不完整。如果出现 `SDWebImage/UIImageView+WebCache.h`、`MJRefreshConfig.h` 等依赖头文件缺失，先备份现有 Pods，再按 `Podfile.lock` 重装：

```sh
mv Pods "Pods.backup.$(date +%Y%m%d%H%M%S)"
pod install
```

不要删除 `Podfile.lock` 或使用 `pod update` 来修复文件缺失，以免同时改变依赖版本。Podfile 的 `post_install` 会统一生成的 Pod targets 的最低版本，避免旧依赖使用 iOS 8/9 配置导致新 Xcode 的 deployment target 或 `libarclite` 错误。
