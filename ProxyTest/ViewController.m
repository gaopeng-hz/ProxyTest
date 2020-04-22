//
//  ViewController.m
//  ProxyTest
//
//  Created by 高鹏 on 2020/4/22.
//  Copyright © 2020 高鹏. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "NSURLSession+Proxy.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *proxySwitch;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _proxySwitch.on = NO;
}

- (IBAction)detectProxy:(id)sender {
    CFDictionaryRef dicRef = CFNetworkCopySystemProxySettings();
    
    const CFStringRef proxyCFstr = CFDictionaryGetValue(dicRef, (const void*)kCFNetworkProxiesHTTPProxy);
    
    NSString* proxy = (__bridge NSString*)(proxyCFstr);
    if(proxy) {
        NSLog(@"检测到代理: %@", proxy);
    } else {
        NSLog(@"未检测到代理");
    }
}

- (IBAction)testRequest:(id)sender {
    
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

    NSURL *url = [NSURL URLWithString:@"http://www.oschina.net"];
    // 通过URL初始化task,在block内部可以直接对返回的数据进行处理
    NSURLSessionTask *task = [session dataTaskWithURL:url
                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError* error) {
        NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    }];
    // 启动任务
    [task resume];
}

@end
