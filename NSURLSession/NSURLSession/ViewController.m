//
//  ViewController.m
//  NSURLSession
//
//  Created by 仲召俊 on 2017/4/10.
//  Copyright © 2017年 ZZJ. All rights reserved.
//

#import "ViewController.h"
#import "ZZJRequestCenter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self getDataWithURL];
    [self postDataWithUrl];
}

- (void)getDataWithURL {
    
    NSString *urlString = @"http://120.26.170.196/read_api/index.php?s=Home/Index/getBooks&sid=986";
    
    //创建参数字典
    NSMutableDictionary *paramaters = [NSMutableDictionary dictionary];
    
    //发送GET请求
    [[ZZJRequestCenter sharedNetWorkTool] GETRequestWithUrl:urlString paramaters:paramaters successBlock:^(id object, NSURLResponse *response) {
        
        NSLog(@"网络请求成功：%@",object);
        
    } FailBlock:^(NSError *error) {
        
        NSLog(@"网络请求失败：%@",error);
        
    }];
    
}

- (void)postDataWithUrl {
    
    //创建参数字典
    NSMutableDictionary *paramaters = @{@"username":@"joe",@"password":@"1234"}.mutableCopy;
    
    //发送POST请求
    //[ZZJRequestCenter sharedNetWorkTool] POSTRequestWithUrl:<#(NSString *)#> paramaters:<#(NSDictionary *)#> successBlock:<#^(id object, NSURLResponse *response)success#> FailBlock:<#^(NSError *error)fail#>
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
