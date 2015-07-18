//
//  UIViewController+WalletBalance.m
//  myaccount
//
//  Created by WENG Lili on 12/7/15.
//  Copyright (c) 2015 WENG Lili. All rights reserved.
//

#import "pWalletBalance.h"

#import "providerMissionViewController.h"
#import "DOPNavbarMenu.h"
#import "CreateViewController.h"
#import "pAccountViewController.h"

@interface WalletBalance () <UITextViewDelegate, DOPNavbarMenuDelegate>

@property (assign, nonatomic) NSInteger numberOfItemsInRow;
@property (strong, nonatomic) DOPNavbarMenu *menu;

@end

@implementation WalletBalance
    NSString *test;

- (DOPNavbarMenu *)menu {
    if (_menu == nil) {
        DOPNavbarMenuItem *item1 = [DOPNavbarMenuItem ItemWithTitle:@"Create" icon:[UIImage imageNamed:@"Gestures@2x.png"]];
        DOPNavbarMenuItem *item2 = [DOPNavbarMenuItem ItemWithTitle:@"Mission" icon:[UIImage imageNamed:@"Players@2x.png"]];
        DOPNavbarMenuItem *item3 = [DOPNavbarMenuItem ItemWithTitle:@"Account" icon:[UIImage imageNamed:@"Box.jpg"]];
        _menu = [[DOPNavbarMenu alloc] initWithItems:@[item1,item2,item3] width:self.view.dop_width maximumNumberInRow:_numberOfItemsInRow];
        _menu.backgroundColor = [UIColor colorWithRed:158/255.0f green:103/255.0f blue:152/255.0f alpha:1.0f];
        _menu.separatarColor = [UIColor whiteColor];
        _menu.delegate = self;
    }
    return _menu;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self login];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(backButtonItemToDismiss)];
    self.numberOfItemsInRow = 3;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(openMenu:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithRed:96/255.0f green:46/255.0f blue:131/255.0f alpha:1.0f];
   // self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1.jpg"]];
    
    _money_label.textColor = [UIColor colorWithRed:(100/255.f) green:(150/255.f) blue:(60/255.f) alpha:1];
   
}
//
- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backButtonItemToDismiss{
    NSLog(@"Back");
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.menu) {
        [self.menu dismissWithAnimation:NO];
    }
}

- (void)openMenu:(id)sender {
    self.navigationItem.rightBarButtonItem.enabled = NO;
    if (self.menu.isOpen) {
        [self.menu dismissWithAnimation:YES];
    } else {
        [self.menu showInNavigationController:self.navigationController];
    }
}

- (void)didShowMenu:(DOPNavbarMenu *)menu {
    [self.navigationItem.rightBarButtonItem setTitle:@"Dismiss"];
    self.navigationItem.rightBarButtonItem.enabled = YES;
}

- (void)didDismissMenu:(DOPNavbarMenu *)menu {
    [self.navigationItem.rightBarButtonItem setTitle:@"Menu"];
    self.navigationItem.rightBarButtonItem.enabled = YES;
}

- (void)didSelectedMenu:(DOPNavbarMenu *)menu atIndex:(NSInteger)index {
    if (index == 1) {
        MissionViewController *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"MissionListView"];
        [self.navigationController pushViewController:VC animated:YES];
    }
    else if (index == 0) {
        CreateViewController *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateView"];
        [self.navigationController pushViewController:VC animated:YES];
    }
    else if (index == 2) {
        AccountViewController *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"AccountView"];
        [self.navigationController pushViewController:VC animated:YES];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)textViewDidChange:(UITextView *)textView {
    self.numberOfItemsInRow = [textView.text integerValue];
    self.menu = nil;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    self.menu = nil;
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
//登录的回调函数，首先判断接收的值是不是能登录。若不能，则提示用户。若能登录，则处理segue来跳转界面
- (void)login_callBack:(id)value{
    NSLog(@"Login Successed");
    _money_label.text = test;
}


@end
