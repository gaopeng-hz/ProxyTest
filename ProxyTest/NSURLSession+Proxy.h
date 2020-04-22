//
//  NSURLSession+Proxy.h
//  ProxyTest
//
//  Created by 高鹏 on 2020/4/22.
//  Copyright © 2020 高鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURLSession (Proxy)

+ (NSDictionary *)proxyDict;

@end

NS_ASSUME_NONNULL_END
