//
//  UIViewController+P1ViewController.m
//  i-Tag_Provider
//
// Created by WENG Lilion 15/7/15.
// Copyright (c) 2015 WENG Lili. All rights reserved.
//

#import "P4ViewController.h"

@implementation P4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"bg1.png"] ];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(backButtonItemToDismiss)];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(updatePostType)];
    
    NSLog(@"PostID: %@",_PostID);
    //NSLog(@"UserID: %@",_UserID);
    _P4TextView.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backButtonItemToDismiss{
    NSLog(@"Cancel");
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)updatePostType
{
    NSString *url = @"http://147.8.138.16:8080/ios/";
    NSString *function = @"updatePostType";
    //NSString *PostID = @"9";
    NSLog(@"update PostType");
    //加入参数
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:function forKey:@"function"];
    [params setValue:_PostID forKey:@"PostID"];
    [params setValue:@"P4" forKey:@"PostType"];
    
    //有网络才发送请求
    if([HttpHelper NetWorkIsOK]){ //
        //发送请求，并且得到返回的数据
        [HttpHelper post:url RequestParams:params FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {//传回来的数据存在，则执行改回调函数
            if(data){
                //子线程通知主线程更新UI，selector中是要执行的函数，data是传给这个函数的参数
                //login_callBack就处理返回来的消息
                [self performSelectorOnMainThread:@selector(login_callBack:) withObject:data waitUntilDone:YES];
            }
            else{
                NSLog(@"Invalid Data: update PostType");
            }
        }];
    }
}
//登录的回调函数，首先判断接收的值是不是能登录。若不能，则提示用户。若能登录，则处理segue来跳转界面
- (void)login_callBack:(id)value
{
    NSError *error;
    //将对象序列化为字典
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:value options:0 error:&error];
    NSLog(@"response = %@",dic);
    if ([[dic valueForKeyPath:@"Status"]  isEqual: @"Success"]) {
        SCLAlertView *alert = [[SCLAlertView alloc] init];
        [alert addButton:@"OK" target:self selector:@selector(DoneToDismiss)];
        [alert showNotice:self title:@"Success: PostType" subTitle:@"Congratulations! You have finished your mission creation!" closeButtonTitle:nil duration:0.0f]; // Notice
    }
    NSLog(@"update PostType Successed");
}

- (void)DoneToDismiss{
    NSLog(@"Done and dismiss.");
    ProviderViewController *providerVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProviderView"];
    providerVC.UserID = _UserID;
    [self presentViewController:providerVC animated:YES completion:nil];
}

@end
