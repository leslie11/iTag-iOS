//
//  UIViewController+CreateViewController.m
//  i-Tag_Provider
//
// Created by WENG Lili on 15/7/10
//

#import "CreateViewController.h"
#import "DOPNavbarMenu.h"

#import "providerMissionViewController.h"
#import "pWalletBalance.h"
#import "pAccountViewController.h"

@interface CreateViewController() <UITextViewDelegate, DOPNavbarMenuDelegate>

@property (assign, nonatomic) NSInteger numberOfItemsInRow;
@property (strong, nonatomic) DOPNavbarMenu *menu;
@property (nonatomic, strong) NSDate *selectedDate;


@end

@implementation CreateViewController
    int days;

- (DOPNavbarMenu *)menu {
    if (_menu == nil) {
        DOPNavbarMenuItem *item1 = [DOPNavbarMenuItem ItemWithTitle:@"Mission" icon:[UIImage imageNamed:@"Gestures@2x.png"]];
        DOPNavbarMenuItem *item2 = [DOPNavbarMenuItem ItemWithTitle:@"Wallet" icon:[UIImage imageNamed:@"Players@2x.png"]];
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
    // Do any additional setup after loading the view
    NSLog(@"userID: %@",_userID);
    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"bg1.png"] ];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(backButtonItemToDismiss)];
    self.numberOfItemsInRow = 3;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(openMenu:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithRed:96/255.0f green:46/255.0f blue:131/255.0f alpha:1.0f];
    
    _nameText.font = [UIFont flatFontOfSize:18];
    _nameText.edgeInsets = UIEdgeInsetsMake(4.0f, 15.0f, 4.0f, 15.0f);
    _nameText.textFieldColor = [UIColor whiteColor];
    _nameText.borderColor = [UIColor turquoiseColor];
    _nameText.borderWidth = 2.0f;
    _nameText.cornerRadius = 3.0f;
    
    _budgetText.font = [UIFont flatFontOfSize:18];
    //_budgetText.backgroundColor = [UIColor clearColor];
    _budgetText.edgeInsets = UIEdgeInsetsMake(4.0f, 15.0f, 4.0f, 15.0f);
    _budgetText.textFieldColor = [UIColor whiteColor];
    _budgetText.borderColor = [UIColor turquoiseColor];
    _budgetText.borderWidth = 2.0f;
    _budgetText.cornerRadius = 3.0f;
    
    _descriptText.font = [UIFont flatFontOfSize:16];
    //_descriptText.backgroundColor = [UIColor clearColor];
    _descriptText.layer.borderColor = (__bridge CGColorRef)([UIColor turquoiseColor]);
    _descriptText.layer.borderWidth = 2.0f;//该属性显示外边框
    _descriptText.layer.cornerRadius = 3.0f;//通过该值来设置textView边角的弧度
    _descriptText.layer.masksToBounds = YES;
    _descriptText.clearsOnInsertion = YES;
    _descriptText.placeholder = @"Input your description here.";

    _workerLevel.maximumValue = 25.0;
    _workerLevel.popUpViewCornerRadius = 12.0;
    [_workerLevel setMaxFractionDigitsDisplayed:0];
    _workerLevel.popUpViewColor = [UIColor colorWithHue:0.55 saturation:0.8 brightness:0.9 alpha:0.7];
    _workerLevel.font = [UIFont fontWithName:@"GillSans-Bold" size:20];
    _workerLevel.textColor = [UIColor colorWithHue:0.55 saturation:1.0 brightness:0.5 alpha:1];
    
    _FinishButton.buttonColor = [UIColor alizarinColor];
    _FinishButton.shadowColor = [UIColor pomegranateColor];
    _FinishButton.shadowHeight = 3.0f;
    _FinishButton.cornerRadius = 6.0f;
    _FinishButton.titleLabel.font = [UIFont boldFlatFontOfSize:20];
    [_FinishButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [_FinishButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    
    _CancelButton.buttonColor = [UIColor turquoiseColor];
    _CancelButton.shadowColor = [UIColor greenSeaColor];
    _CancelButton.shadowHeight = 3.0f;
    _CancelButton.cornerRadius = 6.0f;
    _CancelButton.titleLabel.font = [UIFont boldFlatFontOfSize:20];
    [_CancelButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [_CancelButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
}

- (void)backButtonItemToDismiss{
    NSLog(@"Cancel");
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //隐藏键盘
    [_descriptText resignFirstResponder];
}

- (IBAction)showDatePicker:(id)sender {
    HSDatePickerViewController *hsdpvc = [HSDatePickerViewController new];
    hsdpvc.delegate = self;
    if (self.selectedDate) {
        hsdpvc.date = self.selectedDate;
    }
    [self presentViewController:hsdpvc animated:YES completion:nil];
}

#pragma mark - HSDatePickerViewControllerDelegate
- (void)hsDatePickerPickedDate:(NSDate *)date {
    NSLog(@"Date picked %@", date);
    NSDateFormatter *dateFormater = [NSDateFormatter new];
    dateFormater.dateFormat = @" yyyy-MM-dd";
    self.dateLabel.text = [dateFormater stringFromDate:date];
    
    self.selectedDate = date;
    int timeOffset = [date timeIntervalSinceDate:[NSDate date]];
    // 这个是得出两个日期间相差的秒数.注意时区的问题.

    days = timeOffset/3600/24;
}

- (IBAction)FinishAction:(id)sender {
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    NSString *subDescript = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%f",_nameText.text, _budgetText.text, _dateLabel.text, _descriptText.text, _workerLevel.value];
    
    [alert addButton:@"Create it!" target:self selector:@selector(alertCreateMission)];

    //Hide animation type (Default is FadeOut)
    alert.hideAnimationType = SlideOutToTop;
    
    //Show animation type (Default is SlideInFromTop)
    alert.showAnimationType = SlideInFromBottom;
    
    //Set background type (Default is Shadow)
    alert.backgroundType = Blur;

    [alert showSuccess:self title:@"Check: Create Mission" subTitle:subDescript closeButtonTitle:@"Dismiss" duration:0.0f];
    
    [alert alertIsDismissed:^{
    NSLog(@"SCLAlertView dismissed!");
}];
}
- (void)alertCreateMission
{
    NSLog(@"alertView: Create Mission");
    [self createMission];
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    //Hide animation type (Default is FadeOut)
    alert.hideAnimationType = SlideOutToTop;
    //Show animation type (Default is SlideInFromTop)
    alert.showAnimationType = SlideInFromBottom;
    //Set background type (Default is Shadow)
    alert.backgroundType = Blur;
    [alert showSuccess:self title:@"Success!" subTitle:@"Create Mission Success!" closeButtonTitle:nil duration:1.5f];
    
    [alert alertIsDismissed:^{
        NSLog(@"SCLAlertView dismissed!");
        UploadViewController *uploadVC = [self.storyboard instantiateViewControllerWithIdentifier:@"UploadView"];
        uploadVC.PostID = _PostID; // 传参
        uploadVC.UserID = _userID;
        [self.navigationController pushViewController:uploadVC animated:YES];
    }];
}


- (IBAction)CancelAction:(id)sender {
    [self backButtonItemToDismiss];
}

- (void)createMission
{
    NSString *url = @"http://147.8.138.16:8080/ios/";
    NSString *function = @"createMission";
    NSString *userID = _userID;
    NSString *MissionName = _nameText.text;
    NSString *Budget = _budgetText.text;
    NSString *Deadline = [NSString stringWithFormat:@"%d",days];
    NSString *Description = _descriptText.text;
    NSString *workerlvl = [NSString stringWithFormat:@"%f", _workerLevel.value];
    //加入参数
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:function forKey:@"function"];
    [params setValue:userID forKey:@"userid"];
    [params setValue:MissionName forKey:@"missionname"];
    [params setValue:Budget forKey:@"budget"];
    [params setValue:Deadline forKey:@"deadline"];
    [params setValue:Description forKey:@"description"];
    [params setValue:workerlvl forKey:@"workerlvl"];

    //有网络才发送请求
    if([HttpHelper NetWorkIsOK]){ //
        //发送请求，并且得到返回的数据
        [HttpHelper post:url RequestParams:params FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {//传回来的数据存在，则执行改回调函数
            if(data){
                //子线程通知主线程更新UI，selector中是要执行的函数，data是传给这个函数的参数
                //login_callBack就处理返回来的消息，这里就简单的输出，登录成功
                NSError *error = nil;
                NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                NSLog(@"response = %@",result);
                _PostID = [result valueForKeyPath:@"PostID"];
                [self performSelectorOnMainThread:@selector(login_callBack:) withObject:data waitUntilDone:YES];
            }
            else{
                NSLog(@"Invalid Data: create Mission");
            }
        }];
    }
}
//登录的回调函数，首先判断接收的值是不是能登录。若不能，则提示用户。若能登录，则处理segue来跳转界面
- (void)login_callBack:(id)value{
    NSLog(@"Create Mission Successed");
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
    if (index == 0) {
        MissionViewController *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"MissionListView"];
        [self.navigationController pushViewController:VC animated:YES];
    }
    else if (index == 1) {
        WalletBalance *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"WalletView"];
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

@end


