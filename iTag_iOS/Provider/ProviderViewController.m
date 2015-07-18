//
//  ViewController.m
//  i-Tag_Provider
//
// Created by WENG Lilion 15/6/18.
// Copyright (c) 2015 WENG Lili. All rights reserved.
//

#import "ProviderViewController.h"

#import "MCFireworksButton.h"
#import "providerMissionViewController.h"
#import "CreateViewController.h"
#import "pWalletBalance.h"
#import "pAccountViewController.h"

@interface ProviderViewController ()

@property (weak, nonatomic) IBOutlet MCFireworksButton *createButton;
@property (weak, nonatomic) IBOutlet MCFireworksButton *missionButton;
@property (weak, nonatomic) IBOutlet MCFireworksButton *walletButton;
@property (weak, nonatomic) IBOutlet MCFireworksButton *accountButton;

@end

@implementation ProviderViewController {
    BOOL _selected;
}
- (IBAction)createButtonPress:(id)sender {
    _selected = !_selected;
    if (_selected){
        [self.createButton popOutsideWithDuration:0.5];
        [self.createButton animate];
    }
    else {
        [self.createButton popInsideWithDuration:0.4];
    }
}
- (IBAction)missionButtonPress:(id)sender {
    _selected = !_selected;
    if (_selected){
        [self.missionButton popOutsideWithDuration:0.8];
        [self.missionButton animate];
    }
    else {
        [self.missionButton popInsideWithDuration:0.3];
    }
    
}
- (IBAction)walletButtonPress:(id)sender {
    _selected = !_selected;
    if (_selected){
        [self.walletButton popOutsideWithDuration:0.8];
        [self.walletButton animate];
    }
    else {
        [self.walletButton popInsideWithDuration:0.3];
    }
}

- (IBAction)accountButtonPress:(id)sender {
    _selected = !_selected;
    if (_selected){
        [self.accountButton popOutsideWithDuration:0.5];
        [self.accountButton animate];
    }
    else {
        [self.accountButton popInsideWithDuration:0.4];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"email: %@",_email);
    NSLog(@"pwd: %@",_password);
    [self login];
    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"bg1.png"] ];
    self.createButton.particleScale = 0.05;
    self.createButton.particleScaleRange = 0.02;
    self.missionButton.particleScale = 0.05;
    self.missionButton.particleScaleRange = 0.02;
    self.walletButton.particleScale = 0.05;
    self.walletButton.particleScaleRange = 0.02;
    self.accountButton.particleScale = 0.05;
    self.accountButton.particleScaleRange = 0.02;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)login
{
    NSString *url = @"http://147.8.138.16:8080/ios/";
    NSString *function = @"login";
    NSString *email = _email;
    NSString *password = _password;
    NSLog(@"Login");
    //加入参数
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:function forKey:@"function"];
    [params setValue:email forKey:@"email"];
    [params setValue:password forKey:@"pwd"];
    //有网络才发送请求
    if([HttpHelper NetWorkIsOK]){ //
        //发送请求，并且得到返回的数据
        [HttpHelper post:url RequestParams:params FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {//传回来的数据存在，则执行改回调函数
            if(data){
                //子线程通知主线程更新UI，selector中是要执行的函数，data是传给这个函数的参数
                //login_callBack就处理返回来的消息，这里就简单的输出，登录成功
                NSError *error;
                //将对象序列化为字典
                NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                NSLog(@"response = %@",result);
                if ([[result valueForKeyPath:@"Status"]  isEqual: @"Success"]) {
                   _UserID = [result valueForKeyPath:@"UserID"];
                }
                [self performSelectorOnMainThread:@selector(login_callBack:) withObject:data waitUntilDone:YES];
            }
            else{
                NSLog(@"Invalid Data: Login");
            }
        }];
    }
}
//登录的回调函数，首先判断接收的值是不是能登录。若不能，则提示用户。若能登录，则处理segue来跳转界面
- (void)login_callBack:(id)value{
    NSLog(@"Login Successed");
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id) sender
{
    NSLog(@"prepare segue");
    if ([[segue identifier] isEqualToString:@"CreateSegue"]) {
        CreateViewController *vc = (CreateViewController *)[[segue destinationViewController] topViewController];
        vc.userID = _UserID;
    }
    if ([[segue identifier] isEqualToString:@"MissionSegue"]) {
        MissionViewController *vc = (MissionViewController *)[[segue destinationViewController] topViewController];
        vc.userID = _UserID;
    }
    if ([[segue identifier] isEqualToString:@"WalletSegue"]) {
        WalletBalance *vc = (WalletBalance *)[[segue destinationViewController] topViewController];
        vc.userID = _UserID;
    }
    if ([[segue identifier] isEqualToString:@"AccountSegue"]) {
        AccountViewController *vc = (AccountViewController *)[[segue destinationViewController] topViewController];
        vc.userID = _UserID;
    }
}

@end

