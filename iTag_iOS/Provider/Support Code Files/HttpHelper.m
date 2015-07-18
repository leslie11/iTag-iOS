//
//  HttpHelper.m
//  i-Tag_Provider
//
// Created by WENG Lilion 15/7/5.
// Copyright (c) 2015 WENG Lili. All rights reserved.
//

//  HttpHelper.m

#import "HttpHelper.h"

@implementation HttpHelper
    NSMutableData *_myData;

//这个函数是判断网络是否可用的函数（wifi或者蜂窝数据可用，都返回YES）
+ (BOOL)NetWorkIsOK{
    if(
       ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus]
        != NotReachable)
       &&
       ([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus]
        != NotReachable)
       ){
        return YES;
    }else{
        return NO;
    }
}

//post异步请求封装函数
+ (void)post:(NSString *)URL RequestParams:(NSDictionary *)params FinishBlock:(void (^)(NSURLResponse *response, NSData *data, NSError *connectionError)) block{
    //把传进来的URL字符串转变为URL地址
    NSURL *url = [NSURL URLWithString:URL];
    //请求初始化，可以在这针对缓存，超时做出一些设置
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:20];
    //解析请求参数，用NSDictionary来存参数，通过自定义的函数parseParams把它解析成一个post格式的字符串
    NSString *parseParamsResult = [self parseParams:params];
    NSData *postData = [parseParamsResult dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
    //创建一个新的队列（开启新线程）
    NSOperationQueue *queue = [NSOperationQueue new];
    //发送异步请求，请求完以后返回的数据，通过completionHandler参数来调用
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:block];
    //    return result;
}

//把NSDictionary解析成post格式的NSString字符串
+ (NSString *)parseParams:(NSDictionary *)params{
    NSString *keyValueFormat;
    NSMutableString *result = [NSMutableString new];
    //实例化一个key枚举器用来存放dictionary的key
    NSEnumerator *keyEnum = [params keyEnumerator];
    id key;
    while (key = [keyEnum nextObject]) {
        keyValueFormat = [NSString stringWithFormat:@"%@=%@&",key,[params valueForKey:key]];
        [result appendString:keyValueFormat];
        NSLog(@"post()方法参数解析结果：%@",result);
    }
    return result;
}
#pragma mark URLConnectionDataDelegate
//接受服务器响应－－接收到服务器回应的时候会执行该方法
/*-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    NSLog(@"服务器响应");
    
    self._myData = [NSMutableData dataWithCapacity:5000];
}
//接收服务器数据－－接收服务器传输数据的时候会调用，会根据数据量的大小，多次执行
-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"服务器返回数据");
    
    //将返回数据放入缓存区
    [self._myData appendData:data];
}
//显示数据，直到所有的数据接收完毕
-(void) connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"数据接受完毕");
    
    NSLog(@"myData=%@",self._myData);
}
//接受失败的时候调用的方法（断网或者是连接超时）
-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"数据接受失败，失败原因：%@",[error localizedDescription]);
}*/

@end