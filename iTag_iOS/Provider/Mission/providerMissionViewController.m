//
//  UITableViewController+MissionViewController.m
//  i-Tag_Provider
//
// Created by WENG Lili on 15/7/10
//

#import "providerMissionViewController.h"
#import "DOPNavbarMenu.h"
#import "CreateViewController.h"
#import "pWalletBalance.h"
#import "pAccountViewController.h"

@interface MissionViewController () <UITextViewDelegate, DOPNavbarMenuDelegate>

@property (assign, nonatomic) NSInteger numberOfItemsInRow;
@property (strong, nonatomic) DOPNavbarMenu *menu;

@end

@implementation MissionViewController
    NSMutableArray *tableData;
    //NSMutableArray *descrptData;
    NSMutableArray *budgetData;
    NSMutableArray *ImageData;
    NSMutableArray *PostIDData;
    NSMutableArray *deadlineData;
    NSMutableArray *typeData;
    NSMutableArray *workerlvlData;

    int ListCount;

- (DOPNavbarMenu *)menu {
    if (_menu == nil) {
        DOPNavbarMenuItem *item1 = [DOPNavbarMenuItem ItemWithTitle:@"Create" icon:[UIImage imageNamed:@"Gestures@2x.png"]];
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
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"userID: %@",_userID);
    tableData = [[NSMutableArray alloc] init];
    //descrptData = [[NSMutableArray alloc] init];
    budgetData = [[NSMutableArray alloc] init];
    PostIDData = [[NSMutableArray alloc] init];
    deadlineData = [[NSMutableArray alloc] init];
    typeData = [[NSMutableArray alloc] init];
    workerlvlData = [[NSMutableArray alloc] init];

    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"Home" style:UIBarButtonItemStyleDone target:self action:@selector(backButtonItemToDismissModal)];
    self.numberOfItemsInRow = 3;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(openMenu:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithRed:96/255.0f green:46/255.0f blue:131/255.0f alpha:1.0f];
    
    [self getMissionList];
    ImageData = [[NSMutableArray alloc] initWithObjects:@"Clipboard.png",@"Gift-Box.png",@"Mail.png", @"Map.png",@"Pocket.png",@"Retina-Ready.png",@"Toilet-Paper.png", @"Watches.png",@"Compas.png",@"Chat.png",@"Infinity-Loop.png",@"Pensils.png", nil];
}
#pragma mark - 私有 方法

- (void)backButtonItemToDismissModal{
    NSLog(@"Home");
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark 返回分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"MissionViewCell";
    
    MissionViewCell *cell;
    cell = (MissionViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier ];//forIndexPath:indexPath
    
    if (!cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MissionViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }

    cell.Reward.layer.borderColor = [UIColor blackColor].CGColor;
    cell.Reward.layer.borderWidth = 1.0;
    cell.Level.layer.borderColor = [UIColor blackColor].CGColor;
    cell.Level.layer.borderWidth = 1.0;
    cell.Pics.layer.borderColor = [UIColor blackColor].CGColor;
    cell.Pics.layer.borderWidth = 1.0;
    
    cell.nameLabel.text = [NSString stringWithFormat:@"%@",[tableData objectAtIndex:indexPath.row]];
    //cell.descriptionLabel.text = [NSString stringWithFormat:@"%@",[descrptData objectAtIndex:indexPath.row]];
    cell.budgetLabel.text = [NSString stringWithFormat:@"%@",[budgetData objectAtIndex:indexPath.row]];
    cell.imageView.image = [UIImage imageNamed:[ImageData objectAtIndex:indexPath.row]];
    cell.PostID = [PostIDData objectAtIndex:indexPath.row];
    cell.deadlineLabel.text = [NSString stringWithFormat:@"%@",[deadlineData objectAtIndex:indexPath.row]];
    cell.typeLabel.text = [NSString stringWithFormat:@"%@",[typeData objectAtIndex:indexPath.row]];
    cell.picLabel.text = [NSString stringWithFormat:@"%d",cell.deadlineLabel.text.intValue + 15];
    cell.workerlvlLabel.text = [NSString stringWithFormat:@"%@",[workerlvlData objectAtIndex:indexPath.row]];
    //cell.contentView.layer.cornerRadius = 5;
    //cell.contentView.layer.masksToBounds = YES;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"row:%d",(int)indexPath.row);
    ListCount = (int)indexPath.row;//
    NSLog(@"Listcount: %d",ListCount);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id) sender
{
    NSLog(@"prepare segue");
    if ([[segue identifier] isEqualToString:@"OverviewSegue"]) {
        [self prepareForShowDetailSegue:segue sender:sender];
    }
}
- (void)prepareForShowDetailSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    OverViewController *vc = (OverViewController *)[[segue destinationViewController] topViewController];
    MissionViewCell *cell = sender;
    vc.PostID = cell.PostID;
}

#pragma mark 加载数据
-(void)loadData:(NSData *)data{
    /*json序列化
options:序列化选项，枚举类型，但是可以指定为枚举以外的类型，例如指定为0则可以返回NSDictionary或者NSArray
    a.NSJSONReadingMutableContainers:返回NSMutableDictionary或NSMutableArray
    b.NSJSONReadingMutableLeaves：返回NSMutableString字符串
    c.NSJSONReadingAllowFragments：可以解析JSON字符串的外层既不是字典类型（NSMutableDictionary、NSDictionary）又不是数组类型（NSMutableArray、NSArray）的数据,但是必须是有效的JSON字符串
error:错误信息
    */
    NSError *error;
    //将对象序列化为字典
    _dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    NSLog(@"response = %@",_dic);
    //[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    NSArray *array = (NSArray *)_dic[@"Mission"];
    //NSString *cnt = (NSString *)_dic[@"Count"];
    //ListCount = [cnt intValue];
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        //通过KVC给对象赋值
        NSString *postid = [obj valueForKeyPath:@"PostID"];
        [PostIDData addObject:postid];
        NSLog(@"PostID = %@",PostIDData);
        
        NSArray *table = [obj valueForKeyPath:@"Title"];
        [tableData addObject:table];
        NSLog(@"tableData = %@",tableData);
        
        /*NSArray *descrpt = [obj valueForKeyPath:@"info"];
         [descrptData addObject:descrpt];
         NSLog(@"descriptData = %@",descrptData);*/
        
        NSArray *budget = [obj valueForKeyPath:@"Budget"];
        [budgetData addObject:budget];
        NSLog(@"budgetData = %@",budgetData);
        
        NSArray *deadline = [obj valueForKeyPath:@"TimeLimit"];
        [deadlineData addObject:deadline];
        NSLog(@"deadlineData = %@",deadlineData);
        
        NSArray *ptype = [obj valueForKeyPath:@"PostType"];
        [typeData addObject:ptype];
        NSLog(@"typeData = %@",typeData);
        
        NSArray *workerlvl = [obj valueForKeyPath:@"LevelLimit"];
        [workerlvlData addObject:workerlvl];
        NSLog(@"workerlvlData = %@",workerlvlData);
        
    }];
}

- (void)getMissionList
{
    NSString *url = @"http://147.8.138.16:8080/ios/";
    NSString *function = @"providerMissionList";
    //NSString *userID = _userID;
    NSLog(@"get Mission List");
    //加入参数
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:function forKey:@"function"];
    [params setValue:_userID forKey:@"UserID"];
    //有网络才发送请求
    if([HttpHelper NetWorkIsOK]){ //
        //发送请求，并且得到返回的数据
        [HttpHelper post:url RequestParams:params FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {//传回来的数据存在，则执行改回调函数
            if(data){
                //子线程通知主线程更新UI，selector中是要执行的函数，data是传给这个函数的参数
                //login_callBack就处理返回来的消息，这里就简单的输出，登录成功
                
                [self loadData:data];
                [self.tableView reloadData];
                [self performSelectorOnMainThread:@selector(login_callBack:) withObject:data waitUntilDone:YES];
            }
            else{
                NSLog(@"Invalid Data: get Mission List");
            }
        }];
    }
}
//登录的回调函数，首先判断接收的值是不是能登录。若不能，则提示用户。若能登录，则处理segue来跳转界面
- (void)login_callBack:(id)value{
    NSLog(@"get Mission List Successed");
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
        CreateViewController *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateView"];
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
