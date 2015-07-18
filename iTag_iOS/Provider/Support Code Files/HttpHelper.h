//
//  HttpHelper.h
//  i-Tag_Provider
//
// Created by WENG Lilion 15/7/5.
// Copyright (c) 2015 WENG Lili. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface HttpHelper : NSObject

+ (BOOL)NetWorkIsOK;//检查网络是否可用
+ (void)post:(NSString *)Url RequestParams:(NSDictionary *)params FinishBlock:(void (^)(NSURLResponse *response, NSData *data, NSError *connectionError)) block;//post请求封装

@end
