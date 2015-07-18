//
//  WorkerMissionViewController.m
//  itagWorker
//
//  Created by Leslie-AIR on 15/7/12.

//

#import "WorkerMissionViewController.h"
#import "MissionJSON.h"


@interface WorkerMissionViewController ()

@end

@implementation WorkerMissionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self testNew];
//    //self.Title.text = @"123";
//    [NSThread sleepForTimeInterval:0.5f];
//    NSLog(@"%@",test);
//    self.Title.text = test;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"darkblue.jpeg"]];
//    self.border.layer.borderColor = [UIColor whiteColor].CGColor;
//    self.border.layer.borderWidth = 1.0;
//    self.border2.layer.borderColor = [UIColor whiteColor].CGColor;
//    self.border2.layer.borderWidth = 1.0;
//    self.border3.layer.borderColor = [UIColor whiteColor].CGColor;
//    self.border3.layer.borderWidth = 1.0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)testNew
{
    NSString *url = @"http://147.8.138.16:8080/ios/";
    NSString *function = @"workerViewMission";
    NSString *userName = @"admin";
    NSString *password =  @"root";
    NSString *uid =  @"3";
    NSLog(@"workerViewMission Test");
    //加入参数
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:function forKey:@"function"];
    [params setValue:userName forKey:@"email"];
    [params setValue:password forKey:@"pwd"];
    [params setValue:uid forKey:@"uid"];
    //有网络才发送请求
    if([HttpHelper NetWorkIsOK]){
        //发送请求，并且得到返回的数据
        [HttpHelper post:url RequestParams:params FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {//传回来的数据存在，则执行改回调函数
            if(data){
                //子线程通知主线程更新UI，selector中是要执行的函数，data是传给这个函数的参数
                //login_callBack就处理返回来的消息，这里就简单的输出，登录成功
                //NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                //NSError *error = nil;
                //MissionJSON *mission = [[MissionJSON alloc] initWithString:str error:&error];
                //NSLog(@"response = %@",mission.title);
                //self.Title = [[UILabel alloc] init];
                //test = mission.title;
                
                NSLog(@"set complete");
                
                //[self performSelectorOnMainThread:@selector(login_callBack:) withObject:data waitUntilDone:YES];
            }
            else{
                NSLog(@"Invalid");
            }
        }];
    }
}
- (void)login_callBack:(id)value{
    NSLog(@"Success");
}

@end
