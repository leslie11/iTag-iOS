//
//  UITableViewController+OverViewController.m
//  i-Tag_Provider
//
// Created by WENG Lili on 15/7/10
//

#import "OverViewController.h"

@implementation OverViewController
    NSArray *postName;
    NSArray *budget;
    NSArray *deadline;
    NSArray *postType;
    NSArray *workerlvl;
    NSArray *descript;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"Segue PostID: %@",_PostID);
    /*postName = [[NSArray alloc] init];
    budget = [[NSArray alloc] init];
    deadline = [[NSArray alloc] init];
    postType = [[NSArray alloc] init];
    workerlvl = [[NSArray alloc] init];
    descript = [[NSArray alloc] init];*/
    
    [self getMissionOverview];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(backButtonItemToDismissModal)];
    
    /*_nameLabel.text = [NSString stringWithFormat:@"%@",postName];
    _budgetLabel.text = [NSString stringWithFormat:@"%@",budget];
    _deadlineLabel.text = [NSString stringWithFormat:@"%@",deadline];
    _postTypeLabel.text = [NSString stringWithFormat:@"%@",postType];
    _workerlvlLabel.text = [NSString stringWithFormat:@"%@",workerlvl];
    _descriptTextView.text = [NSString stringWithFormat:@"%@",descript];*/
}

- (void)backButtonItemToDismissModal{
    NSLog(@"Back");
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 加载数据
-(void)loadData:(NSData *)data
{
    postName = [[NSArray alloc] init];
    budget = [[NSArray alloc] init];
    deadline = [[NSArray alloc] init];
    postType = [[NSArray alloc] init];
    workerlvl = [[NSArray alloc] init];
    descript = [[NSArray alloc] init];
    /*json序列化
options:序列化选项，枚举类型，但是可以指定为枚举以外的类型，例如指定为0则可以返回NSDictionary或者NSArray
    a.NSJSONReadingMutableContainers:返回NSMutableDictionary或NSMutableArray
    b.NSJSONReadingMutableLeaves：返回NSMutableString字符串
    c.NSJSONReadingAllowFragments：可以解析JSON字符串的外层既不是字典类型（NSMutableDictionary、NSDictionary）又不是数组类型（NSMutableArray、NSArray）的数据,但是必须是有效的JSON字符串
error:错误信息
    */
    NSError *error;
    //将对象序列化为字典
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    NSLog(@"response = %@",dic);
    //[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    NSArray *array = (NSArray *)dic[@"MissionInfo"];
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        //通过KVC给对象赋值
        
        postName = [obj valueForKeyPath:@"Title"];
        NSLog(@"postName = %@",postName);
        //_nameLabel.text = [NSString stringWithFormat:@"%@",postName];
        
        budget = [obj valueForKeyPath:@"Budget"];
        NSLog(@"budget = %@",budget);
        //_budgetLabel.text = [NSString stringWithFormat:@"%@",budget];
        
        deadline = [obj valueForKeyPath:@"TimeLimit"];
        NSLog(@"deadline = %@",deadline);
        //_deadlineLabel.text = [NSString stringWithFormat:@"%@",deadline];

        postType = [obj valueForKeyPath:@"PostType"];
        NSLog(@"postType = %@",postType);
        //_postTypeLabel.text = [NSString stringWithFormat:@"%@",postType];
        
        workerlvl = [obj valueForKeyPath:@"LevelLimit"];
        NSLog(@"workerlvl = %@",workerlvl);
        //_workerlvlLabel.text = [NSString stringWithFormat:@"%@",workerlvl];

        descript = [obj valueForKeyPath:@"info"];
        NSLog(@"descript = %@",descript);
        //_descriptTextView.text = [NSString stringWithFormat:@"%@",descript];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            /* Do UI work here */
            _nameLabel.text = [NSString stringWithFormat:@"%@",postName];
            _budgetLabel.text = [NSString stringWithFormat:@"%@",budget];
            _deadlineLabel.text = [NSString stringWithFormat:@"%@",deadline];
            _postTypeLabel.text = [NSString stringWithFormat:@"%@",postType];
            _workerlvlLabel.text = [NSString stringWithFormat:@"%@",workerlvl];
            _descriptTextView.text = [NSString stringWithFormat:@"%@",descript];
        });
    }];
}

- (void)getMissionOverview
{
    NSString *url = @"http://147.8.138.16:8080/ios/";
    NSString *function = @"providerMissionOverview";
    NSString *postID = _PostID;
    NSLog(@"get Mission Overview");
    //加入参数
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:function forKey:@"function"];
    [params setValue:postID forKey:@"PostID"];
    //有网络才发送请求
    if([HttpHelper NetWorkIsOK]){ //
        //发送请求，并且得到返回的数据
        [HttpHelper post:url RequestParams:params FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {//传回来的数据存在，则执行改回调函数
            if(data){
                //子线程通知主线程更新UI，selector中是要执行的函数，data是传给这个函数的参数
                //login_callBack就处理返回来的消息，这里就简单的输出，登录成功
                //NSError *error;
                //将对象序列化为字典
                //NSString *string = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                //NSLog(@"response = %@",string);
                //[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
                [self loadData:data];
                [self performSelectorOnMainThread:@selector(login_callBack:) withObject:data waitUntilDone:YES];
            }
            else{
                NSLog(@"Invalid Data: get Mission Overview");
            }
        }];
    }
}
//登录的回调函数，首先判断接收的值是不是能登录。若不能，则提示用户。若能登录，则处理segue来跳转界面
- (void)login_callBack:(id)value{
    NSLog(@"get Mission Overview Successed");
}

@end
