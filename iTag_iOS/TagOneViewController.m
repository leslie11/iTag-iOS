//
//  TagOneViewController.m
//  itagWorker
//
//  Created by Leslie-AIR on 15/7/12.

//

#import "TagOneViewController.h"
#import "ImageJSON.h"
int counter1 = 0;
NSString *urlPrefix = @"http://147.8.138.16:8080";
NSString *q1;
NSString *q2;
NSString *q3;
NSString *q4;
NSString *submitedTag;

@interface TagOneViewController ()

@end

@implementation TagOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPage];
    self.doneLabel.hidden = YES;
    counter1 = 0;
    [_textField setBackgroundColor:[UIColor clearColor]];
    _textField.layer.cornerRadius=1.0f;
    _textField.layer.masksToBounds=YES;
    _textField.layer.borderColor=[[UIColor whiteColor]CGColor];
    _textField.layer.borderWidth= 1.0f;
    _submitButton.layer.backgroundColor = [[UIColor clearColor] CGColor];
    _submitButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    _submitButton.layer.cornerRadius = 0.0f;
    _submitButton.layer.borderWidth = 1.0f;
    // Do any additional setup after loading the view.
    self.ImageBorder.layer.borderColor = [UIColor whiteColor].CGColor;
    self.ImageBorder.layer.borderWidth = 1.0;
    self.counter.layer.cornerRadius = 37.5;
    _counter.layer.backgroundColor = [[UIColor clearColor] CGColor];
    _counter.layer.borderColor = [[UIColor whiteColor] CGColor];
    _counter.layer.borderWidth = 1.0f;
    [self fetchPicture];
    //[NSThread sleepForTimeInterval:0.3f];
    self.counter.text = [NSString stringWithFormat:@"%d",counter1];
    
    NSLog(@"transfered = %@",_transfered);
}

- (void)fetchPicture
{
    NSString *url = @"http://147.8.138.16:8080/ios/";
    NSString *function = @"fetchPicture";
    NSString *userName = @"admin";
    NSString *password =  @"root";
    NSString *uid =  @"3";
    NSString *rid =  @"1";
    NSString *pid =  _transfered;
    NSString *ptype = _transferedPosttype;
    NSLog(@"fetchPicture Test");
    //加入参数
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:function forKey:@"function"];
    [params setValue:userName forKey:@"email"];
    [params setValue:password forKey:@"pwd"];
    [params setValue:uid forKey:@"uid"];
    [params setValue:rid forKey:@"rid"];
    [params setValue:pid forKey:@"pid"];
    [params setValue:ptype forKey:@"ptype"];
    //有网络才发送请求
    if([HttpHelper NetWorkIsOK]){
        //发送请求，并且得到返回的数据
        [HttpHelper post:url RequestParams:params FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {//传回来的数据存在，则执行改回调函数
            if(data){
                //子线程通知主线程更新UI，selector中是要执行的函数，data是传给这个函数的参数
                //login_callBack就处理返回来的消息，这里就简单的输出，登录成功
                NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//                NSLog(@"response = %@",str);
                NSError *error = nil;
                
                ImageJSON *mission = [[ImageJSON alloc] initWithString:str error:&error];
                NSString *test = mission.url1;
                _urlArray = [NSArray arrayWithObjects: [NSString stringWithFormat:@"%@/%@", urlPrefix, mission.url1], [NSString stringWithFormat:@"%@/%@", urlPrefix, mission.url2], [NSString stringWithFormat:@"%@/%@", urlPrefix, mission.url3], [NSString stringWithFormat:@"%@/%@", urlPrefix, mission.url4], [NSString stringWithFormat:@"%@/%@", urlPrefix, mission.url5], [NSString stringWithFormat:@"%@/%@", urlPrefix, mission.url6], [NSString stringWithFormat:@"%@/%@", urlPrefix, mission.url7], [NSString stringWithFormat:@"%@/%@", urlPrefix, mission.url8], [NSString stringWithFormat:@"%@/%@", urlPrefix, mission.url9], [NSString stringWithFormat:@"%@/%@", urlPrefix, mission.url10],nil];
                _ridArray = [NSArray arrayWithObjects:mission.rid1, mission.rid2,mission.rid3,mission.rid4,mission.rid5,mission.rid6,mission.rid7,mission.rid8,mission.rid9,mission.rid10,nil];
                _urltest = [NSString stringWithFormat:@"%@/%@", urlPrefix, test];
                q1 = mission.q1;
                q2 = mission.q2;
                q3 = mission.q3;
                q4 = mission.q4;
                
                NSLog(@"%@",q1);
//                NSURL *imageUrl = [NSURL URLWithString:_urltest];
//                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
//                self.image.image = image;
                [self performSelectorOnMainThread:@selector(login_callBack:) withObject:data waitUntilDone:YES];
            }
            else{
                NSLog(@"Invalid");
            }
        }];
    }
}

- (void)submitTag
{
    NSString *url = @"http://147.8.138.16:8080/ios/";
    NSString *function = @"submitTag";
    NSString *userName = @"admin";
    NSString *password =  @"root";
    NSString *uid =  @"3";
    NSString *tag = submitedTag;
    NSString *rid =  _ridArray[counter1];
    NSLog(@"submitTag Test");
    //加入参数
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:function forKey:@"function"];
    [params setValue:userName forKey:@"email"];
    [params setValue:password forKey:@"pwd"];
    [params setValue:uid forKey:@"uid"];
    [params setValue:tag forKey:@"tag"];
    [params setValue:rid forKey:@"rid"];
    //有网络才发送请求
    if([HttpHelper NetWorkIsOK]){
        //发送请求，并且得到返回的数据
        [HttpHelper post:url RequestParams:params FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {//传回来的数据存在，则执行改回调函数
            if(data){
                //子线程通知主线程更新UI，selector中是要执行的函数，data是传给这个函数的参数
                //login_callBack就处理返回来的消息，这里就简单的输出，登录成功
                //NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                //NSLog(@"response = %@",str);
                [self performSelectorOnMainThread:@selector(login_callBack1:) withObject:data waitUntilDone:YES];
            }
            else{
                NSLog(@"Invalid");
            }
        }];
    }
}

- (IBAction)test:(id)sender {
    [self fetchPicture];
}

- (void)login_callBack:(id)value{
    
    NSURL *imageUrl = [NSURL URLWithString:_urlArray[0]];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
    self.image.image = image;
    if ([_transferedPosttype isEqualToString:@"P1"]) {
        [self.tag1 setTitle:q1 forState:UIControlStateNormal];
        [self.tag2 setTitle:q2 forState:UIControlStateNormal];
        [self.tag3 setTitle:q3 forState:UIControlStateNormal];
        [self.tag4 setTitle:q4 forState:UIControlStateNormal];
    }
    if ([_transferedPosttype isEqualToString:@"P2"]) {
        self.questionForP2.text = q1;
    }
    //NSLog(@"%d",postid1);
}
- (void)login_callBack1:(id)value{
    
//    self.tag1.titleLabel.text = q1;
//    
//    self.tag2.titleLabel.text = q2;
//    self.tag3.titleLabel.text = q3;
//    self.tag4.titleLabel.text = q4;
//    self.tag1.enabled = FALSE;
//    [self.tag1 setTitle:q1 forState:UIControlStateNormal];
//    self.tag1.enabled = TRUE;
    NSLog(@"success");
    //NSLog(@"%@",_ridArray[counter1]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)submit:(id)sender {
    submitedTag = self.textField.text;
    [self submitTag];
    counter1 = counter1 + 1;
    if (counter1 < 10) {
        
    
    self.counter.text = [NSString stringWithFormat:@"%d",counter1];
    NSURL *imageUrl = [NSURL URLWithString:_urlArray[counter1]];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
        self.image.image = image;}
    
    if (counter1 == 10) {
        self.doneLabel.hidden = NO;
    }
    
}

- (void)initPage {

    self.textField.hidden = YES;
    self.submitButton.hidden = YES;
    self.ImageBorder.hidden = YES;
    self.tag1.layer.backgroundColor = [[UIColor clearColor] CGColor];
    self.tag1.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.tag1.layer.cornerRadius = 0.0f;
    self.tag1.layer.borderWidth = 1.0f;
    self.tag2.layer.backgroundColor = [[UIColor clearColor] CGColor];
    self.tag2.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.tag2.layer.cornerRadius = 0.0f;
    self.tag2.layer.borderWidth = 1.0f;
    self.tag3.layer.backgroundColor = [[UIColor clearColor] CGColor];
    self.tag3.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.tag3.layer.cornerRadius = 0.0f;
    self.tag3.layer.borderWidth = 1.0f;
    self.tag4.layer.backgroundColor = [[UIColor clearColor] CGColor];
    self.tag4.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.tag4.layer.cornerRadius = 0.0f;
    self.tag4.layer.borderWidth = 1.0f;
    self.tag1.hidden = YES;
    self.tag2.hidden = YES;
    self.tag3.hidden = YES;
    self.tag4.hidden = YES;
    self.backForP1.hidden = YES;
    self.backForP2.hidden = YES;
    self.backForP4.hidden = YES;
    self.textFieldForP2.hidden = YES;
    self.questionForP2.hidden = YES;
    self.submitForP2.hidden = YES;
    _submitForP2.layer.backgroundColor = [[UIColor clearColor] CGColor];
    _submitForP2.layer.borderColor = [[UIColor whiteColor] CGColor];
    _submitForP2.layer.cornerRadius = 0.0f;
    _submitForP2.layer.borderWidth = 1.0f;
    if ([_transferedPosttype isEqualToString:@"P1"]) {
        self.tag1.hidden = NO;
        self.tag2.hidden = NO;
        self.tag3.hidden = NO;
        self.tag4.hidden = NO;
        self.backForP1.hidden = NO;
    }
    if ([_transferedPosttype isEqualToString:@"P4"]) {
        self.submitButton.hidden = NO;
        self.textField.hidden = NO;
        self.backForP4.hidden = NO;
    }
    if ([_transferedPosttype isEqualToString:@"P2"]) {
        self.questionForP2.hidden = NO;
        self.textFieldForP2.hidden = NO;
        self.backForP2.hidden = NO;
        self.submitForP2.hidden = NO;
    }
}
- (IBAction)tag1ForP1:(id)sender {
    
    submitedTag = q1;
    [self submitTag];
    counter1 = counter1 + 1;
    if (counter1 < 10) {
        
        
        self.counter.text = [NSString stringWithFormat:@"%d",counter1];
        NSURL *imageUrl = [NSURL URLWithString:_urlArray[counter1]];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
        self.image.image = image;}
    
    if (counter1 == 10) {
        self.doneLabel.hidden = NO;
    }
    
}
- (IBAction)tag2ForP1:(id)sender {
    submitedTag = q2;
    [self submitTag];
    counter1 = counter1 + 1;
    if (counter1 < 10) {
        
        
        self.counter.text = [NSString stringWithFormat:@"%d",counter1];
        NSURL *imageUrl = [NSURL URLWithString:_urlArray[counter1]];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
        self.image.image = image;}
    
    if (counter1 == 10) {
        self.doneLabel.hidden = NO;
    }
}
- (IBAction)tag3ForP1:(id)sender {
    submitedTag = q3;
    [self submitTag];
    counter1 = counter1 + 1;
    if (counter1 < 10) {
        
        
        self.counter.text = [NSString stringWithFormat:@"%d",counter1];
        NSURL *imageUrl = [NSURL URLWithString:_urlArray[counter1]];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
        self.image.image = image;}
    
    if (counter1 == 10) {
        self.doneLabel.hidden = NO;
    }
}
- (IBAction)tag4ForP1:(id)sender {
    submitedTag = q4;
    [self submitTag];
    counter1 = counter1 + 1;
    if (counter1 < 10) {
        
        
        self.counter.text = [NSString stringWithFormat:@"%d",counter1];
        NSURL *imageUrl = [NSURL URLWithString:_urlArray[counter1]];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
        self.image.image = image;}
    
    if (counter1 == 10) {
        self.doneLabel.hidden = NO;
    }
}
- (IBAction)submitForP2:(id)sender {
    
    submitedTag = self.textFieldForP2.text;
    [self submitTag];
    counter1 = counter1 + 1;
    if (counter1 < 10) {
        
        
        self.counter.text = [NSString stringWithFormat:@"%d",counter1];
        NSURL *imageUrl = [NSURL URLWithString:_urlArray[counter1]];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
        self.image.image = image;}
    
    if (counter1 == 10) {
        self.doneLabel.hidden = NO;
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //隐藏键盘
    [_textField resignFirstResponder];
    [_textFieldForP2 resignFirstResponder];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
