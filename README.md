# ProxyTest

在开发APP的时候经常会需要抓包看数据，我常用的抓包软件是Charles，需要抓包的时候，每次都需要进到WIFI设置中填写IP和端口，这样太麻烦了。

为了方便，这里使用NSURLSessionConfiguration中的connectionProxyDictionary进行代理设置，程序中可以动态启用或者停用代理。


```objective-c
NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
if (_proxySwitch.on) {
    // 设置代理
    configuration.connectionProxyDictionary = [NSURLSession proxyDict];
} else {
    // 禁止代理
    configuration.connectionProxyDictionary = @{};
}
// 使用配置的configuration创建session对象
NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:[NSOperationQueue mainQueue]];

NSURLSessionTask *task = [session dataTaskWithURL:...];

[tash resume];
```