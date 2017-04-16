//
//  ZZJRequestCenter.m
//  NSURLSession
//
//  Created by 仲召俊 on 2017/4/10.
//  Copyright © 2017年 ZZJ. All rights reserved.
//

#import "ZZJRequestCenter.h"

@implementation ZZJRequestCenter

#pragma mark -- 创建单例
+ (instancetype)sharedNetWorkTool {
    
    static id instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

#pragma mark -- GET
- (void)GETRequestWithUrl:(NSString *)urlString paramaters:(NSDictionary *)paramaters successBlock:(SuccessBlcok)success FailBlock:(FailBlock)fail {
    
    /*
     创建请求
     */
    
    //参数拼接
    
    // 遍历参数字典,一一取出参数,按照参数格式拼接在 url 后面.
    NSMutableString *strM = [[NSMutableString alloc] init];
    
    [paramaters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
       
        //服务器接收参数的key
        NSString *paramaterKey = key;
        
        //参数内容
        NSString *paramaterValue = obj;
        
        //appendFormat: 可变字符串直接拼接的方法
        [strM appendFormat:@"%@=%@&",paramaterKey,paramaterValue];
    }];
    
    urlString = [NSString stringWithFormat:@"%@?%@",urlString,strM];
    
    //截取字符串的方法
    urlString = [urlString substringToIndex:urlString.length - 1];
    
    NSLog(@"urlString %@",urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15];
    
    /*
     发送网络请求
     */
    //completionHandle :说明网络请求完成
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        
        //网络请求成功
        if (data && !error) {
            
            //查看data是否是json数据
            
            //json解析
            id obj = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            
            //如果obj能够解析，说明就是json
            if (!obj) {
                obj = data;
            }
            
            //成功回调
            dispatch_async(dispatch_get_main_queue(), ^{
               
                if (success) {
                    success(obj, response);
                }
                
            });
        }else{
            //失败回调
            if (fail) {
                fail(error);
            }
        }
        
    }] resume];
    
}

#pragma mark -- POST
- (void)POSTRequestWithUrl:(NSString *)urlString paramaters:(NSDictionary *)paramaters successBlock:(SuccessBlcok)success FailBlock:(FailBlock)fail {
    
    /*
     创建请求
     */
    
    // 参数拼接.
    // 遍历参数字典,一一取出参数
    NSMutableString *strM = [[NSMutableString alloc] init];
    
    [paramaters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
       
        // 服务器接收参数的 key 值.
        NSString *paramaterKey = key;
        
        //参数内容
        NSString *paramaterValue = obj;
        
        // appendFormat :可变字符串直接拼接的方法!
        [strM appendFormat:@"%@=%@&",paramaterKey, paramaterValue];
    }];
    
    NSString *body = [strM substringToIndex:strM.length - 1];
    
    NSLog(@"body %@",body);
    
    NSData *bodyData = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15];
    
    //1.设置请求方法
    request.HTTPMethod = @"POST";
    
    //2.设置请求体
    request.HTTPBody = bodyData;
    
    /*
     发送网络请求
     */
    // completionHandler: 说明网络请求完成!
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        
        //网络请求成功
        if (data && !error) {
            
            //查看data是否是json数据
            
            //json解析
            id obj = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            
            //如果 obj 能够解析,说明就是 JSON
            if (!obj) {
                obj = data;
            }
            
            //成功回调
            dispatch_async(dispatch_get_main_queue(), ^{
               
                if (success) {
                    success(obj, response);
                }
                
            });
        }else{
            //失败回调
            if (fail) {
                fail(error);
            }
        }
    }] resume];
}

@end
