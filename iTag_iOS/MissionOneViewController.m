//
//  MissionOneViewController.m
//  itagWorker
//
//  Created by Leslie-AIR on 15/7/10.

//

#import "MissionOneViewController.h"
#import "MissionJSON.h"
#import "TagOneViewController.h"
#import "FavorViewController.h"

NSString *missionOneTitle;
NSString *missionOneUid;
NSString *missionTwoTitle;
NSString *missionTwoUid;
NSString *missionThreeTitle;
NSString *missionThreeUid;
NSString *missionOneType;
NSString *missionTwoType;
NSString *missionThreeType;
NSString *postid1;
NSString *postid2;
NSString *postid3;
NSString *transfer;
NSString *budget1;
NSString *budget2;
NSString *budget3;
NSString *cover1;
NSString *cover2;
NSString *cover3;
NSString *workerlvl1;
NSString *workerlvl2;
NSString *workerlvl3;
NSString *flag1 = @"NO";
NSString *flag2 = @"NO";
NSString *flag3 = @"NO";

NSString *urlPrefix1 = @"http://147.8.138.16:8080";

@interface MissionOneViewController ()

@end

@implementation MissionOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    // Do any additional setup after loading the view.
    [self testNew];
    NSLog(@"viewdidload");
    //[self testNew2];
//    [NSThread sleepForTimeInterval:0.3f];
//    self.Title.text = missionOneTitle;
//    self.Provider.text = missionOneUid;
//    self.Description.text = missionOneDescription;
//    self.missionTwoTitle.text = missionTwoTitle;
//    self.missionTwoProvider.text = missionTwoUid;
//    self.MissionTwoDescription.text = missionTwoDescription;
//    [self init1];

    //NSLog(@"%@",missionTwoUid);
    
    
    
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
                NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                NSError *error = nil;
                MissionJSON *mission = [[MissionJSON alloc] initWithString:str error:&error];
                NSLog(@"response = %@",mission.title1);
                //self.Title = [[UILabel alloc] init];
                //_Title.text = mission.title;
                missionOneTitle = mission.title1;
                missionOneUid = mission.uid1;
//                missionOneDescription = mission.description;
                missionTwoTitle = mission.title2;
                missionTwoUid = mission.uid2;
//                missionTwoDescription = mission.description2;
                missionThreeTitle = mission.title3;
                missionThreeUid = mission.uid3;
//                missionThreeDescription = mission.description3;
                missionOneType = mission.type1;
                missionTwoType = mission.type2;
                missionThreeType = mission.type3;
                postid1 = mission.postid1;
                postid2 = mission.postid2;
                postid3 = mission.postid3;
                budget1 = mission.budget1;
                budget2 = mission.budget2;
                budget3 = mission.budget3;
                cover1 = mission.cover1;
                cover2 = mission.cover2;
                cover3 = mission.cover3;
                workerlvl1 = mission.workerlvl1;
                workerlvl2 = mission.workerlvl2;
                workerlvl3 = mission.workerlvl3;
                NSLog(@"set complete");
            
                [self performSelectorOnMainThread:@selector(login_callBack:) withObject:data waitUntilDone:YES];
            }
            else{
                NSLog(@"Invalid");
            }
        }];
    }
}
- (void)init1
{
    self.Reward.layer.borderColor = [UIColor blackColor].CGColor;
    self.Reward.layer.borderWidth = 1.0;
    self.Level.layer.borderColor = [UIColor blackColor].CGColor;
    self.Level.layer.borderWidth = 1.0;
    self.Pics.layer.borderColor = [UIColor blackColor].CGColor;
    self.Pics.layer.borderWidth = 1.0;
    self.reward2.layer.borderColor = [UIColor blackColor].CGColor;
    self.reward2.layer.borderWidth = 1.0;
    self.level2.layer.borderColor = [UIColor blackColor].CGColor;
    self.level2.layer.borderWidth = 1.0;
    self.pics2.layer.borderColor = [UIColor blackColor].CGColor;
    self.pics2.layer.borderWidth = 1.0;
    self.Reward3.layer.borderColor = [UIColor blackColor].CGColor;
    self.Reward3.layer.borderWidth = 1.0;
    self.Level3.layer.borderColor = [UIColor blackColor].CGColor;
    self.Level3.layer.borderWidth = 1.0;
    self.Pics3.layer.borderColor = [UIColor blackColor].CGColor;
    self.Pics3.layer.borderWidth = 1.0;
    NSString *url1 = [NSString stringWithFormat:@"%@/%@", urlPrefix1, cover1];
    //NSLog(@"%@",url1);
    NSURL *imageUrl = [NSURL URLWithString:url1];
    UIImage *image11 = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
    self.image4.image = image11;
    self.Pics.layer.borderWidth = 1.0;
    NSString *url2 = [NSString stringWithFormat:@"%@/%@", urlPrefix1, cover2];
    NSURL *imageUrl2 = [NSURL URLWithString:url2];
    UIImage *image2 = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl2]];
    self.image2.image = image2;
    NSString *url3 = [NSString stringWithFormat:@"%@/%@", urlPrefix1, cover3];
    NSURL *imageUrl3 = [NSURL URLWithString:url3];
    UIImage *image3 = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl3]];
    self.image3.image = image3;
}

//- (void)testNew2
//{
//    NSString *url = @"http://147.8.138.16:8080/ios/";
//    NSString *function = @"workerViewMission";
//    NSString *userName = @"admin";
//    NSString *password =  @"root";
//    NSString *uid =  @"4";
//    NSLog(@"workerViewMission Test");
//    //加入参数
//    NSMutableDictionary *params = [NSMutableDictionary new];
//    [params setValue:function forKey:@"function"];
//    [params setValue:userName forKey:@"email"];
//    [params setValue:password forKey:@"pwd"];
//    [params setValue:uid forKey:@"uid"];
//    //有网络才发送请求
//    if([HttpHelper NetWorkIsOK]){
//        //发送请求，并且得到返回的数据
//        [HttpHelper post:url RequestParams:params FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {//传回来的数据存在，则执行改回调函数
//            if(data){
//                //子线程通知主线程更新UI，selector中是要执行的函数，data是传给这个函数的参数
//                //login_callBack就处理返回来的消息，这里就简单的输出，登录成功
//                NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//                NSError *error = nil;
//                MissionJSON *mission = [[MissionJSON alloc] initWithString:str error:&error];
//                NSLog(@"response = %@",mission.title);
//                //self.Title = [[UILabel alloc] init];
//                //_Title.text = mission.title;
//                missionTwoTitle = mission.title;
//                missionTwoUid = mission.uid;
//                missionTwoDescription = mission.description;
//                
//                NSLog(@"set complete");
//                
//                [self performSelectorOnMainThread:@selector(login_callBack:) withObject:data waitUntilDone:YES];
//            }
//            else{
//                NSLog(@"Invalid");
//            }
//        }];
//    }
//}

- (void)login_callBack:(id)value{
    self.Title.text = missionOneTitle;
    self.Provider.text = missionOneUid;
//    self.Description.text = missionOneDescription;
    self.missionTwoTitle.text = missionTwoTitle;
    self.missionTwoProvider.text = missionTwoUid;
//    self.MissionTwoDescription.text = missionTwoDescription;
    self.missionThreeTitle.text = missionThreeTitle;
    self.missionThreeProvider.text = missionThreeUid;
//    self.missionThreeDescription.text = missionThreeDescription;
    self.type1.text = missionOneType;
    self.type2.text = missionTwoType;
    self.type3.text = missionThreeType;
    self.budget1.text = budget1;
    self.budget2.text = budget2;
    self.budget3.text = budget3;
    self.workerLevel1.text = workerlvl1;
    self.workerLevel2.text = workerlvl2;
    self.workerLevel3.text = workerlvl3;
    NSLog(@"init page");
    [self init1];
    //NSLog(@"%d",postid1);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"transfer"]) {
        NSLog(@"prepare to transfer %@",postid1);
        TagOneViewController *destViewController = segue.destinationViewController;
        destViewController.transfered = postid1;
        destViewController.transferedPosttype = missionOneType;
        
    }
    if ([segue.identifier isEqualToString:@"transfer2"]) {
        NSLog(@"prepare to transfer %@",postid2);
        TagOneViewController *destViewController = segue.destinationViewController;
        destViewController.transfered = postid2;
        destViewController.transferedPosttype = missionTwoType;
        
    }
    if ([segue.identifier isEqualToString:@"transfer3"]) {
        NSLog(@"prepare to transfer %@",postid3);
        TagOneViewController *destViewController = segue.destinationViewController;
        destViewController.transfered = postid3;
        destViewController.transferedPosttype = missionThreeType;
        
    }
    if ([segue.identifier isEqualToString:@"transferToFavor"]) {
//        NSLog(@"prepare to transfer %@",postid3);
        FavorViewController *destViewController = segue.destinationViewController;
        destViewController.transferedType1 = missionOneType;
        destViewController.transferedCover1 = [NSString stringWithFormat:@"%@/%@", urlPrefix1, cover1];
        destViewController.transferedType2 = missionTwoType;
        destViewController.transferedCover2 = [NSString stringWithFormat:@"%@/%@", urlPrefix1, cover2];
        destViewController.transferedType3 = missionThreeType;
        destViewController.transferedCover3 = [NSString stringWithFormat:@"%@/%@", urlPrefix1, cover3];
        flag1 = @"YES";
        destViewController.transferedFlag1= flag1;
        destViewController.transferedFlag2= flag2;
        destViewController.transferedFlag3= flag3;
        destViewController.transferedPostid1 = postid1;
        destViewController.transferedPostType1 = missionOneType;
        destViewController.transferedPostid2 = postid2;
        destViewController.transferedPostType2 = missionTwoType;
        destViewController.transferedPostid3 = postid3;
        destViewController.transferedPostType3 = missionThreeType;
    }
    if ([segue.identifier isEqualToString:@"transferToFavor2"]) {
        //        NSLog(@"prepare to transfer %@",postid3);
        FavorViewController *destViewController = segue.destinationViewController;
        destViewController.transferedType1 = missionOneType;
        destViewController.transferedCover1 = [NSString stringWithFormat:@"%@/%@", urlPrefix1, cover1];
        destViewController.transferedType2 = missionTwoType;
        destViewController.transferedCover2 = [NSString stringWithFormat:@"%@/%@", urlPrefix1, cover2];
        destViewController.transferedType3 = missionThreeType;
        destViewController.transferedCover3 = [NSString stringWithFormat:@"%@/%@", urlPrefix1, cover3];
        flag2 = @"YES";
        destViewController.transferedFlag1= flag1;
        destViewController.transferedFlag2= flag2;
        destViewController.transferedFlag3= flag3;
        destViewController.transferedPostid1 = postid1;
        destViewController.transferedPostType1 = missionOneType;
        destViewController.transferedPostid2 = postid2;
        destViewController.transferedPostType2 = missionTwoType;
        destViewController.transferedPostid3 = postid3;
        destViewController.transferedPostType3 = missionThreeType;
    }
    if ([segue.identifier isEqualToString:@"transferToFavor3"]) {
        //        NSLog(@"prepare to transfer %@",postid3);
        FavorViewController *destViewController = segue.destinationViewController;
        destViewController.transferedType1 = missionOneType;
        destViewController.transferedCover1 = [NSString stringWithFormat:@"%@/%@", urlPrefix1, cover1];
        destViewController.transferedType2 = missionTwoType;
        destViewController.transferedCover2 = [NSString stringWithFormat:@"%@/%@", urlPrefix1, cover2];
        destViewController.transferedType3 = missionThreeType;
        destViewController.transferedCover3 = [NSString stringWithFormat:@"%@/%@", urlPrefix1, cover3];
        flag3 = @"YES";
        destViewController.transferedFlag1= flag1;
        destViewController.transferedFlag2= flag2;
        destViewController.transferedFlag3= flag3;
        destViewController.transferedPostid1 = postid1;
        destViewController.transferedPostType1 = missionOneType;
        destViewController.transferedPostid2 = postid2;
        destViewController.transferedPostType2 = missionTwoType;
        destViewController.transferedPostid3 = postid3;
        destViewController.transferedPostType3 = missionThreeType;
    }
}



//- (IBAction)start1:(id)sender {
//    
//    [self performSegueWithIdentifier:@"transfer" sender:self];}


@end
