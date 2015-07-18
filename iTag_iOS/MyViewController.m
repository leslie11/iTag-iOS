//
//  MyViewController.m
//  DropdownMenu-Example
//
//  Created by Nils Mattisson on 1/13/14.
//  Copyright (c) 2014 Nils Mattisson. All rights reserved.
//

#import "MyViewController.h"
#import "MyDropdownMenuController.h"
#import "MissionJSON.h"

NSString *test;

@interface MyViewController ()

@end

@implementation MyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self login];
	// Do any additional setup after loading the view.
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // Customize your menubar programmatically here.
    MyDropdownMenuController* menu = (MyDropdownMenuController *) [self parentViewController];
    [menu setMenubarTitle:self.titleLabel.text];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)login
{
    NSString *url = @"http://147.8.138.16:8080/ios/";
    NSString *function = @"balance";
    //NSString *userid = @"2";
    //NSString *password =  @"root";
    NSLog(@"Login Test");
    //加入参数
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:function forKey:@"function"];
    [params setValue:@"2" forKey:@"userid"];
    [params setValue:@"money" forKey:@"money"];
    //[params setValue:password forKey:@"pwd"];
    //有网络才发送请求
    if([HttpHelper NetWorkIsOK]){
        //发送请求，并且得到返回的数据
        [HttpHelper post:url RequestParams:params FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {//传回来的数据存在，则执行改回调函数
            if(data){
                //子线程通知主线程更新UI，selector中是要执行的函数，data是传给这个函数的参数
                //login_callBack就处理返回来的消息，这里就简单的输出，登录成功
                NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"response = %@",str);
                
                NSError *error = nil;
                
                //id resultString = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
                
                NSDictionary *jsonParsed = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                
                NSLog(@"response = %@",jsonParsed);
                test = jsonParsed[@"money"];
                
                //                _money_label.text = jsonParsed[@"money"];
                
                [self performSelectorOnMainThread:@selector(login_callBack:) withObject:data waitUntilDone:YES];
            }
            else{
                NSLog(@"Invalid Data");
            }
        }];
    }
}

- (void)login_callBack:(id)value{
    NSLog(@"Login Successed");
    _money_label.text = test;
}

@end
