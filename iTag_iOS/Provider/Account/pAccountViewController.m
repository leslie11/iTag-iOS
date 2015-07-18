//
//  TableViewController.m
//  myaccount
//
//  Created by WENG Lili on 27/5/15.
//  Copyright (c) 2015 WENG Lili. All rights reserved.
//

#import "pAccountViewController.h"
#import "providerMissionViewController.h"
#import "DOPNavbarMenu.h"
#import "CreateViewController.h"
#import "pWalletBalance.h"

@interface AccountViewController () <UITextViewDelegate, DOPNavbarMenuDelegate>

@property (assign, nonatomic) NSInteger numberOfItemsInRow;
@property (strong, nonatomic) DOPNavbarMenu *menu;

@end

@implementation AccountViewController

- (DOPNavbarMenu *)menu {
    if (_menu == nil) {
        DOPNavbarMenuItem *item1 = [DOPNavbarMenuItem ItemWithTitle:@"Create" icon:[UIImage imageNamed:@"Gestures@2x.png"]];
        DOPNavbarMenuItem *item2 = [DOPNavbarMenuItem ItemWithTitle:@"Mission" icon:[UIImage imageNamed:@"Players@2x.png"]];
        DOPNavbarMenuItem *item3 = [DOPNavbarMenuItem ItemWithTitle:@"Wallet" icon:[UIImage imageNamed:@"Box.jpg"]];
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
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Home" style:UIBarButtonItemStyleDone target:self action:@selector(backButtonItemToDismiss)];
    self.numberOfItemsInRow = 3;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(openMenu:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithRed:96/255.0f green:46/255.0f blue:131/255.0f alpha:1.0f];
  
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    /*_section1Items = [NSMutableArray array];
    _section2Items = [NSMutableArray array];
    
    [_section1Items addObject:@"Name"];
    [_section1Items addObject:@"ID"];
    [_section1Items addObject:@"Gender"];
    
    [_section2Items addObject:@"Wallet"];
    [_section2Items addObject:@"Level"];*/
 
}


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
    else if (index == 2) {
        WalletBalance *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"WalletView"];
        [self.navigationController pushViewController:VC animated:YES];
    }
    else if (index == 0) {
        CreateViewController *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateView"];
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
    NSString *function = @"account";
    NSString *userName = @"tony@gmail.com";
    //NSString *password =  @"1234";
    NSLog(@"Login Test");
    //加入参数
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:function forKey:@"function"];
    [params setValue:@"2" forKey:@"username"];
    [params setValue:userName forKey:@"email"];
    [params setValue:@"gender" forKey:@"gender"];
    [params setValue:@"level" forKey:@"level"];
    //有网络才发送请求
    if([HttpHelper NetWorkIsOK]){
        
        [HttpHelper post:url RequestParams:params FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {//传回来的数据存在，则执行改回调函数
            if(data){
                //子线程通知主线程更新UI，selector中是要执行的函数，data是传给这个函数的参数
                //login_callBack就处理返回来的消息，这里就简单的输出，登录成功
                NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"response = %@",str);
                
                NSError *error = nil;
                NSDictionary *jsonParsed = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                
                NSLog(@"response = %@",jsonParsed);
                
               
                _Email_Label.text = jsonParsed[@"email"];
                _Name_Label.text = jsonParsed[@"username"];
                _Gender_Label.text = jsonParsed[@"gender"];
                _Level_Label.text = [NSString stringWithFormat:@"%@%@", jsonParsed[@"level"], @"/100"];
                
                if (![jsonParsed[@"level"]  isEqual: @"None"]){
                   float intString = [jsonParsed[@"level"] floatValue];
                    _Level_Progress.progress = intString/100;
                    
                }
                
                NSString *url = jsonParsed[@"avatar"];
                
                NSString *avatar = [NSString stringWithFormat:@"%@%@", @"http://147.8.138.16:8080/static/data/", url];
                
                dispatch_async(dispatch_get_global_queue(0,0), ^{
                    NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: avatar]];
                    if ( data == nil )
                        return;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // WARNING: is the cell still using the same data by this point??
                        _Avatar.image = [UIImage imageWithData: data];
                    });
                });
                
                // save data to userDefaults
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setValue:jsonParsed[@"username"] forKey:@"userid"];
                [userDefaults setValue:jsonParsed[@"useid"] forKey:@"username"];
                [userDefaults synchronize];

                // read data from userDefaults
                userDefaults = [NSUserDefaults standardUserDefaults];
                NSString *userid = [userDefaults objectForKey:@"userid"];
                NSLog(userid);

                [self.tableView reloadData];
                
//                [self performSelectorOnMainThread:@selector(login_callBack:) withObject:data waitUntilDone:YES];
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
  }

@end
