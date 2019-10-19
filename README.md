# INDataStatusDemo
iOS 无数据、无网络占位图、加载动画

这里作为一种简单的实现方式，希望对您有用。

### 使用方式，在BaseViewController中的viewDidLoad中按照以下使用即可

```
- (void)viewDidLoad {
[super viewDidLoad];
self.view.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
self.view.exclusiveTouch = YES;
self.view.clipsToBounds = YES;

self.automaticallyAdjustsScrollViewInsets = NO;
self.extendedLayoutIncludesOpaqueBars = YES;
[self.navigationController setNavigationBarHidden:NO animated:NO];

self.view.statusOriginSize = [UIScreen mainScreen].bounds.size;
self.view.edgeInset = UIEdgeInsetsMake(kStatusBarHeight+44.0, 0.0, 0.0, 0.0);
self.view.noDataStatusView = [INDefaultDataStatus noDataStatusView];
self.view.netErrorStatusView = [INDefaultDataStatus netErrorStatusView];
self.view.loadingView = [INDefaultDataStatus dataLoadingView];

__block __weak typeof(self) weakSelf = self;
[self.view.noDataStatusView bindDataStatusItem:[INDefaultDataStatus defaultNoDataItem:^{
NSLog(@"no Data Touched");
[weakSelf statusDidTouched];
}]];

[self.view.netErrorStatusView bindDataStatusItem:[INDefaultDataStatus defaultNetErrorItem:^{
NSLog(@"net Error Touched");
[weakSelf statusDidTouched];
}]];

self.view.loadingView = [INDefaultDataStatus dataLoadingView];
}

```

在BaseViewController子Controller中使用的话
动画效果，代码如下

```
- (void)viewDidLoad {
[super viewDidLoad];

self.view.loadingView = [INDefaultDataStatus dataLoadingView];
}

```
无数据类型

```
[self.view showNoDataStatus];

```

网络异常类型

```
[self.view showNetErrorStatus];

```

###  更换样式，则修改默认的INDataStatusItem即可

例如以下代码

```
__block __weak typeof(self) weakSelf = self;
INDataStatusItem *statusItem = [INDefaultDataStatus defaultNoDataItem:^{
    NSLog(@"no Data Touched refresh");
    [weakSelf statusDidTouched];
}];
statusItem.iconImage = [UIImage imageNamed:@"placeholder_airbnb"];
statusItem.bgColor = rgb(255, 255, 255);
statusItem.hasBtn = YES;
statusItem.title = @"No Messages";
statusItem.titleColor = [UIColor colorWithHexString:@"c9c9c9"];
statusItem.detail = @"When you have messages, you’ll see them here.";
statusItem.detailColor = [UIColor colorWithHexString:@"cfcfcf"];
statusItem.btnTitle = @"Start Browsing";
[self.view.noDataStatusView bindDataStatusItem:statusItem];

```

### 示例图

* 默认无数据

http://sphoto.laileshuo.com/b0d2a8a21e1ae193856830dd0a4d0e7c-3.png

![image](http://sphoto.laileshuo.com/b0d2a8a21e1ae193856830dd0a4d0e7c-9.png?imageView2/2/w/400)

* 网络请求异常

![image](http://sphoto.laileshuo.com/b0d2a8a21e1ae193856830dd0a4d0e7c-1.png?imageView2/2/w/400)

* Facy

![image](http://sphoto.laileshuo.com/b0d2a8a21e1ae193856830dd0a4d0e7c-5.png?imageView2/2/w/400)

* airbnb

![image](http://sphoto.laileshuo.com/b0d2a8a21e1ae193856830dd0a4d0e7c-8.png?imageView2/2/w/400)

* Dropbox

![image](http://sphoto.laileshuo.com/b0d2a8a21e1ae193856830dd0a4d0e7c-4.png?imageView2/2/w/400)

* instagram

![image](http://sphoto.laileshuo.com/b0d2a8a21e1ae193856830dd0a4d0e7c-7.png?imageView2/2/w/400)

* qq

![image](http://sphoto.laileshuo.com/b0d2a8a21e1ae193856830dd0a4d0e7c-3.png?imageView2/2/w/400)

* yy

![image](http://sphoto.laileshuo.com/b0d2a8a21e1ae193856830dd0a4d0e7c-10.png?imageView2/2/w/400)

* jd

![image](http://sphoto.laileshuo.com/b0d2a8a21e1ae193856830dd0a4d0e7c-6.png?imageView2/2/w/400)


谢谢您的阅读，希望本站及文档能带给你帮助，给你带来简洁明了的阅读体验。谢谢。

github：[https://github.com/goodbruce/INDataStatusDemo](https://github.com/goodbruce/INDataStatusDemo)

本文地址：[http://www.laileshuo.com/?p=1496](http://www.laileshuo.com/?p=1496)

博客地址：[www.laileshuo.com](http://www.laileshuo.com) 
