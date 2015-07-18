//
//  ViewController.m
//  iTag_iOS
//
// Created by WENG Lilion 15/7/14.
//  Copyright (c) 2015年 iTag_iOS_Group. All rights reserved.
//

#import "MainViewController.h"
#import "ProviderViewController.h"
#import "MainMenuViewController.h"

@implementation MainViewController
    UITextField *nameTextField;
    UITextField *pwdTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"bg1.png"] ];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)login
{
    NSString *url = @"http://147.8.138.16:8080/ios/";
    NSString *function = @"login";
    NSString *email = nameTextField.text;
    NSString *password = pwdTextField.text;
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
                     //NSString *userID = [result valueForKeyPath:@"UserID"];
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

- (IBAction)providerAction:(id)sender
{
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    NSString *subDescript = [NSString stringWithFormat:@"Please input your account."];
    
    nameTextField = [alert addTextField:@"Enter your name"];
    pwdTextField = [alert addTextField:@"Enter your password"];
    pwdTextField.secureTextEntry = YES;
    
    [alert addButton:@"Sign up" target:self selector:@selector(providerSignup)];
    
    //Hide animation type (Default is FadeOut)
    alert.hideAnimationType = SlideOutToTop;
    //Show animation type (Default is SlideInFromTop)
    alert.showAnimationType = SlideInFromBottom;
    //Set background type (Default is Shadow)
    alert.backgroundType = Blur;
    
    [alert showEdit:self title:@"Provider: Sign up!" subTitle:subDescript closeButtonTitle:@"Dismiss" duration:0.0f];

    [alert alertIsDismissed:^{
        NSLog(@"SCLAlertView dismissed!");
    }];
}
     
-(void)providerSignup
{    
    NSLog(@"alertView: Provider: Sign up");
    ProviderViewController *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProviderView"];//
    VC.email = nameTextField.text;
    VC.password = pwdTextField.text; // 传参    
    //[self.navigationController pushViewController:VC animated:YES];
    [self presentViewController:VC animated:YES completion:nil];
}

- (IBAction)workerAction:(id)sender {
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    NSString *subDescript = [NSString stringWithFormat:@"Please input your account."];
    
    nameTextField = [alert addTextField:@"Enter your name"];
    pwdTextField = [alert addTextField:@"Enter your password"];
    pwdTextField.secureTextEntry = YES;
    
    [alert addButton:@"Sign up" target:self selector:@selector(workerSignup)];
    
    //Hide animation type (Default is FadeOut)
    alert.hideAnimationType = SlideOutToTop;
    //Show animation type (Default is SlideInFromTop)
    alert.showAnimationType = SlideInFromBottom;
    //Set background type (Default is Shadow)
    alert.backgroundType = Blur;
    
    [alert showEdit:self title:@"Worker: Sign up!" subTitle:subDescript closeButtonTitle:@"Dismiss" duration:0.0f];
    
    [alert alertIsDismissed:^{
        NSLog(@"SCLAlertView dismissed!");
    }];
}
-(void)workerSignup
{
    NSLog(@"alertView: Worker: Sign up");

    MainMenuViewController *uploadVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WorkerView"];
     //uploadVC.PostID = @"value"; // 传参
     //uploadVC.UserID = @"value";
     [self presentViewController:uploadVC animated:YES completion:nil];
}

@end
