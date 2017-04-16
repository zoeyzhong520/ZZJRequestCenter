//
//  ZZJRequestCenter.h
//  NSURLSession
//
//  Created by 仲召俊 on 2017/4/10.
//  Copyright © 2017年 ZZJ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessBlcok)(id object, NSURLResponse *response);//成功后返回的闭包

typedef void(^FailBlock)(NSError *error);//失败后返回的闭包

@interface ZZJRequestCenter : NSObject

/*
 单例对象创建方法
 */
+ (instancetype)sharedNetWorkTool;

/*
 GET方法
 */
- (void)GETRequestWithUrl:(NSString *)urlString paramaters:(NSDictionary *)paramaters successBlock:(SuccessBlcok)success FailBlock:(FailBlock)fail;

/*
 POST方法
 */
- (void)POSTRequestWithUrl:(NSString *)urlString paramaters:(NSDictionary *)paramaters successBlock:(SuccessBlcok)success FailBlock:(FailBlock)fail;

@end
