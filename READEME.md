### 本项目参考了大量Coding-iOS源代码

### Step-it-up客户端项目介绍 
*编译环境:Xcode-Version 7.0 beta 3 (7A152u)


####下面介绍一下文件的大概目录先:
.
├── Coding_iOS
│   ├── Models:数据类
│   ├── Views:视图类
│   ├── JFT0M:宏定义和Pch（用来导入有些全局需要的头文件）[Pch文件路径需要在项目设置中添加]
│   ├── StoryBoard:放了Todo页面的故事版
│   │   ├── CCell:所有的CollectionViewCell都在这里
│   │   ├── Cell:所有的TableViewCell都在这里
│   │   └── XXX:ListView（项目、动态、任务、讨论、文档、代码）和InputView（用于聊天和评论的输入 框）
│   ├── Controllers:控制器，对应app中的各个页面
│   │   ├── Discover:发现页面
│   │   ├── Reuse:在不同地方被调用的同一个页面的基类控制器
│   │   ├── Todo:日程页面
│   │   ├── Login:登录页面
│   │   ├── RootControllers:登录后的根页面
│   │   └── XXX:其它页面
│   ├── Images:Coding-iOS中用到的所有的图片都在这里
│   ├── Assets.xcassets:Step-it-up中的项目资源
│   ├── JFMacros.h:宏定义文件
│   ├── Resources:资源文件
│   ├── Util:一些常用控件和Category、Manager之类
│   │   ├── Common
│   │   ├── Manager
│   │   └── OC_Category（扩展）
│   └── Vendor:用到的一些第三方类库[一般都有改动]
│       ├── AFNetworking
│       └──（其他）
└── Pods:项目使用了[CocoaPods](http://code4app.com/article/cocoapods-install-usage)这个类库管理工具


####[CocoaPods](http://cocoapods.org/)里面用到的第三方类库
- [SDWebImage](https://github.com/rs/SDWebImage):图片加载
- [TTTAttributedLabel](https://github.com/TTTAttributedLabel/TTTAttributedLabel):富文本的label，可点击链接
- [RegexKitLite](https://github.com/wezm/RegexKitLite):正则表达式
- [hpple](https://github.com/topfunky/hpple):html解析
- [MBProgressHUD](https://github.com/jdg/MBProgressHUD):hud提示框
- [ODRefreshControl](https://github.com/Sephiroth87/ODRefreshControl):下拉刷新
- [TPKeyboardAvoiding](https://github.com/michaeltyson/TPKeyboardAvoiding):有文字输入时，能根据键盘是否弹出来调整自身显示内容的位置
- [JDStatusBarNotification](https://github.com/jaydee3/JDStatusBarNotification):状态栏提示框
- [BlocksKit](https://github.com/zwaldowski/BlocksKit):block工具包。将很多需要用delegate实现的方法整合成了block的形式
- [ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa):基于响应式编程思想的oc实践（是个好东西呢）

####Tips
- [导航栏隐藏]在Info.plist中添加"UIViewControllerBasedStatusBarAppearance = false" 
使得允许自定义Status Bar 的样式 和隐藏
- [tabBar隐藏]在UIViewController+Swizzle中对ViewController的文件名进行判断，判断是否需要隐藏



####文档更新时间：2015-8-23




