//
//  NSURLSession+Proxy.m
//  ProxyTest
//
//  Created by 高鹏 on 2020/4/22.
//  Copyright © 2020 高鹏. All rights reserved.
//

#import "NSURLSession+Proxy.h"

@implementation NSURLSession (Proxy)

+ (NSURLSession*)ppg_sessionWithConfiguration:(NSURLSessionConfiguration*)configuration delegate:(nullable id)delegate delegateQueue:(nullable NSOperationQueue*)queue {
    
    if(configuration) configuration.connectionProxyDictionary = [self proxyDict];
    
    return [self ppg_sessionWithConfiguration:configuration delegate:delegate delegateQueue:queue];
    
}

+ (NSURLSession*)ppg_sessionWithConfiguration:(NSURLSessionConfiguration*)configuration {
    
    if(configuration) configuration.connectionProxyDictionary = [self proxyDict];

    return [self ppg_sessionWithConfiguration:configuration];
}

+ (NSDictionary *)proxyDict {
    static NSDictionary *_proxyDict;
    if (_proxyDict == nil) {
        NSString* proxyHost =  @"192.168.10.115";
        NSNumber* proxyPort = [NSNumber numberWithInt: 8888];

        // 创建一个代理服务器，包括HTTP或HTTPS代理，当然还可以添加SOCKS,FTP,RTSP等
        _proxyDict = @{
//            (NSString *)kCFNetworkProxiesHTTPEnable  : [NSNumber numberWithInt:1],
//            (NSString *)kCFNetworkProxiesHTTPProxy: proxyHost,
//            (NSString *)kCFNetworkProxiesHTTPPort: proxyPort,
            
            // 由于 CFNetwork/CFProxySupport.h 中的有些常量，只标识为 macOS 可用，iOS 上是访问不到的，所以可以直接写为字符串常量
            @"HTTPEnable": @YES,
            @"HTTPProxy": proxyHost,
            @"HTTPPort": proxyPort,
            
            @"HTTPSEnable": @YES,
            @"HTTPSProxy": proxyHost,
            @"HTTPSPort": proxyPort,
            
            @"SOCKSEnable": @YES,
            @"SOCKSProxy": proxyHost,
            @"SOCKSPort": proxyPort
        };
    }
    return _proxyDict;
}

@end
